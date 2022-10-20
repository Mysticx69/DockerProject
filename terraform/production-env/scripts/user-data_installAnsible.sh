#!/bin/bash
#
# Install Ansible

# Some sane options.
set -e # Exit on first error.
set -x # Print expanded commands to stdout.

apt update -y
apt install -y ansible