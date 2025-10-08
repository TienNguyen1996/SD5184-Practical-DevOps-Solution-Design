resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_prefixes[count.index]]

  dynamic "delegation" {
    for_each = try(var.subnet_delegations[count.index].service_name, "") != "" ? [var.subnet_delegations[count.index]] : []
    
    content {
      name = "delegation"

      service_delegation {
        name    = delegation.value.service_name
        actions = try(delegation.value.actions, []) 
      }
    }
  }
}