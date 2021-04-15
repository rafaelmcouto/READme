module "transit_vpc" {
  source = "../../../modules/vpc_serv_internos"

  account     = "VPC Serviços Internos"
  createdBy   = "Rafael Couto"
  environment = "Prod"
  iac         = "Terraform"
  name        = "vpc_serv_internos"
  product     = "New Account"
  project     = "Organizations"
  service     = "VPC and Resources"
}