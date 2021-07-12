ui = true
disable_mlock = true

storage "raft" {
  path    = "./vault/data"
  node_id = "node1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = "true"
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"
EOF

# use ssh tunnel to see UI
ssh -L 8200:localhost:8200 cloud_user@<public-ip>
# use browser to open vault UI
# create a new cluster

{
  "keys": [
    "5c2dff4fedb862e27c24c3a1a1357d1bca4c19c23b7fd0fe411b1067f4c4f59b13",
    "8747fcd399f8d971b6addce476f81ced4f41a479eba254f19c4861f8b4f6bbb107",
    "4cd83875e1eb7875965b0e7be8357907094fe6ded627abfce8b019e2077271abc1",
    "effe03a47784081c824791f9eea02986d75fc87dbe8128a7f5c710f6d26866497d",
    "51fd3c6d62050829cf237de9ffe5424889068222d6ceddd5f63cc5e0c10890c81a"
  ],
  "keys_base64": [
    "XC3/T+24YuJ8JMOhoTV9G8pMGcI7f9D+QRsQZ/TE9ZsT",
    "h0f805n42XG2rdzkdvgc7U9BpHnrolTxnEhh+LT2u7EH",
    "TNg4deHreHWWWw576DV5BwlP5t7WJ6v86LAZ4gdycavB",
    "7/4DpHeECByCR5H57qAphtdfyH2+gSin9ccQ9tJoZkl9",
    "Uf08bWIFCCnPI33p/+VCSIkGgiLWzt3V9jzF4MEIkMga"
  ],
  "root_token": "s.o3iG32qilrblHnkZzRRXZ72r"
}

# use one of the key as the master key (raw key, not base64)
