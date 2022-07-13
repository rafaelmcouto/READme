resource "aws_api_gateway_vpc_link" "default" {
  name        = var.name
  description = var.description
  target_arns = [var.load_balancer_arn]

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
