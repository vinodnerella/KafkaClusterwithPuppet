#!/bin/bash

#Adding the user to the cluter
#useradd  -mG wheel puppet
#echo puppet | passwd puppet --stdin
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
service sshd restart

#Uncommenting the sudoers file
sudo sed -i '/NOPASSWD/s/^#//g' /etc/sudoers

#Installing wget package
sudo yum -y install wget


