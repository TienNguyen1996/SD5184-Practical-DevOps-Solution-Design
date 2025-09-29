variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+/\\d+$", var.vpc_cidr))
    error_message = "Must be a valid CIDR block (e.g., 10.0.0.0/16)."
  }
}

variable "availability_zones" {
  description = "List of availability zones for high availability"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "You must specify at least two AZs for high availability."
  }
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Example: Amazon Linux 2
  validation {
    condition     = length(var.ami_id) > 4
    error_message = "AMI ID must be a valid non-empty string."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "pi-sharp-repo"
  validation {
    condition     = length(var.ecr_repo_name) > 1
    error_message = "Repository name must be at least 2 characters."
  }
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "pi-sharp-cluster"
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS node group"
  type        = string
}
