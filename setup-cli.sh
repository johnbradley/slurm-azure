#!/usr/bin/env bash
set -e

source config.sh

VM_IP=$(az vm show -d -g "$RESOURCE_GROUP" -n cyclecloud --query publicIps --out tsv)
echo "URL below should be: https://$VM_IP"
cyclecloud initialize --config=$CCCONFIG
