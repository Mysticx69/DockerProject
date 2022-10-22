#!/bin/bash
#
# Install Ansible

# Some sane options.
set -e # Exit on first error.
set -x # Print expanded commands to stdout.

apt update -y
apt install -y ansible

sudo cp /home/ubuntu/.ssh/* /root/.ssh
chown -R root:root /root/.ssh
mkdir /home/ubuntu/dev
cd /home/ubuntu/dev
git clone git@github.com:Mysticx69/DockerProject.git
chown -R ubuntu:ubuntu /home/ubuntu/dev
cd /home/ubuntu/dev/DockerProject/ansible
sudo -u ubuntu -c 'ansible-playbook -i inventories/production/hosts playbooks/deploy-swarm.yaml'