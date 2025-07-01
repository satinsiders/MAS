#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <subscription-id> [resource-group] [location]" >&2
  exit 1
}

# Accept positional args or pre-exported vars
SUBSCRIPTION_ID=${1:-${SUBSCRIPTION_ID:-}}
RESOURCE_GROUP=${2:-virtual-dept-rg}
LOCATION=${3:-eastus}

[[ -z "$SUBSCRIPTION_ID" ]] && usage
command -v az >/dev/null || { echo "Azure CLI not installed"; exit 1; }
az account show >/dev/null 2>&1 || { echo "Run 'az login' first"; exit 1; }

echo "› Setting subscription ${SUBSCRIPTION_ID}"
az account set --subscription "$SUBSCRIPTION_ID"

echo "› Creating resource group ${RESOURCE_GROUP} in ${LOCATION}"
az group create --name "$RESOURCE_GROUP" --location "$LOCATION" --output none

echo "› Registering providers (Storage, Network)"
for ns in Microsoft.Storage Microsoft.Network; do
  az provider register --namespace "$ns" --wait
done

echo -e "\nAzure bootstrap complete."
