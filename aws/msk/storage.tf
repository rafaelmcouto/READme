############################################################################################
#   MSK Storage Logging Info
############################################################################################
resource "random_uuid" "logs" {}

resource "aws_s3_bucket" "logs" {
  bucket = "msk-${substr("${var.msk_name}-${random_uuid.logs.result}", 0, 45)}-broker-logs"
  acl    = var.bucket_acl

  tags = merge(
    var.tags,
    var.tags_shared
  )
}

resource "aws_s3_bucket_public_access_block" "logs" {
  bucket                  = aws_s3_bucket.logs.id
  block_public_acls       = var.bucket_block_public_acls
  block_public_policy     = var.bucket_block_public_policy
  ignore_public_acls      = var.bucket_ignore_public_acls
  restrict_public_buckets = var.bucket_restrict_public_buckets
}
