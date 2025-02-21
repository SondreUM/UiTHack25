# Dockerfile
FROM rust:latest

LABEL description="Bleeding Heart"
LABEL category="web"
LABEL source="UiTHack25"
LABEL version="1.0"

COPY ./bleeding-heart ./
RUN cargo build --release

ENV ROCKET_ADDRESS="0.0.0.0"
ENV ROCKET_PORT=8080

EXPOSE 8080

CMD ["./target/release/bleeding-heart"]
