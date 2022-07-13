output "arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = aws_athena_workgroup.default.arn
}

output "id" {
  description = "The globally unique identifier for the key"
  value       = aws_athena_workgroup.default.id
}
