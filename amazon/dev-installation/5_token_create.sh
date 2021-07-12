#!/usr/bin/env bash

# create a new token - a child of root token

vault token create

#Key                  Value
#---                  -----
#token                s.dFPt53at8U0GNClJAkvxr6lS
#token_accessor       HgHDUQzQHBsO800k6MYu6bsi
#token_duration       ∞
#token_renewable      false
#token_policies       ["root"]
#identity_policies    []
#policies             ["root"]

# need token to login to Vault
vault login <token>

# revoke token
vault token remove <token>

# create token for a policy
vault token create -field token -policy <policy>

export VAULT_TOKEN="$(vault token create -field token -policy=my-policy)"
