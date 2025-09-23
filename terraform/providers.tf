terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.11"
    }
  }

  backend "s3" {
    bucket       = "tech-challenge-soat11-terraform-state"
    key          = "eks/terraform/state"
    region       = "us-east-1"
    use_lockfile = true
  }

}

provider "aws" {
  region = var.aws_region
}