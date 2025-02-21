#[macro_use]
extern crate rocket;

use rocket::fs::{relative, FileServer};
use rocket::serde::{json::Json, Deserialize};

use rand::distr::{Alphanumeric, SampleString};

const FLAG: &str = "UiTHack25{ReadingOutsideTheBox}";
const PONG_MESSAGE: &str = "Pong: ";

#[derive(Deserialize)]
#[serde(crate = "rocket::serde")]
struct Ping<'r> {
    message: &'r str,
    length: usize,
    timestamp: &'r str,
}

#[post("/ping", data = "<ping>")]
fn ping(ping: Json<Ping<'_>>) -> Result<String, &str> {
    let mut return_buffer = String::with_capacity(4096);

    if ping.message.len() >= 2048 {
        return Err("Message too long.");
    }

    if ping.length >= 4096 {
        return Err("Message length out of bounds.");
    }

    return_buffer.push_str(PONG_MESSAGE);

    return_buffer.push_str(ping.message);

    return_buffer.push_str(&Alphanumeric.sample_string(&mut rand::rng(), 16));

    return_buffer.push_str(FLAG);

    return_buffer.push_str(&Alphanumeric.sample_string(
        &mut rand::rng(),
        return_buffer.capacity() - return_buffer.len(),
    ));

    let return_length: usize = (ping.length + PONG_MESSAGE.len()).into();

    Ok(String::from(&return_buffer[0..return_length]))
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .mount("/", routes![ping])
        .mount("/", FileServer::from(relative!("src/static")))
}
""
