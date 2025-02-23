FROM debian:12-slim

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install essential tools
RUN apt-get update && apt-get install -y \
    git \
    openssh-client \
    bash \
    zip

# Install GitHub CLI
RUN (type -p wget >/dev/null || ( apt update &&  apt-get install wget -y)) \
    && mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat $out |  tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt update \
    && apt install gh -y


# Create working directory
RUN mkdir -p /challenge /root/.ssh
WORKDIR /challenge



# Copy setup script
COPY mkrepo.sh /challenge/mkrepo.sh

# Copy challenge files
COPY ai/README.md ai/requirements.txt /challenge/
COPY ai/src /challenge/src

# add ssh key with write permission
ENV GITHUB_REPO="git@github.com:SondreUM/UiTHack25-gitgud.git"

# Private key for read/write access to remote repository
COPY github_rw github_rw.pub /root/.ssh/

# Provide the private key to challenge participants
# generate with
# ssh-keygen -t ed25519 -f ./deployment_key -N "" -C "UiTHack25-ai@example.com"
# ENV GITHUB_RO=""
# USER challenge
RUN chmod -R 777 /challenge /root/.ssh
RUN chown -R $whoami:$whoami /challenge

COPY deployment_key /challenge/deployment_key

# output directory
VOLUME [ "/challenge/output" ]

ENTRYPOINT ["/challenge/mkrepo.sh"]

# docker build -t gitgud .
# docker run -it --rm -v $(pwd)/output:/challenge/output:rw gitgud