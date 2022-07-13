resource "aws_s3_bucket" "default" {
  bucket = var.bucket_name
  acl    = var.bucket_acl
  policy = var.bucket_policy

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(
    var.tags_s3,
    var.tags_shared
  )
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.default.id
  block_public_acls       = var.bucket_block_public_acls
  block_public_policy     = var.bucket_block_public_policy
  ignore_public_acls      = var.bucket_ignore_public_acls
  restrict_public_buckets = var.bucket_restrict_public_buckets
}

resource "aws_dynamodb_table" "default" {
  name           = var.dynamodb_table_name
  hash_key       = var.dynamodb_table_hash_key
  read_capacity  = var.dynamodb_table_read_capacity
  write_capacity = var.dynamodb_table_write_capacity

  attribute {
    name = var.dynamodb_table_attribute_name
    type = var.dynamodb_table_attribute_type
  }

  tags = merge(
    var.tags_dynamodb,
    var.tags_shared
  )
}

resource "aws_s3_bucket_policy" "inline_policy" {
  bucket = aws_s3_bucket.default.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "DenyAccessBucketTFState"
    Statement = [
      {
        Sid       = "CloseBucketTFState"
        Principal = "*"
        Action    = "s3:*"
        Effect    = "Deny"
        Resource = [
          aws_s3_bucket.default.arn
        ]
        Condition = {
          StringNotEquals = {
            "aws:username" = var.devops_user
          }
        }
      }
    ]
  })
}
