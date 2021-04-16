module "transit_vpc" {
  source = "../../../modules/full_vpc"

  account     = "Transit"
  createdBy   = "Rafael Couto"
  environment = "Prod"
  iac         = "Terraform"
  name        = "vpc_gateway"
  product     = "New Account"
  project     = "Organizations"
  service     = "VPC and Resources"
}
