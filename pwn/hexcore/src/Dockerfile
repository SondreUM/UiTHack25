FROM ubuntu:22.04
LABEL Description="hexcore"
LABEL category="pwn"
LABEL source="UiTHack25"
LABEL version="1.0"

EXPOSE 9002

RUN apt-get update && \
    apt-get install -y socat bubblewrap && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" hexcore
WORKDIR /home/hexcore

COPY hexcore /usr/bin/
COPY run.sh /usr/bin/
COPY flag.txt .

RUN chown -R root:root /home/hexcore
RUN chmod -R a+rx /home/hexcore

USER hexcore
CMD ["socat", "TCP-LISTEN:9002,reuseaddr,fork,max-children=100", "EXEC:run.sh,stderr"]

# docker build -t hexcore .
# docker run -dp 9002:9002 -it --rm hexcore
