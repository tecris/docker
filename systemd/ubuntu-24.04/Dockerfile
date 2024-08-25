# based on https://github.com/eniocarboni/docker-ubuntu-systemd/blob/main/Dockerfile
FROM ubuntu:24.04

RUN \
    export DEBIAN_FRONTEND=noninteractive && \
        apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y --no-install-recommends \
            software-properties-common \
            python3 \
            rsyslog \
            software-properties-common \
            systemd \
            systemd-cron \
            sudo

RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf

RUN rm -f /lib/systemd/system/systemd*udev* \
  && rm -f /lib/systemd/system/getty.target

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]

