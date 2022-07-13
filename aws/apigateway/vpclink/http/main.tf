resource "aws_apigatewayv2_vpc_link" "default" {
  name               = var.name
  security_group_ids = var.security_group_ids
  subnet_ids         = var.subnets_ids

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
