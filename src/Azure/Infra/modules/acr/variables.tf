variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
  default     = "pisharpacr"
  validation {
    condition     = length(var.acr_name) > 5
    error_message = "ACR name must be longer than 5 characters."
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
