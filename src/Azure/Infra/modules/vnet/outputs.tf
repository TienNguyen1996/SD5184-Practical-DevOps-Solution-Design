output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "subnet_ids" {
  description = "List of subnet IDs"
  value       = azurerm_subnet.subnets[*].id
}
