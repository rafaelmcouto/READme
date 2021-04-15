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
##  SubNet Pub06
##
#resource "aws_subnet" "pub_06" {
#  vpc_id            = aws_vpc.main.id
#  cidr_block        = "10.64.0.80/28"
#  availability_zone = "us-east-1f"
#  map_public_ip_on_launch = true
#
#  tags = {
#    Name = "${var.name}_pub_06-f"
#  }
#}
