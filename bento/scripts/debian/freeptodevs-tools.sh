#!/bin/bash -eux

apt-get install -y debian-keyring debian-archive-keyring \
    build-essential git openssh-server live-build live-config \
    live-tools apt-cacher-ng zsh debootstrap devscripts equivs \
    psmisc psutils vim less most screen lsof htop strace ltrace \
    iotop tig live-boot-doc live-config-doc byobu \
    live-manual-txt nethogs dnsutils
