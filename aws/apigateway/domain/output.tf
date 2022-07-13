output "domain_name" {
  description = "NAME for the created API Gateway Domain"
  value       = aws_api_gateway_domain_name.default.domain_name
}
