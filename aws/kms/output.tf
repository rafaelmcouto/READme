output "arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = aws_kms_key.default.arn
}

output "key_id" {
  description = "The globally unique identifier for the key"
  value       = aws_kms_key.default.key_id
}

output "alias_arn" {
  description = "The Amazon Resource Name (ARN) of the target key"
  value       = aws_kms_alias.default.arn
}

output "alias_name" {
  description = "The Amazon Resource Name (ARN) of the target key"
  value       = aws_kms_alias.default.name
}
