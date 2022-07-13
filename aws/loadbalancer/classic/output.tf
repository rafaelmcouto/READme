output "arn" {
  description = "The ARN of the ELB"
  value       = aws_elb.default.arn
}

output "name" {
  description = "The Name of the ELB"
  value       = aws_elb.default.name
}

output "dns_name" {
  description = "The DNS name of the ELB"
  value       = aws_elb.default.dns_name
}
