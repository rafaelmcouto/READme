resource "aws_s3_bucket" "first_bucket" {
  bucket = var.name
  acl    = "private"

  tags = local.common_tags
}