variable "aws_region" {
  description = <<EOT
AWS region where resources will be deployed.
Examples: "us-east-1", "us-west-2", "ap-southeast-1"
EOT

  type    = string
  default = "us-east-1"

  validation {
    condition = contains([
      "us-east-1", "us-east-2", "us-west-1", "us-west-2",
      "af-south-1", "ap-east-1", "ap-south-1", "ap-northeast-1",
      "ap-northeast-2", "ap-northeast-3", "ap-southeast-1",
      "ap-southeast-2", "ca-central-1", "eu-central-1",
      "eu-west-1", "eu-west-2", "eu-west-3", "eu-north-1",
      "eu-south-1", "me-south-1", "sa-east-1"
    ], var.aws_region)

    error_message = "Invalid AWS region. Please use a valid region code like 'us-east-1'."
  }
}

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
  default     = "ami-0c55b159cbfafe1f0"
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

variable "node_role_name" {
  description = "Name of the IAM role for EKS node group"
  type        = string
  default     = "pi-sharp-node-role"
}

variable "cluster_role_name" {
  description = "Name of the IAM role for EKS cluster"
  type        = string
  default     = "pi-sharp-cluster-role"
}
