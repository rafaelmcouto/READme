##
##  VPC
##
resource "aws_vpc" "main" {
  cidr_block       = "10.64.16.0/21"
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

##
##  SubNet Pub01
##
resource "aws_subnet" "priv_01" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.16.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_priv_01-a"
  }
}

##
##  SubNet Pub02
##
resource "aws_subnet" "priv_02" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.17.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_02-b"
  }
}

##
##  SubNet Pub03
##
resource "aws_subnet" "priv_03" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.18.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_priv_03-c"
  }
}

##
##  SubNet Pub04
##
resource "aws_subnet" "priv_04" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.19.0/24"
  availability_zone = "us-east-1d"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_priv_04-d"
  }
}

##
##  SubNet Pub05
##
resource "aws_subnet" "priv_05" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.20.0/24"
  availability_zone = "us-east-1e"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_priv_05-e"
  }
}

##
##  SubNet Pub06
##
resource "aws_subnet" "priv_06" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.21.0/24"
  availability_zone = "us-east-1f"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_priv_06-f"
  }
}
