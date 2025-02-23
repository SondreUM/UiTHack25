#[macro_use]
extern crate rocket;

use rocket::fairing::AdHoc;
use rocket::fs::{FileServer, relative};
use rocket::http::{ContentType, Header, Method};

#[launch]
fn rocket() -> _ {
    rocket::build()
        .mount("/", FileServer::from(relative!("src/static")))
        .attach(AdHoc::on_response(
            "XSS Protection Disabler",
            |_req, res| {
                Box::pin(async move {
                    res.set_header(Header::new("X-XSS-Protection", "0"));
                })
            },
        ))
}
