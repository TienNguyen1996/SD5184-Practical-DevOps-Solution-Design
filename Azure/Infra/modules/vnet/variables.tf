variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
  default     = "pi-sharp-vnet"
  validation {
    condition     = length(var.vnet_name) > 3
    error_message = "VNet name must be longer than 3 characters."
  }
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the VNet"
  default     = ["10.0.0.0/16"]
}

variable "subnet_names" {
  type        = list(string)
  description = "Names of the subnets"
  default     = ["aks-subnet"]
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "CIDR blocks for the subnets"
  default     = ["10.0.1.0/24"]
}
