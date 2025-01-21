FROM ubuntu:22.04
LABEL description="SC0"
LABEL category="pwn"
LABEL source="UiTHack25"
LABEL version="1.0"

RUN useradd -d /home/ctf -m -p ctf -s /bin/bash ctf
WORKDIR /home/ctf

COPY sc0 .
COPY ynetd .
COPY flag.txt .

RUN chown -R root:root /home/ctf
RUN chmod -R a+rx /home/ctf

USER ctf
CMD ["./ynetd", "-p", "9001", "./sc0"]

# docker build -t sc0 .
# docker run -dp 9001:9001 -it --rm sc0