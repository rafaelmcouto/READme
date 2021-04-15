module "transit_vpc" {
  source = "../../../modules/vpc_serv_externos"

  account     = "VPC Serviços Externos"
  createdBy   = "Rafael Couto"
  environment = "Prod"
  iac         = "Terraform"
  name        = "vpc_serv_externos"
  product     = "New Account"
  project     = "Organizations"
  service     = "VPC and Resources"
}