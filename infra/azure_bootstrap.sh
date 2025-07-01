#!/usr/bin/env bash
set -euo pipefail

# Bootstraps the Azure environment for this project.
# Ensure you have run 'az login' and have access to the target subscription.

SUBSCRIPTION_ID="<your-subscription-id>"
RESOURCE_GROUP="virtual-dept-rg"
LOCATION="eastus"

# Set subscription context
az account set --subscription "$SUBSCRIPTION_ID"

# Create the resource group
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

# Register common providers used by infrastructure modules
az provider register --namespace Microsoft.Storage
az provider register --namespace Microsoft.Network

# (Optional) create a service principal for CI/CD pipelines
# az ad sp create-for-rbac --name virtual-dept-sp --role contributor \
#   --scopes "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP"

printf '\nAzure bootstrap complete.\n'

