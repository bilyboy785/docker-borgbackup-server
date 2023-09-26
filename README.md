# Docker BorgBackup Server

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)  [![Docker](https://badgen.net/badge/icon/docker?icon=docker&label)](https://hub.docker.com/repository/docker/martinbouillaud/borgbackup-server/general) [![Docker Pulls](https://badgen.net/docker/pulls/martinbouillaud/borgbackup-server?icon=docker&label=pulls)](https://hub.docker.com/r/martinbouillaud/borgbackup-server:latest)  [![Docker Image Size](https://img.shields.io/docker/image-size/martinbouillaud/borgbackup-server?sort=date)](https://hub.docker.com/r/martinbouillaud/borgbackup-server/) [![Github last-commit](https://img.shields.io/github/last-commit/bilyboy785/docker-borgbackup-server)](https://github.com/bilyboy785/docker-borgbackup-server) ![Build & Push](https://github.com/bilyboy785/docker-borgbackup-server/actions/workflows/build-push.yml/badge.svg)

## Images
 * [borgbackup-server:latest](https://hub.docker.com/layers/martinbouillaud/borgbackup-server/latest/images/sha256-90760dc36730d7f94ebe736db8d37ef2f0c45828728fcf46aa5335f260deca3b?context=repo) (Available for amd64 and arm64)

## Prepare your environment
```
mkdir -p $HOME/dockers/borgbackup-server/{backup,sshkeys}
mkdir -p $HOME/dockers/borgbackup-server/sshkeys/clients
```

Add your public SSH Key in the clients folder. Note that name of this key will be the repository name : 

```
touch $HOME/dockers/borgbackup-server/sshkeys/clients/macbookpro-perso ## add your public key in this file
```
## Environment variables
| Environment  |  Default value  |  Description |
|---|---|---|
| BORG_SERVE_ARGS  |  Empty | See [Documentation](https://borgbackup.readthedocs.io/en/stable/usage/serve.html)  |
| BORG_APPEND_ONLY | No  |  If set to "yes", only the BORG_ADMIN can delete/prune the other clients archives/repos |
| BORG_ADMIN  | Empty  |  Filename of Admins SSH-Key; has full access to all repos |
## Run the docker with CLI

```
docker run -d --name=borgbackup-server -e TZ="Europe/Paris" -e BORG_SERVE_ARGS='' -e BORG_APPEND_ONLY=no -e BORG_ADMIN='' -v $HOME/dockers/borgbackup-server/backup:/backup:rw -v $HOME/dockers/borgbackup-server/sshkeys:/sshkeys:rw martinbouillaud/borgbackup-server:latest
```
## Run the docker with compose
```
version: '3'
services:
 borgserver:
  restart: always
  image: martinbouillaud/borgbackup-server:latest
  volumes:
    - $HOME/dockers/borgbackup-server/backup:/backup
    - $HOME/dockers/borgbackup-server/sshkeys:/sshkeys
  ports:
    - "2222:22"
  environment:
    BORG_SERVE_ARGS: ""
    BORG_APPEND_ONLY: "no"
    BORG_ADMIN: ""
```