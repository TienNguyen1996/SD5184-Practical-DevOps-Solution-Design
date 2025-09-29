variable "nsg_name" {
  type        = string
  description = "Name of the Network Security Group"
  default     = "pi-sharp-nsg"
  validation {
    condition     = length(var.nsg_name) > 3
    error_message = "NSG name must be longer than 3 characters."
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
