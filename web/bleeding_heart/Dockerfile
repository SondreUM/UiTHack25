FROM rust:latest AS builder

WORKDIR /usr/src/bleeding-heart
COPY ./bleeding-heart .
RUN cargo build --release

FROM debian:bookworm-slim

RUN apt-get update && apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*
RUN groupadd -r app && useradd -r -g app app
COPY --from=builder /usr/src/bleeding-heart/target/release/bleeding-heart /usr/local/bin/bleeding-heart
COPY --from=builder /usr/src/bleeding-heart/src/static /usr/src/bleeding-heart/src/static

LABEL description="Bleeding Heart"
LABEL category="web"
LABEL source="UiTHack25"
LABEL version="1.0"

ENV ROCKET_ADDRESS="0.0.0.0"
ENV ROCKET_PORT=8080

EXPOSE 8080

USER app
ENTRYPOINT ["/usr/local/bin/bleeding-heart"]


