FROM ubuntu:22.04
LABEL Description="UiTHack25 Commlink"

RUN useradd -d /home/ctf -m -p ctf -s /bin/bash ctf
WORKDIR /home/ctf

COPY commlink .
COPY ynetd .
COPY flag.txt .

RUN chown -R root:root /home/ctf
RUN chmod -R a+rx /home/ctf

USER ctf
CMD ["./ynetd", "-p", "9000", "./commlink Ch33s3burg3r"]

# docker build -t commlink .
# docker run -dp 9000:9000 -it --rm commlink