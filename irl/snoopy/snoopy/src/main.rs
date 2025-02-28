use std::time::Duration;
use std::{net::UdpSocket, thread::sleep};

fn main() -> ! {
    let socket: UdpSocket = UdpSocket::bind("0.0.0.0:34254").expect("Failed to bind socket");
    socket
        .set_read_timeout(Some(Duration::new(5, 0)))
        .expect("Failed to set read timeout");
    socket.set_broadcast(true).expect("Failed to set broadcast");
    println!("Connected on port {}", 25550);
    println!("Broadcast: {:?}", socket.broadcast());
    println!("Timeout: {:?}", socket.read_timeout());

    let flag = String::from("UiTHack25{PacketsAreNotPrivate}");

    loop {
        socket
            .send_to(flag.as_bytes(), "255.255.255.255:0")
            .expect("Failed to send flag");

        sleep(std::time::Duration::from_millis(10000));
    }
}
