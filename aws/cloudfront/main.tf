############################################################################################
#   Cloudfront Distribution
############################################################################################
resource "aws_cloudfront_distribution" "default" {
  origin {
    domain_name = aws_s3_bucket.origin.bucket_domain_name
    origin_id   = aws_s3_bucket.origin.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.root_object
  price_class         = var.price_class
  aliases             = var.aliases
  comment             = var.comment

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = aws_s3_bucket.origin.id

    forwarded_values {
      query_string = true
      headers      = ["Access-Control-Allow-Origin"]
      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    cloudfront_default_certificate = var.default_certificate
    ssl_support_method             = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code         = var.error_code
    response_code      = var.response_code
    response_page_path = "/${var.root_object}"
  }

  tags = merge(
    var.tags,
    var.tags_shared
  )

  depends_on = [aws_s3_bucket.origin]
}
