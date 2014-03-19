#!/bin/bash

# install freeptobuild
install -o root -g root -m 744 /vagrant/provisioning/freeptobuild /usr/local/bin/freeptobuild
install -o vagrant -g vagrant -m 644 /vagrant/provisioning/freeptobuild.cfg /home/vagrant/freeptobuild.conf

# TODO: clone git default (from AvANa-BBS)
