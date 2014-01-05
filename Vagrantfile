# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :forwarded_port, guest: 7654, host: 7654
  config.vm.network :private_network, ip: "192.168.50.4"
  config.vm.provision :docker do |d|
    d.pull_images "base"
  end
end