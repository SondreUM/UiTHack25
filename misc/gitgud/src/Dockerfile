FROM ubuntu:22.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install essential tools
RUN apt-get update && apt-get install -y \
    git \
    openssh-client \
    bash

# Install GitHub CLI
RUN (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
    && sudo mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y

# Create working directory
RUN mkdir /challenge
WORKDIR /challenge

# Copy setup script
COPY mkrepo.sh /challenge/mkrepo.sh
RUN chmod +x /challenge/setup.sh

# volume for output
VOLUME /challenge/output

# Setup SSH directory
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
# add ssh key with write permission
ENV GITHUB_REPO="git@github.com:SondreUM/UiTHack25-gitgud.git"
# Private key for read/write access
ENV GITHUB_RW=""

# Provide the private key to challenge participants
# generate with
# ssh-keygen -t ed25519 -f ./deployment_key -N "" -C "UiTHack25-ai@example.com"
ENV GITHUB_RO=""


ENTRYPOINT ["/challenge/mkrepo.sh"]

# docker build -t gitgud .
# docker run -it --rm -e GITHUB_TOKEN=$GITHUB_TOKEN gitgud