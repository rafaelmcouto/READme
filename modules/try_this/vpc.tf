##
##  VPC
##
resource "aws_vpc" "main" {
  cidr_block       = "10.64.0.0/24"
  instance_tenancy = "default"

  tags = local.common_tags

}

##
##  Internet GW to VPC
##
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW - ${var.name}"
  }
}
