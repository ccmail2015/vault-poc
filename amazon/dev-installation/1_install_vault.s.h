#!/bin/bash

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install vault


# install dev mode
vault server -dev

# use a different terminal
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN="s.rDU6sOn6blyEcVKFvqSODfAw"
vault status

