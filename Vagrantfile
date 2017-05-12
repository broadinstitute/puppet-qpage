# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # config.vm.box = "centos/7"
  config.vm.box = "freebsd/FreeBSD-10.3-RELEASE"
  # config.vm.box_check_update = false
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"

  #config.vm.network "private_network", type: "dhcp",
  #  virtualbox__intnet: "vboxnet1"

  config.vm.hostname = "puppet-qpage.example.com"

  config.vm.provider "virtualbox" do |vb|
   vb.gui = false
   vb.memory = "1024"
   vb.name = "puppet-qpage"
  end

  config.vm.provision "file", source: "Gemfile", destination: "/tmp/Gemfile"
  config.vm.provision "file", source: "vagrant_files/hiera.yaml", destination: "/tmp/hiera.yaml"
  config.vm.provision "shell", path: "vagrant_files/freebsd10-init.sh"

  config.vm.synced_folder ".", "/usr/local/etc/puppetlabs/code/modules/qpage", type: "rsync"

  config.ssh.insert_key = false
  config.ssh.shell = "sh"
end
