variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
  validation {
    condition     = contains(["t2.micro", "t3.micro", "t3.small", "t3.medium", "t3.large"], var.instance_type)
    error_message = "Instance type must be one of: t2.micro, t3.micro, t3.small, t3.medium, t3.large."
  }
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch EC2 instance"
  type        = list(string)
  validation {
    condition     = length(var.subnet_ids) > 0
    error_message = "You must provide at least one subnet ID."
  }
}

variable "vpc_id" {
  description = "VPC ID for the EC2 instance"
  type        = string
  validation {
    condition     = length(var.vpc_id) > 4
    error_message = "VPC ID must be a valid non-empty string."
  }
}
