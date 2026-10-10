# syntax=docker/dockerfile:1.7
FROM ubuntu:latest

# Only what mise itself needs; everything else comes from `mise bootstrap`.
RUN apt-get update && \
    apt-get install -y curl git ca-certificates sudo && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1001 -s /bin/bash testuser && \
    echo 'testuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER testuser
WORKDIR /home/testuser
ENV PATH="/home/testuser/.local/bin:${PATH}"

RUN curl -fsSL https://mise.run | sh

COPY --chown=testuser:testuser . /home/testuser/.dotfiles/

RUN --mount=type=secret,id=MISE_GITHUB_TOKEN,uid=1001,gid=1001,mode=0400 \
    if [ -f /run/secrets/MISE_GITHUB_TOKEN ]; then export MISE_GITHUB_TOKEN="$(cat /run/secrets/MISE_GITHUB_TOKEN)"; fi && \
    cd /home/testuser/.dotfiles && mise trust && mise bootstrap --yes && \
    mise bootstrap status --missing && mise dot status

CMD ["/bin/bash", "-l"]
