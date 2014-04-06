# -*- mode: ruby -*-
# vi: set ft=ruby :

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # avoids 'stdin: is not a tty' error.
  config.ssh.private_key_path = ["#{ENV['HOME']}/.ssh/id_rsa","#{ENV['HOME']}/.vagrant.d/insecure_private_key"]
  config.vm.provision "shell", inline: <<-SCRIPT
    printf "%s\n" "#{File.read("#{ENV['HOME']}/.ssh/id_rsa.pub")}" > /home/vagrant/.ssh/authorized_keys
    chown -R vagrant:vagrant /home/vagrant/.ssh
  SCRIPT

  config.vm.define "vbox" do|vbox|
    vbox.vm.synced_folder "sync/", "/vagrant"
    vbox.vm.box = "freepto-vbox"
    vbox.vm.box_url = "http://dev.freepto.mx/vagrant/virtualbox/freepto-vbox.box"
    vbox.vm.provider "virtualbox" do |vb|
    # if BUILD_TYPE is ram, you should be set the ram size
    # to 6656 (1024 * 6 + 512)
    # vb.customize ["modifyvm", :id, "--memory", "6656"]
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
      vb.gui = false
    end
  end
  config.vm.define "kvm" do |kvm|
    kvm.vm.box = "freepto-libvirt"
    kvm.vm.box_url = "http://dev.freepto.mx/vagrant/libvirt/freepto-libvirt.box"
    kvm.vm.synced_folder "sync/", "/vagrant", :nfs => true, :mount_options => ['rw', 'vers=3', 'tcp']
    kvm.vm.provider "libvirt" do |domain|
      # https://github.com/pradels/vagrant-libvirt
      domain.disk_bus = 'ide'
      # if BUILD_TYPE is ram, you should be set the ram size
      # to 6656 (1024 * 6 + 512)
      # domain.memory = 6656
      domain.memory = 2048
      domain.cpus = 1
      # https://github.com/torvalds/linux/blob/master/Documentation/virtual/kvm/nested-vmx.txt
      domain.nested = false
      # Controls the cache mechanism. Possible values are "default", "none", "writethrough", "writeback", "directsync" and "unsafe"
      # http://libvirt.org/formatdomain.html#elementsDisks
      domain.volume_cache = 'none'
      # Arguments passed on to the guest kernel initramfs or initrd to use (Equivalent to qemu -append)
      # domain.cmd_line = 
    end
  end
 config.vm.provision "shell", path: "sync/provisioning/setup.sh"
end
