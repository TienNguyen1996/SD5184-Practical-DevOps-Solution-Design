variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
  default     = "pi-sharp-vm"
  validation {
    condition     = length(var.vm_name) > 3
    error_message = "VM name must be longer than 3 characters."
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

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the VM"
}

variable "nsg_id" {
  type        = string
  description = "Network Security Group ID"
}
