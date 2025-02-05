# Dockerfile
FROM node:22-alpine

WORKDIR /app

# Copy only package files first for better caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY app.js ./
COPY public ./public

ENV CTF_FLAG="UiTHack25{flag_will_be_set_at_runtime}"

EXPOSE 8002

CMD ["node", "app.js"]


# How to run with docker and a test flag

# sudo docker build -t marketplace .
# sudo docker run -p 8002:8002 -e CTF_FLAG=test{test} marketplace