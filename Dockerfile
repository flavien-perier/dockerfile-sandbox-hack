FROM kalilinux/kali-rolling

LABEL org.opencontainers.image.title="Sandbox hack" \
      org.opencontainers.image.description="Kali hack sandbox" \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.vendor="flavien.io" \
      org.opencontainers.image.maintainer="Flavien PERIER <perier@flavien.io>" \
      org.opencontainers.image.url="https://github.com/flavien-perier/dockerfile-sandbox-hack" \
      org.opencontainers.image.source="https://github.com/flavien-perier/dockerfile-sandbox-hack" \
      org.opencontainers.image.licenses="MIT"

ARG DOCKER_UID="1000" \
    DOCKER_GID="1000"

ENV PASSWORD="password" \
    SHODAN_KEY="key"

WORKDIR /root
VOLUME /home/admin

RUN apt-get update && apt-get install -y sudo git curl openssh-client openssh-server \
            nmap crunch aircrack-ng john nikto nuclei wapiti && \
    groupadd -g $DOCKER_GID admin && \
    useradd -g admin -m -u $DOCKER_UID admin && \
    echo "admin ALL=(ALL:ALL) ALL" >> /etc/sudoers && \
    curl -s https://raw.githubusercontent.com/flavien-perier/linux-shell-configuration/master/linux-shell-configuration.sh | bash - && \
    /etc/init.d/ssh stop && \
    mkdir /run/sshd && \
    rm -rf /var/lib/apt/lists/*

COPY --chown=root:root --chmod=500 start.sh start.sh

EXPOSE 22

CMD ./start.sh
