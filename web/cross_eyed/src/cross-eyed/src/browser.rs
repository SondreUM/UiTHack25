use headless_chrome::protocol::cdp::Page;
use headless_chrome::{Browser, LaunchOptions};
use std::time::Duration;
use std::tread;

#[derive(Debug)]
struct UserSession {
    id: u64,
}

fn main() {
    let browser = Browser::new(LaunchOptions::default()).expect("Failed to launch browser");
    let tab = browser.new_tab().expect("Failed to create tab");

    tab.navigate_to("https://wikipedia.org")
        .expect("Failed to navigate");
    std::thread::sleep(Duration::from_secs(5)); // Wait for rendering

    let screenshot = tab
        .capture_screenshot(Page::CaptureScreenshotFormatOption::Png, None, None, true)
        .expect("Failed to capture screenshot");

    std::fs::write("screenshot.png", screenshot).expect("Failed to save screenshot");
    println!("Screenshot saved as screenshot.png");
}
