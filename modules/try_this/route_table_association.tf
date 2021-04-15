##
##  Route Table Association to Pub01 SubNet
##
resource "aws_route_table_association" "pub01" {
  subnet_id      = aws_subnet.pub_01.id
  route_table_id = aws_route_table.pubs.id
}

##
##  Route Table Association to Pub02 SubNet
##
resource "aws_route_table_association" "pub02" {
  subnet_id      = aws_subnet.pub_02.id
  route_table_id = aws_route_table.pubs.id
}

##
##  Route Table Association to Pub03 SubNet
##
resource "aws_route_table_association" "pub03" {
  subnet_id      = aws_subnet.pub_03.id
  route_table_id = aws_route_table.pubs.id
}

##
##  Route Table Association to Pub04 SubNet
##
resource "aws_route_table_association" "pub04" {
  subnet_id      = aws_subnet.pub_04.id
  route_table_id = aws_route_table.pubs.id
}

##
##  Route Table Association to Pub05 SubNet
##
resource "aws_route_table_association" "pub05" {
  subnet_id      = aws_subnet.pub_05.id
  route_table_id = aws_route_table.pubs.id
}

##
##  Route Table Association to Pub06 SubNet
##
#resource "aws_route_table_association" "pub06" {
#  subnet_id      = aws_subnet.pub_06.id
#  route_table_id = aws_route_table.pubs.id
#}

##
##  Route Table Association to Priv01 SubNet
##
resource "aws_route_table_association" "priv_01" {
  subnet_id      = aws_subnet.priv_01.id
  route_table_id = aws_route_table.private.id
}

##
##  Route Table Association to Priv02 SubNet
##
resource "aws_route_table_association" "priv_02" {
  subnet_id      = aws_subnet.priv_02.id
  route_table_id = aws_route_table.private.id
}

##
##  Route Table Association to Priv03 SubNet
##
resource "aws_route_table_association" "priv_03" {
  subnet_id      = aws_subnet.priv_03.id
  route_table_id = aws_route_table.private.id
}

##
##  Route Table Association to Priv04 SubNet
##
resource "aws_route_table_association" "priv_04" {
  subnet_id      = aws_subnet.priv_04.id
  route_table_id = aws_route_table.private.id
}

##
##  Route Table Association to Priv05 SubNet
##
resource "aws_route_table_association" "priv_05" {
  subnet_id      = aws_subnet.priv_05.id
  route_table_id = aws_route_table.private.id
}

##
##  Route Table Association to Priv06 SubNet
##
#resource "aws_route_table_association" "priv_06" {
#  subnet_id      = aws_subnet.priv_06.id
#  route_table_id = aws_route_table.private.id
#}
