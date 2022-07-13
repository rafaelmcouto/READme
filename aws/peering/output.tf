#
#   Output from aws_vpc_peering_connection
#
output "aws_vpc_peering_connection_id" {
  value = "aws_vpc_peering_connection.owner.id"
}

output "aws_vpc_peering_connection_accept_status" {
  value = "aws_vpc_peering_connection.owner.accept_status"
}

#
#   Output from aws_route
#
output "aws_route_owner_id" {
  value = "aws_route.owner.id"
}

output "aws_route_accepter_id" {
  value = "aws_route.accepter.id"
}

#
#   Output from aws_vpc_peering_connection_accepter
#
output "aws_vpc_peering_connection_accepter_id" {
  value = "aws_vpc_peering_connection_accepter.accepter.id"
}

output "aws_vpc_peering_connection_accepter_vpc_id" {
  value = "aws_vpc_peering_connection_accepter.accepter.vpc_id"
}

output "aws_vpc_peering_connection_accepter_peer_vpc_id" {
  value = "aws_vpc_peering_connection_accepter.accepter.peer_vpc_id"
}

output "aws_vpc_peering_connection_accepter_peer_owner_id" {
  value = "aws_vpc_peering_connection_accepter.accepter.peer_owner_id"
}