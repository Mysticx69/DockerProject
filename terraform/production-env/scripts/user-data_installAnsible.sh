#!/bin/bash
#
# Install Ansible

# Some sane options.
set -e # Exit on first error.
set -x # Print expanded commands to stdout.

apt update -y

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user
python3 -m pip install --user ansible