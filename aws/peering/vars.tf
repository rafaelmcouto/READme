variable "name_vpc_owner" { type = string }
variable "name_vpc_accepter" { type = string }
variable "subnet_id_accepter" { type = string }
variable "vpc_id_accepter" { type = string }
variable "route_table_id" { type = string }
variable "destination_cidr_block" { type = string }
variable "vpc_id" { type = string }
variable "access_key" { type = string }
variable "secret_key" { type = string }

variable "accepter_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "tags" {
  type = map(string)
  default = {
    "Service" = "Peering"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Environment" = "Dev"
    "Owner"       = "Engineer"
  }
}
