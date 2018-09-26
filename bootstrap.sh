#!/bin/bash

#Adding the user to the cluter
#useradd  -mG wheel puppet
#echo itversity | passwd puppet --stdin
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
service sshd restart

#Uncommenting the sudoers file
sudo sed -i '/NOPASSWD/s/^#//g' /etc/sudoers

#Copying required files
#sudo cp /vagrant/main.sh /opt/main.sh 
sudo cp /vagrant/hadoop-2.9.1.tar.gz /tmp/hadoop-2.9.1.tar.gz
sudo yum -y install wget


