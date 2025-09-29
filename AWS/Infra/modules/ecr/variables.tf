variable "repo_name" {
  description = "Name of the ECR repository"
  type        = string
  validation {
    condition     = length(var.repo_name) > 1
    error_message = "Repository name must be at least 2 characters."
  }
}
