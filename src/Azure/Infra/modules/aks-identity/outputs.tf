output "identity_id" {
  description = "ID of the managed identity"
  value       = azurerm_user_assigned_identity.main.id
}
