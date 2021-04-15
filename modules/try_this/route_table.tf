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
