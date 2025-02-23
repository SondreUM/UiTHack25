FROM rust:1.85 AS builder

WORKDIR /home/
RUN mkdir ./src/
RUN mkdir ./src/cross-eyed
RUN mkdir ./src/cross-eyed/src
RUN mkdir ./src/cross-eyed-local
RUN mkdir ./src/cross-eyed-local/src

WORKDIR /home/src/cross-eyed
COPY ./src/cross-eyed/src/main.rs ./src/main.rs
COPY ./src/cross-eyed/Cargo.toml ./Cargo.toml
RUN cargo build --release

WORKDIR /home/src/cross-eyed-local
COPY ./src/cross-eyed-local/src/main.rs ./src/main.rs
COPY ./src/cross-eyed-local/Cargo.toml ./Cargo.toml
RUN cargo build --release




FROM debian:bookworm-slim

RUN apt update
RUN apt install -y chromium

WORKDIR /usr/src/app

COPY --from=builder /home/src/cross-eyed/target/release/cross-eyed ./
COPY ./src/cross-eyed/src/static ./static
COPY --from=builder /home/src/cross-eyed-local/target/release/cross-eyed-local ./
COPY ./src/cross-eyed-local/src/static ./static-local

COPY ./src/start.sh ./start.sh
RUN chmod +x ./start.sh

RUN useradd -ms /bin/bash app
USER app
ENV ROCKET_ADDRESS="0.0.0.0"

CMD ["sh", "./start.sh"]


# docker build . -t cross-eyed
# docker run -p 8000:8000 cross-eyed
