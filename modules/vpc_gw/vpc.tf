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

##
##  Route Table to SubNets Pubs
##
resource "aws_route_table" "pubs" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "RT Public - ${var.name}"
  }
}

##
##  SubNet Pub01
##
resource "aws_subnet" "pub_01" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.0/28"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_pub_01-a"
  }
}

##
##  Route Table Association to Pub01 SubNet
##
resource "aws_route_table_association" "pub01" {
  subnet_id      = aws_subnet.pub_01.id
  route_table_id = aws_route_table.pubs.id
}

##
##  EIP to Associate to Nat Gateway to Pub01
##
resource "aws_eip" "pub_01_gw" {
  vpc      = true

  tags = {
    Name = "EIP_${var.name}_pub_01-a"
  }
}

##
##  Nat Gateway to SubNet Pub01
##
resource "aws_nat_gateway" "pub_01_gw" {
  allocation_id = aws_eip.pub_01_gw.id
  subnet_id     = aws_subnet.pub_01.id

  tags = {
    Name = "NatGW_${var.name}_pub_01-a"
  }
}

##
##  SubNet Pub02
##
resource "aws_subnet" "pub_02" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.16/28"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_pub_02-b"
  }
}

##
##  Route Table Association to Pub02 SubNet
##
resource "aws_route_table_association" "pub02" {
  subnet_id      = aws_subnet.pub_02.id
  route_table_id = aws_route_table.pubs.id
}

##
##  EIP to Associate to Nat Gateway to Pub02
##
resource "aws_eip" "pub_02_gw" {
  vpc      = true

  tags = {
    Name = "EIP_${var.name}_pub_02-b"
  }
}

##
##  Nat Gateway to SubNet Pub02
##
resource "aws_nat_gateway" "pub_02_gw" {
  allocation_id = aws_eip.pub_02_gw.id
  subnet_id     = aws_subnet.pub_01.id

  tags = {
    Name = "NatGW_${var.name}_pub_02-b"
  }
}

##
##  SubNet Pub03
##
resource "aws_subnet" "pub_03" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.32/28"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_pub_03-c"
  }
}

##
##  Route Table Association to Pub03 SubNet
##
resource "aws_route_table_association" "pub03" {
  subnet_id      = aws_subnet.pub_03.id
  route_table_id = aws_route_table.pubs.id
}

##
##  EIP to Associate to Nat Gateway to Pub03
##
resource "aws_eip" "pub_03_gw" {
  vpc      = true

  tags = {
    Name = "EIP_${var.name}_pub_03-b"
  }
}

##
##  Nat Gateway to SubNet Pub03
##
resource "aws_nat_gateway" "pub_03_gw" {
  allocation_id = aws_eip.pub_03_gw.id
  subnet_id     = aws_subnet.pub_01.id

  tags = {
    Name = "NatGW_${var.name}_pub_03-b"
  }
}

##
##  SubNet Pub04
##
resource "aws_subnet" "pub_04" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.48/28"
  availability_zone = "us-east-1d"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_pub_04-d"
  }
}

##
##  Route Table Association to Pub04 SubNet
##
resource "aws_route_table_association" "pub04" {
  subnet_id      = aws_subnet.pub_04.id
  route_table_id = aws_route_table.pubs.id
}

##
##  EIP to Associate to Nat Gateway to Pub04
##
resource "aws_eip" "pub_04_gw" {
  vpc      = true

  tags = {
    Name = "EIP_${var.name}_pub_04-b"
  }
}

##
##  Nat Gateway to SubNet Pub04
##
resource "aws_nat_gateway" "pub_04_gw" {
  allocation_id = aws_eip.pub_04_gw.id
  subnet_id     = aws_subnet.pub_01.id

  tags = {
    Name = "NatGW_${var.name}_pub_04-b"
  }
}

##
##  SubNet Pub05
##
resource "aws_subnet" "pub_05" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.64/28"
  availability_zone = "us-east-1e"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_pub_05-e"
  }
}

##
##  Route Table Association to Pub05 SubNet
##
resource "aws_route_table_association" "pub05" {
  subnet_id      = aws_subnet.pub_05.id
  route_table_id = aws_route_table.pubs.id
}

##
##  EIP to Associate to Nat Gateway to Pub05
##
resource "aws_eip" "pub_05_gw" {
  vpc      = true

  tags = {
    Name = "EIP_${var.name}_pub_05-b"
  }
}

##
##  Nat Gateway to SubNet Pub05
##
resource "aws_nat_gateway" "pub_05_gw" {
  allocation_id = aws_eip.pub_05_gw.id
  subnet_id     = aws_subnet.pub_01.id

  tags = {
    Name = "NatGW_${var.name}_pub_05-b"
  }
}

##
##  SubNet Pub06
##
resource "aws_subnet" "pub_06" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.80/28"
  availability_zone = "us-east-1f"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_pub_06-f"
  }
}

##
##  Route Table Association to Pub06 SubNet
##
resource "aws_route_table_association" "pub06" {
  subnet_id      = aws_subnet.pub_06.id
  route_table_id = aws_route_table.pubs.id
}

##
##  EIP to Associate to Nat Gateway to Pub06
##
resource "aws_eip" "pub_06_gw" {
  vpc      = true

  tags = {
    Name = "EIP_${var.name}_pub_06-b"
  }
}

##
##  Nat Gateway to SubNet Pub06
##
resource "aws_nat_gateway" "pub_06_gw" {
  allocation_id = aws_eip.pub_06_gw.id
  subnet_id     = aws_subnet.pub_01.id

  tags = {
    Name = "NatGW_${var.name}_pub_06-b"
  }
}

##
##  Route Table to Private Pubs
##
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pub_01_gw.id
  }

  tags = {
    Name = "RT Private - ${var.name}"
  }
}

##
##  SubNet Private01
##
resource "aws_subnet" "priv_01" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.96/28"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.name}_priv_01-a"
  }
}

##
##  Route Table Association to Priv01 SubNet
##
resource "aws_route_table_association" "priv_01" {
  subnet_id      = aws_subnet.priv_01.id
  route_table_id = aws_route_table.private.id
}

##
##  SubNet Private02
##
resource "aws_subnet" "priv_02" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.112/28"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.name}_priv_02-b"
  }
}

##
##  Route Table Association to Priv02 SubNet
##
resource "aws_route_table_association" "priv_02" {
  subnet_id      = aws_subnet.priv_02.id
  route_table_id = aws_route_table.private.id
}

##
##  SubNet Private03
##
resource "aws_subnet" "priv_03" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.128/28"
  availability_zone = "us-east-1c"

  tags = {
    Name = "${var.name}_priv_03-c"
  }
}

##
##  Route Table Association to Priv03 SubNet
##
resource "aws_route_table_association" "priv_03" {
  subnet_id      = aws_subnet.priv_03.id
  route_table_id = aws_route_table.private.id
}

##
##  SubNet Private04
##
resource "aws_subnet" "priv_04" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.144/28"
  availability_zone = "us-east-1d"

  tags = {
    Name = "${var.name}_priv_04-d"
  }
}

##
##  Route Table Association to Priv04 SubNet
##
resource "aws_route_table_association" "priv_04" {
  subnet_id      = aws_subnet.priv_04.id
  route_table_id = aws_route_table.private.id
}

##
##  SubNet Private05
##
resource "aws_subnet" "priv_05" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.160/28"
  availability_zone = "us-east-1e"

  tags = {
    Name = "${var.name}_priv_05-e"
  }
}

##
##  Route Table Association to Priv05 SubNet
##
resource "aws_route_table_association" "priv_05" {
  subnet_id      = aws_subnet.priv_05.id
  route_table_id = aws_route_table.private.id
}

##
##  SubNet Private06
##
resource "aws_subnet" "priv_06" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.64.0.176/28"
  availability_zone = "us-east-1f"

  tags = {
    Name = "${var.name}_priv_06-f"
  }
}

##
##  Route Table Association to Priv06 SubNet
##
resource "aws_route_table_association" "priv_06" {
  subnet_id      = aws_subnet.priv_06.id
  route_table_id = aws_route_table.private.id
}
