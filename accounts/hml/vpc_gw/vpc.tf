module "transit_vpc" {
  source = "../../../modules/vpc_gw"

  account     = "Personal"
  createdBy   = "Rafael Couto"
  environment = "Prod"
  iac         = "Terraform"
  name        = "vpc_gateway"
  product     = "New Account"
  project     = "Organizations"
  service     = "VPC and Resources"
}