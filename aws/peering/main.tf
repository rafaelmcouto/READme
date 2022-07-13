provider "aws" {
  alias  = "accepter"
  region = var.accepter_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc_peering_connection" "owner" {
  peer_owner_id = data.aws_vpc.accepter.owner_id # ID da Conta Accepter
  peer_vpc_id   = data.aws_vpc.accepter.id       # VPC da Conta Accepter
  vpc_id        = var.vpc_id                     # VPC da Conta Owner
  peer_region   = var.accepter_region            # Região da Conta Accepter
  tags = merge(
    tomap({
      "Name" = "Peering_${title(var.name_vpc_owner)}_to_${title(var.name_vpc_accepter)}"
   }),
    var.tags,
    var.tags_shared
  )
}

resource "aws_vpc_peering_connection_accepter" "accepter" {
  provider                  = aws.accepter
  vpc_peering_connection_id = aws_vpc_peering_connection.owner.id
  auto_accept               = true
  tags = merge(
    tomap({
      "Name" = "Peering_${title(var.name_vpc_owner)}_to_${title(var.name_vpc_accepter)}"
    }),
    var.tags,
    var.tags_shared
  )
}

resource "aws_route" "owner" {
  route_table_id            = var.route_table_id
  destination_cidr_block    = data.aws_vpc.accepter.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.owner.id
}

resource "aws_route" "accepter" {
  provider                  = aws.accepter
  route_table_id            = data.aws_route_table.accepter.id
  destination_cidr_block    = var.destination_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.owner.id
}

data "aws_vpc" "accepter" {
  provider = aws.accepter
  filter {
    name   = "tag:Name"
    values = [var.name_vpc_accepter]
  }
}

data "aws_route_table" "accepter" {
  provider  = aws.accepter
  subnet_id = var.subnet_id_accepter
}
