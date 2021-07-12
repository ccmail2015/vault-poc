#!/usr/bin/env bash

# enable aws secret engine - generate dynamic, on-demand AWS access credentials
vault secrets enable -path=aws aws

# configure aws secret engine

export AWS_ACCESS_KEY_ID=<aws_access_key_id>
export AWS_SECRET_ACCESS_KEY=<aws_secret_key>


# save the admin api credential in vault
vault write aws/config/root \
    access_key=$AWS_ACCESS_KEY_ID \
    secret_key=$AWS_SECRET_ACCESS_KEY \
    region=us-east-1
#

# add a role to vault - test ec2 write role

vault write aws/roles/my-role \
        credential_type=iam_user \
        policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1426528957000",
      "Effect": "Allow",
      "Action": [
        "ec2:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF

# get credential for my-role dynamically
vault read aws/creds/my-role
# output
#Key                Value
#---                -----
#lease_id           aws/creds/my-role/Ldk5fLzHbhSHtLD8T2pMcAcr
#lease_duration     768h
#lease_renewable    true
#access_key         AKIAQQ5RS4AFJW3QQKFQ
#secret_key         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
#security_token     <nil>

# revoke secret via lease id
vault lease revoke aws/creds/my-role/Ldk5fLzHbhSHtLD8T2pMcAcr


# get aws secret engine help
vault path-help aws
