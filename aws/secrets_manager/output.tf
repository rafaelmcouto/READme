output "id" {
    value = aws_secretsmanager_secret_version.secret_value.id
}

output "arn" {
    value = aws_secretsmanager_secret_version.secret_value.arn
}

output "secret_string" {
    value = data.aws_secretsmanager_secret_version.by-version-stage.secret_string
    sensitive = true
}
