#!/bin/bash

export DOCKER_BUILDKIT=1

docker buildx build --platform linux/amd64 -t martinbouillaud/borgbackup-server .
docker tag martinbouillaud/borgbackup-server martinbouillaud/borgbackup-server:latest
docker push martinbouillaud/borgbackup-server:latest