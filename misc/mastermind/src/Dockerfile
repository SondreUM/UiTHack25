FROM ubuntu:22.04
LABEL Description="UiTHack25 mastermind"

RUN useradd -d /home/ctf -m -p ctf -s /bin/bash ctf
WORKDIR /home/ctf

COPY ynetd .
COPY mastermind .
COPY flag.txt .

RUN chown -R root:root /home/ctf
RUN chmod -R a+rx /home/ctf

USER ctf
CMD ./ynetd -p 4444 ./mastermind

# docker build -t mastermind .
# docker run -dp 10444:4444 -it mastermind
