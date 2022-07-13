output "arn" {
  description = "The ARN of the Instance"
  value       = aws_instance.default.arn
}

output "public_ip" {
  description = "The Public IP address of the Instance"
  value       = aws_eip.default.*.public_ip
}
