terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = ["198274409717"]
  profile             = "ingaia"
}