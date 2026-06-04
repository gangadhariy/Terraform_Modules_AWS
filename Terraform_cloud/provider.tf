terraform {
  backend "s3" {
    bucket = "terraform-remote-backend-gng"
    region = "us-east-1"
    key = "Class10/terraform.tfstate"
    use_lockfile = false
    encrypt = false
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}