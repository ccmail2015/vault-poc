#!/usr/bin/env bash

tee config-file.hcl <<EOF
storage "file" {
  path = "vault-data"
}

listener "tcp" {
  tls_disable = "true"
}
EOF


vault server -config=config-file.hcl
# post to http://127.0.0.1:8200/v1/sys/init
curl \
    --request POST \
    --data '{"secret_shares": 1, "secret_threshold": 1}' \
    http://127.0.0.1:8200/v1/sys/init | jq
# initialize vault
#{
#  "keys": [
#    "286ac58ecd52abd92ff284831aba09cebb3d3ad83607f66ecdea52c8cf800e99"
#  ],
#  "keys_base64": [
#    "KGrFjs1Sq9kv8oSDGroJzrs9Otg2B/ZuzepSyM+ADpk="
#  ],
#  "root_token": "s.eU6sAX8QThiTyCGYG0QMfORx"
#}

#set VAULT_TOKE
export VAULT_TOKEN="s."eU6sAX8QThiTyCGYG0QMfORx

# unseal using /v1/sys/unseal (use base64 key)
curl \
    --request POST \
    --data '{"key": "KGrFjs1Sq9kv8oSDGroJzrs9Otg2B/ZuzepSyM+ADpk="}' \
    http://127.0.0.1:8200/v1/sys/unseal | jq

#{
#  "type": "shamir",
#  "initialized": true,
#  "sealed": false,
#  "t": 1,
#  "n": 1,
#  "progress": 0,
#  "nonce": "",
#  "version": "1.7.3",
#  "migration": false,
#  "cluster_name": "vault-cluster-e9b75fe0",
#  "cluster_id": "8aef4c5b-8817-53cb-489a-1dff7aa5ec61",
#  "recovery_seal": false,
#  "storage_type": "file"
#}

# validate
curl http://localhost:8200/v1/sys/init

#{"initialized":true}
# see  vault auth enable approle curl string
vault auth enable -output-curl-string approle

#curl -X POST -H "X-Vault-Token: $(vault print token)" -H "X-Vault-Request: true" -d '{"type":"approle","description":"","config":{"options":null,"default_lease_ttl":"0s","max_lease_ttl":"0s","force_no_cache":false},"local":false,"seal_wrap":false,"external_entropy_access":false,"options":null}' https://127.0.0.1:8200/v1/sys/auth/approle
curl -X POST -H "X-Vault-Token: $(vault print token)" \
     -H "X-Vault-Request: true" \
     -d '{"type":"approle","description":"","config":{"options":null,"default_lease_ttl":"0s","max_lease_ttl":"0s","force_no_cache":false},"local":false,"seal_wrap":false,"external_entropy_access":false,"options":null}' https://127.0.0.1:8200/v1/sys/auth/approle

# create policy via API - /v1/sys/policies/acl/my-policy
curl \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request PUT \
    --data '{"policy":"# Dev servers have version 2 of KV secrets engine mounted by default, so will\n# need these paths to grant permissions:\npath \"secret/data/*\" {\n  capabilities = [\"create\", \"update\"]\n}\n\npath \"secret/data/foo\" {\n  capabilities = [\"read\"]\n}\n"}' \
    http://127.0.0.1:8200/v1/sys/policies/acl/my-policy
