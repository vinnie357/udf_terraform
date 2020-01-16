#!/bin/bash
# requires jq
## set vars
# vault
echo -n "Enter your vault token and press [ENTER]: "
read VAULT_TOKEN

vaultHost='http://vault.f5lab.internal:30000'
# aws
# echo -n "Enter your AWS_ACCESS_KEY_ID and press [ENTER]: "
# read AWS_ACCESS_KEY_ID
# echo -n "Enter your AWS_SECRET_ACCESS_KEY and press [ENTER]: "
# read AWS_SECRET_ACCESS_KEY
# echo -n "Enter your AWS_REGION and press [ENTER]: "
# read AWS_REGION
#
#
#http://10.1.1.254/cloudAccounts
# aws
export AWS_ACCESS_KEY_ID=$(curl -s --retry 20 http://10.1.1.254/cloudAccounts | jq .cloudAccounts | jq -r .[0].apiKey)
export AWS_SECRET_ACCESS_KEY=$(curl -s --retry 20 http://10.1.1.254/cloudAccounts | jq .cloudAccounts | jq -r .[0].apiSecret)
export AWS_REGION=$(curl -s http://10.1.1.254/cloudAccounts | jq .cloudAccounts | jq -r .[0].regions[0])
# ssh key
export SSH_KEY_DIR="/home/ubuntu/user"
#data=$("\"options\": \"cas\": 0 ,\"data\": {{\"access_key\": \"${AWS_ACCESS_KEY_ID}\", \"secret_key\": \"${AWS_SECRET_ACCESS_KEY}\", \"region\": \"${AWS_REGION}\"}}")
data=$(cat -<<EOF
{
  "data": {
      "access_key": "${AWS_ACCESS_KEY_ID}",
      "secret_key": "${AWS_SECRET_ACCESS_KEY}",
      "region": "${AWS_REGION}"
    }
}
EOF
)
# vault store data
curl -s \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request POST \
    --data "$data" \
    $vaultHost/v1/secret/data/aws
# read vault data
# curl -s \
# --header "X-Vault-Token: $VAULT_TOKEN" \
# --request GET \
#  $vaultHost/v1/secret/data/bigip

echo "env vars done"