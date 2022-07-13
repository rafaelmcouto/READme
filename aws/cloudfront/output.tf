############################################################################################
#   Cloudfront Output
############################################################################################
output "id" {
  description = "The identifier for the Distribution"
  value       = aws_cloudfront_distribution.default.id
}

output "arn" {
  description = "ARN for the created Distribution"
  value       = aws_cloudfront_distribution.default.arn
}

output "domain_name" {
  description = "Domain Name for the created Distribution"
  value       = aws_cloudfront_distribution.default.domain_name
}

output "status" {
  description = "Status of the Distribution"
  value       = aws_cloudfront_distribution.default.status
}
