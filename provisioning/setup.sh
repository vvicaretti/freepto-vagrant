#!/bin/bash

echo "[Freepto] installing freepto build tool"
install -o root -g root -m 744 /vagrant/provisioning/freeptobuild /usr/local/bin/freeptobuild
install -o vagrant -g vagrant -m 644 /vagrant/provisioning/freeptobuild.cfg /etc/freeptobuild.cfg

echo "[Freepto] installing configuration file"
install -o root -g root -m 644 /vagrant/provisioning/gitconfig /etc/gitconfig
install -o root -g root -m 644 /vagrant/provisioning/zshrc.local /etc/zsh/zshrc.local
install -o root -g root -m 644 /vagrant/provisioning/zshrc /etc/zsh/zshrc

echo "[Freepto]: cloning git repository"
git clone https://github.com/AvANa-BBS/freepto-lb /home/vagrant/freepto-lb
