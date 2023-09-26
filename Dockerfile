ARG BASE_IMAGE=debian:trixie-slim
FROM $BASE_IMAGE

# Volume for SSH-Keys
VOLUME /sshkeys

# Volume for borg repositories
VOLUME /backup

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-cache policy borgbackup && apt-get -y --no-install-recommends install \
		borgbackup openssh-server && apt-get clean && \
		useradd -s /bin/bash -m -U borg && \
		mkdir /home/borg/.ssh && \
		chmod 700 /home/borg/.ssh && \
		chown borg:borg /home/borg/.ssh && \
		mkdir /run/sshd && \
		rm -f /etc/ssh/ssh_host*key* && \
		rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

COPY ./files/run.sh /run.sh
COPY ./files/sshd_config /etc/ssh/sshd_config
COPY ./files/borgmatic.config.yaml /home/borg/.borgmatic.conf.yaml

ENTRYPOINT /run.sh

# Default SSH-Port for clients
EXPOSE 22
