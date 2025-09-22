resource "aws_ecr_repository" "repo" {
  name                 = "${var.environment}-app-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}
