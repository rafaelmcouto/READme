output "bucket_name" {
  value = aws_s3_bucket.default.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.default.id
}
