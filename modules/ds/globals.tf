locals {
  name = ""

  // Common tags for repos
  common_tags = {
    Name        = var.name
    Environment = var.environment
    Layer       = var.layer
    Project     = var.project
    Service     = var.service
    Terraform   = true
  }

  aws = {
    region     = data.aws_region.this.name
    account_id = data.aws_caller_identity.this.account_id
  }
}
