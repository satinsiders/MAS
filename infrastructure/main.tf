terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_prefix" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_prefix" {
  type = string
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = [var.address_prefix]

  subnet {
    name           = var.subnet_name
    address_prefix = var.subnet_prefix
  }
}

# Placeholder: storage account for Terraform state
# resource "azurerm_storage_account" "state" {
#   name                     = "virtualdeptstate${random_id.storage.hex}"
#   resource_group_name      = azurerm_resource_group.main.name
#   location                 = azurerm_resource_group.main.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# Placeholder: key vault for future secrets
# resource "azurerm_key_vault" "main" {
#   name                = "virtualdeptkv${random_id.kv.hex}"
#   resource_group_name = azurerm_resource_group.main.name
#   location            = azurerm_resource_group.main.location
#   tenant_id           = data.azurerm_client_config.current.tenant_id
#   sku_name            = "standard"
# }

output "resource_group_id" {
  value = azurerm_resource_group.main.id
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}
