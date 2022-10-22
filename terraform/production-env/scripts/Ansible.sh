#!/bin/bash
#
# Install Ansible

# Some sane options.
set -e # Exit on first error.
set -x # Print expanded commands to stdout.

sudo apt update -y
sudo apt install -y ansible

sudo mv /tmp/hosts /etc/hosts
sudo chmod 600 /home/ubuntu/.ssh/labsuser.pem

ansible-galaxy collection install community.docker
ansible-playbook -i /home/ubuntu/ansible/inventories/production/hosts /home/ubuntu/ansible/playbooks/deploy-swarm.yaml