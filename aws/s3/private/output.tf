output "arn" {
  description = "ARN for the created S3"
  value       = aws_s3_bucket.bucket.arn
}

output "id" {
  description = "ID for the created S3"
  value       = aws_s3_bucket.bucket.id
}

output "bucket_domain_name" {
  description = "Bucket Domain Name for the created S3"
  value       = aws_s3_bucket.bucket.bucket_domain_name
}
