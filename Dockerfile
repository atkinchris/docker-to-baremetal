FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yqq && apt-get install -yqq \
    squashfs-tools \
    systemd \
    && ln -s /lib/systemd/systemd /sbin/init

RUN apt-get update -yqq && apt-get install -y \
    task-gnome-desktop

COPY rootfs /

RUN apt-get update -yqq && apt-get -t stretch-backports install -y \
    virtualbox-guest-dkms \
	virtualbox-guest-utils \
	virtualbox-guest-x11

RUN useradd -m -s /bin/bash liveuser && passwd -d liveuser

VOLUME ["/tmp/output"]

CMD mount --bind / /mnt && \
    mksquashfs /mnt /tmp/output/filesystem.squashfs -noappend -info -e /tmp
