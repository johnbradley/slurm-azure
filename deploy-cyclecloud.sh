#!/usr/bin/env bash
set -e

source config.sh
echo $SUBSCRIPTION $RESOURCE_GROUP $LOCATION $FUND_CODE

SUBSCRIPTION_ID=$(az account show --subscription "John Personal Subscription" --query id -o tsv)

if [ "$FUND_CODE" != "" ]
then
   RESOURCE_GROUP_ID=$(az group create --subscription "$SUBSCRIPTION" --location "$LOCATION" --name "$RESOURCE_GROUP" --tags "Fund Code=$FUND_CODE" | rq '.id')
else
   RESOURCE_GROUP_ID=$(az group create --subscription "$SUBSCRIPTION" --location "$LOCATION" --name "$RESOURCE_GROUP" | jq '.id')
fi

echo "Created resource group $RESOURCE_GROUP $RESOURCE_GROUP_ID"

az deployment group create \
  --name "CYCLE_CLOUD_${RESOURCE_GROUP}" \
  --resource-group "$RESOURCE_GROUP" \
  --template-file "$TEMPLATE_FILE" \
  --parameters "$PARAMETERS" \
  --parameters "location=$LOCATION" \
  --parameters "adminUsername=$ADMIN_USER" \
  --parameters "adminPublicKey=$ADMIN_PUB_KEY" \
  --parameters "virtualMachineRG=$RESOURCE_GROUP" \
  --parameters "diagnosticsStorageAccountName=$RESOURCE_GROUP"


SPID=$(az resource list -n cyclecloud --query [*].identity.principalId --out tsv)
echo "Giving cyclecloud VM Contributor role for subscription and resource group. SPID: $SPID"

az role assignment create --assignee "$SPID" --role 'Contributor' --scope "/subscriptions/$SUBSCRIPTION_ID"
az role assignment create --assignee "$SPID" --role 'Contributor' --scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP"

VM_IP=$(az vm show -d -g "$RESOURCE_GROUP" -n cyclecloud --query publicIps --out tsv)
echo "Open url https://$VM_IP perform initial setup and configure azure connection."
echo "Be patient it will take a minute for the VM to wake up."
