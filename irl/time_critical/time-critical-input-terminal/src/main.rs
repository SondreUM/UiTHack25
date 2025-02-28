#[macro_use]
extern crate rocket;

use std::thread::current;

use rocket::{State, fs::NamedFile};
use totp_rs::{Algorithm, Secret, TOTP};

#[get("/")]
async fn get_index() -> Result<NamedFile, std::io::Error> {
    NamedFile::open("src/index.html").await
}

#[get("/index.css")]
async fn get_index_css() -> Result<NamedFile, std::io::Error> {
    NamedFile::open("src/index.css").await
}

#[get("/index.js")]
async fn get_index_js() -> Result<NamedFile, std::io::Error> {
    NamedFile::open("src/index.js").await
}

#[get("/flag/<code>")]
fn get_flag(code: &str) -> String {
    let totp = TOTP::new(
        Algorithm::SHA1,
        6,
        1,
        30,
        Secret::Raw("xXxUiTHack-VerySecretxXx".as_bytes().to_vec())
            .to_bytes()
            .unwrap(),
    )
    .unwrap();

    let current_code = totp.generate_current().unwrap();

    if code == current_code {
        "UitHack{GotTheTOTPThisTime}".to_string()
    } else {
        "Invalid code".to_string()
    }
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount(
        "/",
        routes![get_index, get_index_css, get_index_js, get_flag],
    )
}
