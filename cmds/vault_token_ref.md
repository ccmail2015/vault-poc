*Vault Token Ref*
  + *vault token create*
      * Limited TOKEN
        * vault token create -ttl=1h -use-limit=2 -policy=default   
        * VAULT_TOKEN=$USE_LIMIT_TOKEN vault token lookup
        * VAULT_TOKEN=$USE_LIMIT_TOKEN vault write cubbyhole/token value=1234567890
        * VAULT_TOKEN=$USE_LIMIT_TOKEN vault read cubbyhole/token
      * Periodic Token
        * vault token create -policy default -period=24h
      * Short live
        * vault token create -ttl 60s
            * vault token lookup s.QSnjRE2kr5frwqCVOtJUucAu
      * Orphan
        * vault token create -orphan
  + *create a token role* 
    * auth/token/roles
    * vault write auth/token/roles/zabbix \
      allowed_policies="policy1, policy2, policy3" \
      orphan=true \
      period=8h
    * vault token create -role=zabbix
* vault token renew
    * vault token create -ttl=45 -explicit-max-ttl=120 -policy=default -format=json \
      | jq -r ".auth.client_token" > test_token.txt
    * vault token renew $(cat test_token.txt)
      vault token renew -increment=60 $(cat test_token.txt)
* revoke service tokens
    + create a test policy
      * vault policy write test -<<EOF
        path "auth/token/create" {
        capabilities = ["create", "read", "update", "delete", "list", "sudo"]
        }
        EOF

      
