output "name" {
  description = "Name of the Role"
  value       = aws_iam_role.default.name
}

output "arn" {
  description = "Arn of the Role"
  value       = aws_iam_role.default.arn
}
