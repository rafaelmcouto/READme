output "id" {
  description = "ID for the created API Gateway Rest"
  value       = aws_api_gateway_rest_api.default.id
}

output "arn" {
  description = "ARN for the created API Gateway Rest"
  value       = aws_api_gateway_rest_api.default.arn
}

output "stage_name" {
  description = "STAGES for the created API Gateway"
  value = tomap({
    for k, v in aws_api_gateway_stage.default : k => v.stage_name
  })
}
