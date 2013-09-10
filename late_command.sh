#!/bin/bash

# passwordless sudo
echo "%sudo   ALL=NOPASSWD: ALL" >> /etc/sudoers

# public ssh key for vagrant user
mkdir /home/vagrant/.ssh
wget -O /home/vagrant/.ssh/authorized_keys "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub"
chmod 755 /home/vagrant/.ssh
chmod 644 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

# speed up ssh
echo "UseDNS no" >> /etc/ssh/sshd_config

# get chef 10.16.6
gem install net-ssh -v 2.2.2 --no-ri --no-rdoc
gem install net-ssh-gateway -v 1.1.0 --no-ri --no-rdoc --ignore-dependencies
gem install net-ssh-multi -v 1.1.0 --no-ri --no-rdoc --ignore-dependencies
gem install chef --version 10.16.6 --no-ri --no-rdoc --conservative

# display login promt after boot
sed "s/quiet splash//" /etc/default/grub > /tmp/grub
mv /tmp/grub /etc/default/grub
update-grub

# clean up
apt-get clean
