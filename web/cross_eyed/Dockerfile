FROM rust:1.85 AS builder

RUN mkdir -p /home/src/cross-eyed/src /home/src/cross-eyed-local/src

WORKDIR /home/src/cross-eyed
COPY ./src/cross-eyed .
RUN cargo build --release

WORKDIR /home/src/cross-eyed-local
COPY ./src/cross-eyed-local .
RUN cargo build --release

# production image
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends chromium && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY --from=builder /home/src/cross-eyed/target/release/cross-eyed \
    /home/src/cross-eyed-local/target/release/cross-eyed-local ./

# Copy static assets and startup script
COPY ./src/cross-eyed/src/static ./static
COPY ./src/cross-eyed-local/src/static ./static-local
COPY ./src/start.sh .

RUN chmod a+x ./start.sh
RUN useradd -ms /bin/bash app
USER app

ENV ROCKET_ADDRESS="0.0.0.0"
EXPOSE 8000

CMD ["bash", "./start.sh"]

# docker build . -t cross-eyed
# docker run -p 8000:8000 cross-eyed