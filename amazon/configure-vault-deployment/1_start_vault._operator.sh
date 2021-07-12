#!/usr/bin/env bash

# make vault data dir - for storage backend

mkdir -p ./vault/data

vault server -config=config.hcl

# initialize vault

export VAULT_ADDR='http://127.0.0.1:8200'
vault operator init

#Unseal Key 1: IgDAIvrAsNp66suAq14FMRKQlYWabb5SL26WD78tObPw
#Unseal Key 2: NFWf+/PrRTdcQSWFg/B0tNNOyEay+kAuR4RD0zxjgKcI
#Unseal Key 3: 6w3Yd2zZjNh2FPhijDGLY8z0zdszHAjSoTOmPGuqDxQd
#Unseal Key 4: TeZc5vFy0tuaIdlB8v6rMpKt41Vsyq3kfEGL/DE/BX6p
#Unseal Key 5: lkP6x0Ufgm2G5VvW2Is3i34qju8STZY3CNkctdyPsGT1
#
#Initial Root Token: s.XyDQwa0ayrUOYTJUpTgT5pJI

## vault needs to unseal at startup
vault operator unseal

# login using ROOT token
unset VAULT_TOKE
vault login <root-token>
