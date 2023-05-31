FROM kalilinux/kali-rolling

LABEL maintainer="Flavien PERIER <perier@flavien.io>" \
      version="1.0.0" \
      description="Kali linux sandbox"

ARG DOCKER_UID="500" \
    DOCKER_GID="500"

ENV PASSWORD="password" \
    SHODAN_KEY="key"

WORKDIR /root
VOLUME /home/admin

COPY --chown=root:root start.sh start.sh

RUN apt-get update && apt-get install -y sudo git curl openssh-client openssh-server \
            nmap crunch aircrack-ng john nikto nuclei wapiti && \
    groupadd -g $DOCKER_GID admin && \
    useradd -g admin -m -u $DOCKER_UID admin && \
    echo "admin ALL=(ALL:ALL) ALL" >> /etc/sudoers && \
    curl -s https://raw.githubusercontent.com/flavien-perier/linux-shell-configuration/master/linux-shell-configuration.sh | bash - && \
    /etc/init.d/ssh stop && \
    mkdir /run/sshd && \
    rm -rf /var/lib/apt/lists/* && \
    chmod 750 start.sh

EXPOSE 22

CMD ./start.sh
