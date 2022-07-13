output "id" {
  description = "ECR Repository ID"
  value       = aws_ecr_repository.default.id
}

output "url" {
  description = "ECR Repository Url"
  value       = aws_ecr_repository.default.repository_url
}
