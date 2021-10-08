#!/usr/bin/env bash

echo "***************************************************************"
echo "For Debugging (print env. variables, define command tracing)"
echo "****************************************************************"
#set -o xtrace
#env
#set

# Update packages and Upgrade system
echo "****************************************************************"
echo "Updating System"
echo "****************************************************************"
yum update -y


echo "****************************************************************"
echo "Installing Repository"
echo "****************************************************************"
yum install epel-release -y


echo "****************************************************************"
echo "Installing Ansible"
echo "****************************************************************"
yum install ansible -y


echo "****************************************************************"
echo "Setting Ansible"
echo "****************************************************************"
sed -i -e "s/#host_key_checking/host_key_checking/" /etc/ansible/ansible.cfg


echo "****************************************************************"
echo "Create Sample Ansible Playbook"
echo "****************************************************************"
cat << EOS > /home/centos/playbook.yml
- hosts: localhost
  tasks:
    - debug: msg="hello world"
    - debug: var=ansible_distribution
EOS
