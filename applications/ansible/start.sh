#!/usr/bin/env bash

echo "***************************************************************"
echo "For Debugging (print env. variables, define command tracing)"
echo "****************************************************************"
#set -o xtrace
#env
#set


echo "****************************************************************"
echo "Create Sample Ansible Playbook"
echo "****************************************************************"
cat << EOS > /home/centos/playbook.yml
- hosts: localhost
  tasks:
    - debug: msg="hello world"
    - debug: var=ansible_distribution
EOS


echo "****************************************************************"
echo "Running Sample Ansible Playbook"
echo "****************************************************************"
ansible-playbook /home/centos/playbook.yml
