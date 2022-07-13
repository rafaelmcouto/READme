############################################################################################
#   Cloudfront Policy
############################################################################################
resource "aws_cloudfront_origin_access_identity" "default" {
  comment = "This is the access identity used in the bucket"
}

data "aws_iam_policy_document" "origin" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.default.iam_arn]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::cloudfront-${substr("${var.identifier}-${random_uuid.origin.result}", 0, 45)}-origin",
      "arn:aws:s3:::cloudfront-${substr("${var.identifier}-${random_uuid.origin.result}", 0, 45)}-origin/*",
    ]
  }
}
