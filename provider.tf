terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
}

provider "aws" {
  shared_credentials_files = ["~/.aws/config"]
  profile                  = "pessoal"
  region                   = "us-east-2"
}