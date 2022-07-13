output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The Cidr Block of the VPC"
  value       = aws_vpc.vpc.cidr_block
}

output "pub_subnets" {
  description = "The Ids of pub subnets"
  value       = aws_subnet.pub.*.id
}

output "pub_subnets_cidr_block" {
  description = "The Ids of pub subnets"
  value       = aws_subnet.pub.*.cidr_block
}

output "pub_routing_table_id" {
  value = aws_route_table.pub-route-table.id
}

output "data_subnets" {
  description = "The Ids of app subnets"
  value       = aws_subnet.data.*.id
}

output "data_subnets_cidr_block" {
  description = "The Ids of app subnets"
  value       = aws_subnet.data.*.cidr_block
}

output "data_routing_table_id" {
  value = aws_route_table.data-route-table.id
}

output "app_subnets" {
  description = "The Ids of app subnets"
  value       = aws_subnet.app.*.id
}

output "app_subnets_cidr_block" {
  description = "The Ids of app subnets"
  value       = aws_subnet.app.*.cidr_block
}

output "app_routing_table_id" {
  value = aws_route_table.app-route-table.id
}

output "vpc_default_security_group" {
  description = "The VPC`s default security group id"
  value       = aws_vpc.vpc.default_security_group_id
}

output "vpc_internet_gateway" {
  description = "The VPC`s default internet gateway"
  value       = aws_internet_gateway.igw
}

output "app_subnets_availability_zone" {
  description = "The availability zone of app subnets"
  value       = aws_subnet.app.*.availability_zone
}

output "data_subnets_availability_zone" {
  description = "The availability zone of data subnets"
  value       = aws_subnet.data.*.availability_zone
}

output "pub_subnets_availability_zone" {
  description = "The availability zone of app subnets"
  value       = aws_subnet.pub.*.availability_zone
}
