#!/usr/bin/env bash

# enable kv-v2 secret engine
vault secrets enable -path=kv kv
vault secrets list

# disable secret engine. - revoked all secrets and remove vault data and configuration
vault secrets disable kv/


