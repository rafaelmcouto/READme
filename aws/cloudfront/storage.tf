############################################################################################
#   Cloudfront Storage
############################################################################################

resource "random_uuid" "origin" {}

resource "aws_s3_bucket" "origin" {
  bucket = "cloudfront-${substr("${var.identifier}-${random_uuid.origin.result}", 0, 45)}-origin"
  acl    = var.bucket_acl
  policy = data.aws_iam_policy_document.origin.json

  tags = merge(
    var.tags,
    var.tags_shared
  )
}

resource "aws_s3_bucket_public_access_block" "origin" {
  bucket                  = aws_s3_bucket.origin.id
  block_public_acls       = var.bucket_block_public_acls
  block_public_policy     = var.bucket_block_public_policy
  ignore_public_acls      = var.bucket_ignore_public_acls
  restrict_public_buckets = var.bucket_restrict_public_buckets
}
