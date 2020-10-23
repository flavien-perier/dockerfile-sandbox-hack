![license](https://badgen.net/github/license/flavien-perier/dockerfile-sandbox-hack)
[![docker pulls](https://badgen.net/docker/pulls/flavienperier/sandbox-hack)](https://hub.docker.com/r/flavienperier/sandbox-hack)
[![ci status](https://badgen.net/github/checks/flavien-perier/dockerfile-sandbox-hack)](https://github.com/flavien-perier/dockerfile-sandbox-hack)

# Dockerfile Sandbox-hack

Pentest environment accessible with SSH.

## Env variables

- PASSWORD: Default sandbox password

## Ports

- 22: SSH (default username is admin)

## Volumes

- /home/admin

## Docker-compose example

```yaml
sandbox-dev:
    image: flavienperier/sandobx-hack
    container_name: sandbox-dev
    restart: always
    volumes:
      - ./documents:/home/admin
    ports:
      - 2222:22
    environment:
      PASSWORD: password
```
