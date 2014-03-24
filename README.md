Freepto-vagrant
===============

Easy way for create a Freepto development environment


## Usage

#### Vagrant setup:

<code>$ sudo apt-get install vagrant git virtualbox</code>

<code>$ git clone https://github.com/vinc3nt/freepto-vagrant.git</code>

<code>$ cd freepto-vagrant</code>

<code>$ vagrant up</code>

<code>$ vagrant ssh</code>


#### Build Freepto:

<code>$ sudo vim /etc/freeptobuild.cfg</code>

<code>$ sudo freeptobuild /home/vagrant/freepto-lb</code>


#### Build from another repository:

<code>$ git clone https://github.com/vinc3nt/freepto-lb.git freepto-lb_vinc3nt</code>

<code>$ sudo freeptobuild /home/vagrant/freepto-lb_vinc3nt</code>


#### Add libvirt support:

<code>$ sudo apt-get install libxslt-dev libxml2-dev libvirt-dev</code>

<code>$ vagrant plugin install vagrant-libvirt</code>

<code>$ vagrant up --provider=libvirt</code>

## Creating a new custom freepto.box

A freepto.box is already available from http://dev.freepto.mx/vagrant/ but if you want create a custom base box, you should follow these steps:

1. install packer: http://www.packer.io

2. customize provisioning scripts

3. build a new freepto.box

<code>$ cd packer</code>

<code>$ packer build freepto.json</code>

<code>$ vagrant box add builds/virtualbox/freepto.box --name freepto --force</code>
