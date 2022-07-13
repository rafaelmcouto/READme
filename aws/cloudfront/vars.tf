variable "identifier" { default = "default" }
variable "root_object" { default = "index.html" }
variable "allowed_methods" { default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"] }
variable "cached_methods" { default = ["GET", "HEAD"] }
variable "price_class" { default = "PriceClass_200" }
variable "viewer_protocol_policy" { default = "redirect-to-https" }
variable "min_ttl" { default = 0 }
variable "default_ttl" { default = 3600 }
variable "max_ttl" { default = 86400 }
variable "error_code" { default = 404 }
variable "response_code" { default = 404 }
variable "aliases" { default = [] }
variable "comment" { default = "-" }
variable "acm_certificate_arn" { default = null }
variable "default_certificate" { default = true }

variable "bucket_acl" { default = "private" }
variable "bucket_block_public_acls" { default = true }
variable "bucket_block_public_policy" { default = true }
variable "bucket_ignore_public_acls" { default = true }
variable "bucket_restrict_public_buckets" { default = true }

variable "tags" {
  type = map(string)
  default = {
    "Service" = "Cloudfront"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
