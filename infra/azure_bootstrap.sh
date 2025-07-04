#!/usr/bin/env bash
set -euo pipefail

: "${AZURE_SUBSCRIPTION_ID?Set AZURE_SUBSCRIPTION_ID first}" >/dev/null

# Allow overriding defaults via environment variables
: "${RG_NAME:=virtual-dept-rg}"
: "${LOCATION:=eastus}"
: "${VNET_NAME:=virtual-dept-vnet}"
: "${ADDRESS_PREFIX:=10.0.0.0/16}"
: "${SUBNET_NAME:=default}"
: "${SUBNET_PREFIX:=10.0.1.0/24}"

run() {
  echo "> $*"
  "$@"
}

run az account set --subscription "$AZURE_SUBSCRIPTION_ID"

run az group create \
  --name "$RG_NAME" \
  --location "$LOCATION"

run az network vnet create \
  --name "$VNET_NAME" \
  --resource-group "$RG_NAME" \
  --address-prefix "$ADDRESS_PREFIX" \
  --subnet-name "$SUBNET_NAME" \
  --subnet-prefix "$SUBNET_PREFIX"

mkdir -p infra/outputs
cat <<JSON > infra/outputs/bootstrap.json
{
  "resource_group_id": "$(az group show --name "$RG_NAME" --query id -o tsv)",
  "vnet_id": "$(az network vnet show --name "$VNET_NAME" --resource-group "$RG_NAME" --query id -o tsv)"
}
JSON

echo "Bootstrap complete. Details written to infra/outputs/bootstrap.json"

