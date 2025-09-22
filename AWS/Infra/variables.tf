variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "sd5184"
}

variable "ami_id" {
  description = "Ubuntu AMI ID for EC2"
  type        = string
  default     = "ami-0c94855ba95c71c99" # Ubuntu 22.04 LTS (us-east-1)
}
