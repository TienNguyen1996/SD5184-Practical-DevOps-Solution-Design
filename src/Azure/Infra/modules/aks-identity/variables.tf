variable "identity_name" {
  type        = string
  description = "Name of the managed identity"
  default     = "pi-sharp-aks-identity"
  validation {
    condition     = length(var.identity_name) > 3
    error_message = "Identity name must be longer than 3 characters."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}
