use headless_chrome::protocol::cdp::Page;
use headless_chrome::{Browser, LaunchOptions, Tab};
use rand::Rng;
use rocket::State;
use std::collections::{hash_map, HashMap};
use std::ffi::OsStr;
use std::fmt;
use std::sync::mpsc::{self, Receiver, Sender, TryRecvError};
use std::sync::{Arc, Mutex, RwLock};
use std::thread;
use std::time::Duration;

#[macro_use]
extern crate rocket;

use rocket::fs::FileServer;

struct UserSession {
    session_id: u64,
    messages: Vec<String>,
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

#[get("/messages/<session_id>/messages.json")]
fn get_messages_json(session_id: u64, app_state: &State<AppState>) -> Option<String> {
    let user_session = match app_state
        .user_sessions
        .read()
        .expect("Failed to read user sessions")
        .get(&session_id)
    {
        Some(user_session) => user_session.clone(),
        None => return None,
    };

    let messages = user_session.lock().unwrap().messages.clone();

    Some(serde_json::to_string(&messages).unwrap())
}

#[post("/messages/<session_id>", data = "<body>")]
fn post_message(session_id: u64, app_state: &State<AppState>, body: String) -> Option<String> {
    let user_session = match app_state
        .user_sessions
        .read()
        .expect("Failed to read user sessions")
        .get(&session_id)
    {
        Some(user_session) => user_session.clone(),
        None => return None,
    };

    let mut user_session = user_session.lock().unwrap();
    let message = String::from(body);
    user_session.messages.push(message);

    Some(serde_json::to_string(&user_session.messages).unwrap())
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

    let mut user_session = user_session.lock().unwrap();

    let browser = Browser::new(LaunchOptions {
        args: vec![&OsStr::new("--disable-xss-auditor")],
        port: Some(9967),
        sandbox: false,
        ..Default::default()
    })
    .expect("Failed to launch browser");
    let tab = browser.new_tab().expect("Failed to create tab");

    tab.navigate_to(&format!(
        "http://localhost:9000/local.html?session_id={session_id}"
    ))
    .expect("Failed to navigate");
    std::thread::sleep(Duration::from_millis(1000)); // Wait for rendering

    _ = tab.evaluate(
        &format!(
            "messages = {}; displayMessages(messages);",
            serde_json::to_string(&user_session.messages).unwrap()
        ),
        false,
    );

    std::thread::sleep(Duration::from_millis(500)); // Wait for rendering

    let screenshot = tab
        .capture_screenshot(Page::CaptureScreenshotFormatOption::Png, None, None, true)
        .expect("Failed to capture screenshot");

    Some(screenshot)
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

    app_state
        .user_sessions
        .write()
        .expect("Failed to write user sessions")
        .insert(
            new_session_id,
            Arc::new(Mutex::new(UserSession {
                session_id: new_session_id,
                messages: Vec::new(),
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
        .mount(
            "/",
            routes![get_stream, get_new_stream, get_messages_json, post_message],
        )
        .mount("/", FileServer::from("/usr/src/app/static"))
}
