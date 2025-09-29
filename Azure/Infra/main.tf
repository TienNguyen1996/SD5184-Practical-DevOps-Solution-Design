provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  vnet_name           = var.vnet_name
  address_space       = var.vnet_address_space
  subnet_names        = var.subnet_names
  subnet_prefixes     = var.subnet_prefixes
}

module "nsg" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  nsg_name            = "pi-sharp-nsg"
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  subnet_id           = module.vnet.subnet_ids[0]
  nsg_id              = module.nsg.nsg_id
  vm_name             = "pi-sharp-vm"
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  acr_name            = var.acr_name
}

module "aks_identity" {
  source              = "./modules/aks-identity"
  identity_name       = var.identity_name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  subscription_id     = var.subscription_id
}

module "aks" {
  source              = "./modules/aks"
  cluster_name        = var.cluster_name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  subnet_id           = module.vnet.subnet_ids[0]
  identity_id         = module.aks_identity.identity_id
  acr_id              = module.acr.acr_id
}
