# main.tf
# Define your resources here

provider "aws" {
  region = "us-east-1" # Free Tier eligible region
}

resource "aws_ecr_repository" "sd5184_repo" {
  name                 = "sd5184-app-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256" # Free default encryption
  }

  tags = {
    Environment = "sd5184"
    Terraform   = "true"
  }
}
