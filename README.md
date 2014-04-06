Freepto-vagrant
===============

Easy way for create a Freepto development environment


## Usage

#### Vagrant setup:

Install Vagrant 1.5.1:

   http://www.vagrantup.com/

<code>$ sudo apt-get install git virtualbox</code>

<code>$ git clone https://github.com/vinc3nt/freepto-vagrant.git</code>

<code>$ cd freepto-vagrant</code>

<code>$ vagrant up vbox</code>

<code>$ vagrant ssh vbox</code>


#### Build Freepto:

<code>$ sudo vim /etc/freeptobuild.cfg</code>

<code>$ sudo freeptobuild /home/vagrant/freepto-lb</code>


#### Build from another repository:

<code>$ git clone https://github.com/vinc3nt/freepto-lb.git freepto-lb_vinc3nt</code>

<code>$ sudo freeptobuild /home/vagrant/freepto-lb_vinc3nt</code>


#### Add libvirt support:

Install KVM, qemu and libvirt:

  https://wiki.debian.org/KVM
  https://wiki.debian.org/QEMU
  https://wiki.debian.org/libvirt

<code>$ sudo apt-get install libxslt-dev libxml2-dev libvirt-dev rsync</code>

<code>$ vagrant plugin install vagrant-libvirt</code>

<code>$ vagrant up kvm --provider=libvirt</code>

<code>$ vagrant ssh kvm</code>

## Creating a new custom virtualbox image

A box for VirtualBox is already available from http://dev.freepto.mx/vagrant/ but if you want create a custom VirtualBox image, you should follow these steps:

1. install packer: http://www.packer.io

2. customize provisioning scripts

3. build a new freepto-vbox.box

<code>$ cd packer</code>

<code>$ packer build --only=freepto-vbox freepto.json</code>

<code>$ vagrant box add builds/virtualbox/freepto.box --name freepto --force</code>

## Creating a new custom libvirt image

A box for libvirt is already available from http://dev.freepto.mx/vagrant/ but if you want create a custom libvirt image, you should follow these steps:

<code>$ cd packer</code>

<code>$ packer build -only=freepto-qemu freepto.json</code>

<code>$ ./raw2box.sh</code>

<code>$ vagrant box add builds/libvirt/freepto.box --name freepto --force</code>

## Update an existing vagrant box

<code>$ vagrant box list</code>

<code>$ vagrant box repackage --output freepto-vbox.box ${boxname}</code>
