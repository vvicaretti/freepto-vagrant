#!/bin/bash
echo "==> freepto: installing freeptobuild tool..."
install -o root -g root -m 744 /vagrant/provisioning/freeptobuild /usr/local/bin/freeptobuild
install -o root -g root -m 644 /vagrant/provisioning/freeptobuild.cfg /etc/freeptobuild.cfg

echo "==> freepto: installing custom configuration file..."
install -o root -g root -m 644 /vagrant/provisioning/gitconfig /etc/gitconfig
install -o root -g root -m 644 /vagrant/provisioning/zshrc.local /etc/zsh/zshrc.local
install -o root -g root -m 644 /vagrant/provisioning/zshrc /etc/zsh/zshrc
install -o vagrant -g vagrant -m 644 /vagrant/provisioning/.zshrc /home/vagrant/.zshrc
chsh -s /usr/bin/zsh vagrant
chsh -s /usr/bin/zsh root

echo "==> freepto: cloning AvANa git repository..."
git clone https://github.com/AvANa-BBS/freepto-lb /home/vagrant/freepto-lb

echo "freepto-dev is ready"
