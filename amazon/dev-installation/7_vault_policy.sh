#!/usr/bin/env bash


# list policy
vault policy list

# read policy default
vault policy read default

# write a policy
vault policy write <my-policy> - <<EOF
EOF

vault policy write my-policy - << EOF
# Dev servers have version 2 of KV secrets engine mounted by default, so will
# need these paths to grant permissions:
path "secret/data/*" {
  capabilities = ["create", "update"]
}

path "secret/data/foo" {
  capabilities = ["read"]
}
EOF

# delete a policy
vault policy delete my-policy
