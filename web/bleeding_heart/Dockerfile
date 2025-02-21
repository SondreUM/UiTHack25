# Dockerfile
FROM rust:latest

LABEL description="Bleeding Heart"
LABEL category="web"
LABEL source="UiTHack25"
LABEL version="1.0"

# Copy cargo configuration
COPY bleeding-heart/Cargo.toml ./Cargo.toml

RUN cargo install

# Copy content
COPY bleeding-heart/src/* ./

RUN cargo build --release

ENV ROCKET_ADDR = "0.0.0.0"
ENV ROCKET_PORT = 8080

EXPOSE 8080

# Default command
CMD ["./bleeding-heart/target/release/bleeding-heart"]

# docker build -t big_picture .
# docker run -dp 8001:8080 -it --rm big_picture
