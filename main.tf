
provider "github" {
  token        = var.github_token
  organization = var.github_organization
}


resource "github_repository" "repo_in_organization" {
  name        = var.github_repo_name
  description = "This is a test"

  private = false
}


variable "github_token" {
  type = string
}

variable "github_organization" {
  type = string
}

variable "github_repo_name" {
  type = string
}