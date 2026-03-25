FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y git sudo vim curl unzip wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash testuser && \
    echo 'testuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

COPY --chown=testuser:testuser . /home/testuser/.dotfiles/

RUN cd /home/testuser/.dotfiles && bash bootstrap.sh && stow */

CMD ["/bin/bash"]
