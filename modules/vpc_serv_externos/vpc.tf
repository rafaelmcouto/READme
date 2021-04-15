##
##  VPC
##
resource "aws_vpc" "main" {
  cidr_block       = "10.64.8.0/21"
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
##  Route Table to Pub SubNet
##
resource "aws_route_table" "pubs" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Route Table - ${var.name}"
  }
}

##
##  SubNet Pub01
##
resource "aws_subnet" "pub_01" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.8.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_pub_01-a"
  }
}

##
##  Route Table to Pub01 SubNet
##
resource "aws_route_table_association" "pub01" {
  subnet_id      = aws_subnet.pub_01.id
  route_table_id = aws_route_table.pubs.id
}

##
##  SubNet Pub02
##
resource "aws_subnet" "pub_02" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.9.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_02-b"
  }
}

##
##  Route Table to Pub02 SubNet
##
resource "aws_route_table_association" "pub02" {
  subnet_id      = aws_subnet.pub_02.id
  route_table_id = aws_route_table.pubs.id
}

##
##  SubNet Pub03
##
resource "aws_subnet" "pub_03" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.10.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_pub_03-c"
  }
}

##
##  Route Table to Pub03 SubNet
##
resource "aws_route_table_association" "pub03" {
  subnet_id      = aws_subnet.pub_03.id
  route_table_id = aws_route_table.pubs.id
}

##
##  SubNet Pub04
##
resource "aws_subnet" "pub_04" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.11.0/24"
  availability_zone = "us-east-1d"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_pub_04-d"
  }
}

##
##  Route Table to Pub04 SubNet
##
resource "aws_route_table_association" "pub04" {
  subnet_id      = aws_subnet.pub_04.id
  route_table_id = aws_route_table.pubs.id
}

##
##  SubNet Pub05
##
resource "aws_subnet" "pub_05" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.12.0/24"
  availability_zone = "us-east-1e"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_pub_05-e"
  }
}

##
##  Route Table to Pub05 SubNet
##
resource "aws_route_table_association" "pub05" {
  subnet_id      = aws_subnet.pub_05.id
  route_table_id = aws_route_table.pubs.id
}


##
##  SubNet Pub06
##
resource "aws_subnet" "pub_06" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.13.0/24"
  availability_zone = "us-east-1f"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_pub_06-f"
  }
}

##
##  Route Table to Pub06 SubNet
##
resource "aws_route_table_association" "pub06" {
  subnet_id      = aws_subnet.pub_06.id
  route_table_id = aws_route_table.pubs.id
}
