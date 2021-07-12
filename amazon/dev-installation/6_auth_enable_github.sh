#!/usr/bin/env bash

vault auth enable github
vault auth enable -path=org1 github
#[cloud_user@9d78c4d0721c ~]$ vault auth list
#Path       Type      Accessor                Description
#----       ----      --------                -----------
#github/    github    auth_github_317becde    n/a
#token/     token     auth_token_21ca8a45     token based credentials

# set organization for github authentication
vault write auth/github/config organization=<githuborg>

# configure engineering team with default,application policies
vault write auth/github/map/teams/egineering value=default,applications


# get help
vault auth help github

# login to vault using github
vault login -method=github token=<githubtoken>

#Key                    Value
#---                    -----
#token                  s.jRoNANY3iIxoPDF3fhSWhtca
#token_accessor         xmGAVy5lY32fbPSwDTk2Imuq
#token_duration         768h
#token_renewable        true
#token_policies         ["default"]
#identity_policies      []
#policies               ["default"]
#token_meta_org         greencoconut2015
#token_meta_username    ccmail2015

# revoke auth token by path
 vault token revoke -mode path auth/github

# disable github auth
vault auth disable github
