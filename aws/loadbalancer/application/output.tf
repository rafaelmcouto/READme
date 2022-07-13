output "arn" {
  description = "The ARN of the LB"
  value       = aws_lb.default.arn
}

output "name" {
  description = "The Name of the LB"
  value       = aws_lb.default.name
}

output "dns_name" {
  description = "The DNS name of the LB"
  value       = aws_lb.default.dns_name
}
