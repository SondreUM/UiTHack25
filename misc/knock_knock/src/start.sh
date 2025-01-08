#!/bin/bash

# start nginx
service nginx start

# start flask app
knock-venv/bin/gunicorn -b 0.0.0.0:8080 app:app