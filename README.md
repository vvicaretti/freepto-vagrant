Freepto-vagrant
===============

Easy way to create a Freepto development environment


## Usage

#### Vagrant setup:

Install Vagrant 1.6.2:

*  http://www.vagrantup.com/
*  http://dev.freepto.mx/vagrant/utils/

Install Virtualbox:

<code>$ sudo apt-get install git virtualbox</code>

<code>$ git clone https://github.com/vinc3nt/freepto-vagrant.git</code>

<code>$ cd freepto-vagrant</code>

If the physical host have enough memory, the Vagrantfile should be modified in order to speedup the building process using the ramdisk.
The ram size (by default 2048) should be set to 6656 (1024 * 6 + 512). If your host doesn’t have enough memory, you can ignore the next two steps.

<code>$ vim Vagrantfile</code>

<code>$ vagrant reload</code>

<code>$ vagrant up vbox --provider=virtualbox</code>

<code>$ vagrant ssh vbox</code>


#### Build Freepto:

In order to change the building type (RAM or DISK) you should modify the freeptobuild configuration file.

<code>$ sudo vim /etc/freeptobuild.cfg</code>

<code>$ sudo freeptobuild /home/vagrant/freepto-lb</code>


#### Build from another repository:

<code>$ git clone https://github.com/vinc3nt/freepto-lb.git freepto-lb_vinc3nt</code>

<code>$ sudo freeptobuild /home/vagrant/freepto-lb_vinc3nt</code>

#### Build with a diffrent localization:

The default localization is italian, but is possible configure a different localization:

<code>$ sudo freeptobuild /home/vagrant/freepto-lb en_GB.UTF-8 Europe/London en</code>

#### Add libvirt support:

Install KVM, qemu and libvirt:

*  https://wiki.debian.org/KVM
*  https://wiki.debian.org/QEMU
*  https://wiki.debian.org/libvirt

<code>$ sudo apt-get install libxslt-dev libxml2-dev libvirt-dev</code>

vagrant-libvirt is not packaged in Debian yet ([RFP](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=753012) request), therefore you need to install it through the vagrant plugin manager.

<code>$ vagrant plugin install vagrant-libvirt --plugin-version=0.0.16</code>

Currently vagrant-libvirt support rsync as a default method for shared folder sync.
However, with rsync is possible only an uni-directional sync (physical host -> virtual machine).
In order to provide a bi-directional sync, the shared folder will be mounted with NFS.

Unfortunately, some additional configurations are needed:

<code>$ sudo apt-get install nfs-kernel-server nfs-common portmap</code>

<code>$ sudo service nfs-common start</code>

<code>$ sudo service nfs-kernel-server start</code>

<code>$ sudo service rpcbind start</code>

<code>$ vagrant up kvm --provider=libvirt</code>

<code>$ vagrant ssh kvm</code>

## Creating a new custom virtualbox image

A box for VirtualBox is already available from http://dev.freepto.mx/vagrant/ but if you want create a custom VirtualBox image, you should follow these steps:

1. Install packer: 

*  http://www.packer.io

2. Install virtualbox-guest-additions-iso

<code>$ sudo apt-get install virtualbox-guest-additions-iso</code>

3. Customize provisioning scripts

4. Build a new freepto-vbox.box

<code>$ cd packer</code>

<code>$ packer build --only=freepto-vbox freepto.json</code>

<code>$ vagrant box add builds/virtualbox/freepto-vbox.box --name freepto --force</code>

## Creating a new custom libvirt image

A box for libvirt is already available from http://dev.freepto.mx/vagrant/ but if you want create a custom libvirt image, you should follow these steps:

<code>$ cd packer</code>

<code>$ packer build --only=freepto-libvirt freepto.json</code>

<code>$ ./raw2box.sh</code>

<code>$ vagrant box add builds/libvirt/freepto-libvirt.box --name freepto-libvirt --force</code>

## Update an existing vagrant box

<code>$ vagrant status</code>

<code>$ vagrant box package --output ${boxname} ${boxname}.box</code>

<code>$ vagrant box add ${boxname}.box --name ${boxname} --force</code>

## NOTE:

Tested with the following software relases:

<code>$ vboxmanage --version</code>

4.3.10_Debianr93012

<code>$ vagrant -v</code>

Vagrant 1.6.2

<code>$ vagrant plugin list | grep vagrant-libvirt</code>

vagrant-libvirt (0.0.16)

<code>$ cat /etc/debian_version</code>

jessie/sid
