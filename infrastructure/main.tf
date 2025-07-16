module "network" {
  source = "./modules/network"

  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  address_prefix      = var.address_prefix
  subnet_name         = var.subnet_name
  subnet_prefix       = var.subnet_prefix
}
