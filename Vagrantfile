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

  config.vm.box = "freepto"
  config.vm.box_url = "http://dev.freepto.mx/vagrant/freepto-vbox.box"
# config.vm.box_url = "http://dev.freepto.mx/vagrant/freepto-qemu.box"


  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # avoids 'stdin: is not a tty' error.
  config.ssh.private_key_path = ["#{ENV['HOME']}/.ssh/id_rsa","#{ENV['HOME']}/.vagrant.d/insecure_private_key"]
  config.vm.provision "shell", inline: <<-SCRIPT
    printf "%s\n" "#{File.read("#{ENV['HOME']}/.ssh/id_rsa.pub")}" > /home/vagrant/.ssh/authorized_keys
    chown -R vagrant:vagrant /home/vagrant/.ssh
  SCRIPT

  config.vm.provider "virtualbox" do |vb|
    # if BUILD_TYPE is ram, you should be set the ram size
    # to 6656 (1024 * 6 + 512)
    # vb.customize ["modifyvm", :id, "--memory", "6656"]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "1"]
    vb.gui = false
  end
  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "qemu"
    libvirt.connect_via_ssh = false
    #libvirt.username = "root"
    #libvirt.host="localhost"
    libvirt.storage_pool_name = "default"
  end
 config.vm.provision "shell", path: "provisioning/setup.sh"
end
