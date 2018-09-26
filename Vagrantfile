# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
require 'yaml'
cnf = YAML::load(File.open('/Users/vinodnerella/RandD/vagrant/puppet/manifest.yml'))
instances = cnf['instances'].to_i

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  instances.times do |i|
    node_id = "puppet#{i}"
    config.vm.define node_id do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "#{node_id}"
      node.vm.network "private_network", ip: cnf['privateip_prefix'] + "#{i}"
      node.vm.provider :virtualbox do |lvm|
        lvm.memory = cnf['memory']
        lvm.cpus = cnf['cpus']
      end
      node.vm.provision "shell", path: cnf["bootstrap"]
    end
  end
end

