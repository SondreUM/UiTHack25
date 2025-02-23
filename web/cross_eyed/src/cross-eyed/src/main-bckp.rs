
use headless_chrome::protocol::cdp::Page;
use headless_chrome::{Browser, LaunchOptions, Tab};
use rand::Rng;
use rocket::State;
use std::collections::{hash_map, HashMap};
use std::fmt;
use std::sync::mpsc::{self, Receiver, Sender, TryRecvError};
use std::sync::{Arc, Mutex, RwLock};
use std::thread;
use std::time::Duration;

#[macro_use]
extern crate rocket;

use rocket::fs::{relative, FileServer};

struct UserSession {
    session_id: u64,
    browser: Browser,
    tab: Arc<Tab>,
}

impl fmt::Debug for UserSession {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("UserSession")
            .field("session_id", &self.session_id)
            .finish()
    }
}

#[derive(Debug)]
struct AppState {
    user_sessions: RwLock<HashMap<u64, Arc<Mutex<UserSession>>>>,
}

#[get("/stream/<session_id>/<frame>/frame.png")]
fn get_stream(session_id: u64, frame: u64, app_state: &State<AppState>) -> Option<Vec<u8>> {
    let user_session = match app_state
        .user_sessions
        .read()
        .expect("Failed to read user sessions")
        .get(&session_id)
    {
        Some(user_session) => user_session.clone(),
        None => return None,
    };

    let screenshot = user_session
        .lock()
        .expect("Failed to lock user session")
        .tab
        .capture_screenshot(Page::CaptureScreenshotFormatOption::Png, None, None, true);

    Some(screenshot.expect("Failed to get screenshot"))
}

#[get("/new-stream")]
fn get_new_stream(app_state: &State<AppState>) -> String {
    let mut rng = rand::thread_rng();
    let mut new_session_id: u64;
    loop {
        new_session_id = rng.random();
        if !app_state
            .user_sessions
            .read()
            .expect("Failed to read user sessions")
            .contains_key(&new_session_id)
        {
            break;
        }
    }

    let browser = Browser::new(LaunchOptions::default()).expect("Failed to launch browser");
    let tab = browser.new_tab().expect("Failed to create tab");

    tab.navigate_to("http://localhost:8000/local.html")
        .expect("Failed to navigate");

    app_state
        .user_sessions
        .write()
        .expect("Failed to write user sessions")
        .insert(
            new_session_id,
            Arc::new(Mutex::new(UserSession {
                session_id: new_session_id,
                browser: browser,
                tab: tab,
            })),
        );

    format!("{}", new_session_id)
}

#[launch]
fn rocket() -> _ {
    let app_state = AppState {
        user_sessions: RwLock::new(HashMap::new()),
    };

    rocket::build()
        .manage(app_state)
        .mount("/", routes![get_stream, get_new_stream])
        .mount("/", FileServer::from(relative!("src/static")))
}
