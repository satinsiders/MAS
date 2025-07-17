#!/usr/bin/env bash
set -euo pipefail

: "${AZURE_SUBSCRIPTION_ID?Need AZURE_SUBSCRIPTION_ID}" >/dev/null

# Allow overrides via env vars
: "${TFSTATE_RG:=rg-tfstate-dev}"
: "${TFSTATE_SA:=tfstatevddev}"          # 3–24 lowercase letters/numbers only
: "${TFSTATE_CONTAINER:=tfstate}"
: "${LOCATION:=eastus}"

run() { echo "> $*"; "$@"; }

run az account set --subscription "$AZURE_SUBSCRIPTION_ID"

# 1. Resource group for state
run az group create \
  --name "$TFSTATE_RG" \
  --location "$LOCATION"

# 2. Storage account (LRS, encryption on)
run az storage account create \
  --name "$TFSTATE_SA" \
  --resource-group "$TFSTATE_RG" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --encryption-services blob \
  --allow-blob-public-access false

# 3. Blob container for tfstate
run az storage container create \
  --name "$TFSTATE_CONTAINER" \
  --account-name "$TFSTATE_SA" \
  --auth-mode login

echo
echo "🔑  Paste the following into env/dev/backend_override.tfvars:"
cat <<HCL
resource_group_name  = "$TFSTATE_RG"
storage_account_name = "$TFSTATE_SA"
container_name       = "$TFSTATE_CONTAINER"
key                  = "terraform.tfstate" # default
HCL
