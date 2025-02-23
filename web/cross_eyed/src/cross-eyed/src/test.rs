use std::io::{self, BufRead};
use std::sync::mpsc::{self, TryRecvError};
use std::thread;
use std::time::Duration;

fn main() {
    println!("Press enter to terminate the child thread");
    let (tx, rx) = mpsc::channel();

    thread::spawn(move || loop {
        println!("Working...");
        thread::sleep(Duration::from_millis(500));
        match rx.try_recv() {
            Ok(_) | Err(TryRecvError::Disconnected) => {
                println!("Terminating.");
                break;
            }
            Err(TryRecvError::Empty) => {}
        }
    });

    let mut line = String::new();
    let stdin = io::stdin();
    let _ = stdin.lock().read_line(&mut line);

    let _ = tx.send(());
}
