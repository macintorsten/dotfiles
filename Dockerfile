# syntax=docker/dockerfile:1.7
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y git sudo vim curl unzip wget stow build-essential libssl-dev libatomic1 pkg-config figlet && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1001 -s /bin/bash testuser && \
    echo 'testuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

COPY --chown=testuser:testuser . /home/testuser/.dotfiles/

RUN cd /home/testuser/.dotfiles && BOOTSTRAP_SKIP_MISE_INSTALL=1 bash bootstrap.sh

RUN --mount=type=secret,id=MISE_GITHUB_TOKEN,uid=1001,gid=1001,mode=0400 \
    if [ -f /run/secrets/MISE_GITHUB_TOKEN ]; then export MISE_GITHUB_TOKEN="$(cat /run/secrets/MISE_GITHUB_TOKEN)"; fi && \
    cd /home/testuser/.dotfiles && bash bootstrap.sh || (echo RATE LIMITED - export MISE_GITHUB_TOKEN && sleep 10)

RUN --mount=type=secret,id=MISE_GITHUB_TOKEN,uid=1001,gid=1001,mode=0400 \
    if [ -f /run/secrets/MISE_GITHUB_TOKEN ]; then export MISE_GITHUB_TOKEN="$(cat /run/secrets/MISE_GITHUB_TOKEN)"; fi && \
    cd /home/testuser/.dotfiles && bash bootstrap.sh || (echo RATE LIMITED - export MISE_GITHUB_TOKEN && sleep 10)

RUN --mount=type=secret,id=MISE_GITHUB_TOKEN,uid=1001,gid=1001,mode=0400 \
    if [ -f /run/secrets/MISE_GITHUB_TOKEN ]; then export MISE_GITHUB_TOKEN="$(cat /run/secrets/MISE_GITHUB_TOKEN)"; fi && \
    cd /home/testuser/.dotfiles && bash bootstrap.sh && stow */

CMD ["/bin/bash"]
