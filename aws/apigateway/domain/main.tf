resource "aws_api_gateway_domain_name" "default" {
  regional_certificate_arn = var.regional_certificate_arn
  certificate_arn          = var.certificate_arn
  domain_name              = var.domain_name
  security_policy          = var.security_policy

  endpoint_configuration {
    types = [var.endpoint_type]
  }

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
