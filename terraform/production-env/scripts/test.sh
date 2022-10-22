#!/bin/bash
#
# Install Ansible and use `ansible-pull` to run the playbook for this instance.

# Some sane options.
set -e # Exit on first error.
set -x # Print expanded commands to stdout.

sudo cp /home/ubuntu/.ssh/* /root/.ssh
chown -R root:root /root/.ssh


function main {
  # Set our named arguments.
  declare -r url=$1 playbook=$2
    
  apt update -y
  apt install -y ansible


  # Download our Ansible repository and run the given playbook. 
  # executables into a directory not in the root users $PATH.
  /usr/local/bin/ansible-pull --accept-host-key --verbose \
    --url "$url" --directory /var/local/src/instance-bootstrap "$playbook"
}

# 🚀
main \
  'git@github.com:Mysticx69/DockerProject.git' \
  'ansible/playbooks/deploy-swarm.yml'