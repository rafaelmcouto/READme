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
##  EIP to Associate to Nat Gateway to Pub06
##
#resource "aws_eip" "pub_06_gw" {
#  vpc      = true
#
#  tags = {
#    Name = "EIP_${var.name}_pub_06-b"
#  }
#}

##
##  Nat Gateway to SubNet Pub06
##
#resource "aws_nat_gateway" "pub_06_gw" {
#  allocation_id = aws_eip.pub_06_gw.id
#  subnet_id     = aws_subnet.pub_01.id
#
#  tags = {
#    Name = "NatGW_${var.name}_pub_06-b"
#  }
#}
