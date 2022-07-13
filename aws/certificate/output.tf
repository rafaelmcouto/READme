output "arn" {
  description = "ARN for the created Certificate"
  value       = aws_acm_certificate.default.arn
}

output "domain_name" {
  description = "Domain Name for the created Certificate"
  value       = aws_acm_certificate.default.domain_name
}

output "domain_validation_options" {
  description = "The name of the DNS record to create to validate the certificate"
  value       = var.validation_method == "DNS" ? aws_acm_certificate.default.domain_validation_options : []
}

output "validation_emails" {
  description = " A list of addresses that received a validation E-Mail"
  value       = var.validation_method == "EMAIL" ? aws_acm_certificate.default.validation_emails : []
}

output "status" {
  description = "Status of the certificate"
  value       = aws_acm_certificate.default.status
}
