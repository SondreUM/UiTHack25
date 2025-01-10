FROM nginx

LABEL category="misc"
LABEL source="UiTHack25"
LABEL version="1.0"
LABEL description="Knock Knock"
LABEL author="@Deki"

WORKDIR /usr/src/app

# app ports
EXPOSE 80
EXPOSE 4837
EXPOSE 53254
EXPOSE 1337

# install more_headers module for nginx
# RUN apt -y update && apt -y upgrade
# RUN apt install nginx-plus-module-headers-more

# Replace the default nginx configuration with our own
COPY ./nginx.conf /etc/nginx/nginx.conf

# install pip, set up venv, install python dependencies
RUN apt update && apt install -y python3-pip python3.11-venv
RUN python3 -m venv knock-venv
COPY ./requirements.txt /usr/src/app/requirements.txt
RUN knock-venv/bin/pip install -r requirements.txt

# copy flask app and start script
COPY ./app.py /usr/src/app/app.py
COPY ./start.sh /usr/src/app/start.sh

# start nginx and gunicorn
CMD ["/usr/bin/bash", "./start.sh"]

# docker build -t knock-knock .
# docker run -p 80:80 -p 4837:4837 -p 53254:53254 -p 1337:1337 --rm -t knock-knock