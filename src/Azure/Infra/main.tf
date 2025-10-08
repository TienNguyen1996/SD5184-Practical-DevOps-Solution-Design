provider "azurerm" {
  features {}
  subscription_id               = "df7f2321-fcf2-42cb-a756-12033750249e"
  resource_provider_registrations = "none" 
}

data "azurerm_client_config" "current" {}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
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

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  acr_name            = var.acr_name
}

module "aks" {
  source                 = "./modules/aks"
  cluster_name           = var.cluster_name
  resource_group_name    = azurerm_resource_group.main.name
  location               = var.location
  subnet_id              = module.vnet.subnet_ids[0]
  acr_id                 = module.acr.acr_id
  dns_prefix             = var.dns_prefix
  default_node_pool_name = var.default_node_pool_name
  default_node_count     = var.default_node_count
  default_vm_size        = var.default_vm_size
  default_os_disk_size_gb = var.default_os_disk_size_gb
  aks_service_cidr       = var.aks_service_cidr
  aks_dns_service_ip     = var.aks_dns_service_ip
  tags                   = var.tags
}