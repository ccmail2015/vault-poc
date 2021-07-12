#!/usr/bin/env bash

vault auth enable approle
vault auth list | grep approle/

# link approle to policy

vault write auth/approle/role/my-role \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    token_policies=my-policy

# generate secret id
export ROLE_ID="$(vault read -field=role_id auth/approle/role/my-role/role-id)"
export SECRET_ID="$(vault write -f -field=secret_id auth/approle/role/my-role/secret-id)"

# login using AppRole auth
vault write auth/approle/login role_id="$ROLE_ID" secret_id="$SECRET_ID"
