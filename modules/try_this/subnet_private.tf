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
##  SubNet Private06
##
#resource "aws_subnet" "priv_06" {
#  vpc_id            = aws_vpc.main.id
#  cidr_block        = "10.64.0.176/28"
#  availability_zone = "us-east-1f"
#
#  tags = {
#    Name = "${var.name}_priv_06-f"
#  }
#}
