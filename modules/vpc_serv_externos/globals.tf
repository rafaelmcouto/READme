locals {
  name = ""

  // Common tags for repos
  common_tags = {
    Account     = var.account
    createdBy   = var.createdBy
    Environment = var.environment
    IaC         = var.iac
    Name        = var.name
    Product     = var.product
    Project     = var.project
    Service     = var.service
  }

  aws = {
    region     = data.aws_region.this.name
    account_id = data.aws_caller_identity.this.account_id
  }
}
