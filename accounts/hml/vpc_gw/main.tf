terraform {

  required_version = ">= 0.12.26"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

}

provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = ["712021676851"]
  profile             = "transit"
  alias               = "env"
}
