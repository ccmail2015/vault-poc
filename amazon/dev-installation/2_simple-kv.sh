#!/bin/bash


# use a different terminal
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN="s.rDU6sOn6blyEcVKFvqSODfAw"
vault status

# write a secret with secret prefix (arbitrary read/write)
vault kv put secret/hello foo=world excited=yes


# retrieve a secret
vault kv get secret/hello
vault kv get -format=json secret/hello
vault kv get -field=excited  secret/hello
vault kv get -format=json secret/hello | jq -r .data.data.excited

# delete a secret
vault kv delete secret/hello
