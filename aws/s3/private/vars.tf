variable "bucket" { type = string }
variable "acl" { default = "private" }
variable "block_public_acls" { default = true }
variable "block_public_policy" { default = true }
variable "ignore_public_acls" { default = true }
variable "restrict_public_buckets" { default = true }
variable "bucket_policy" { default = null }

variable "cors_rules" {
  type = list(object({
    allowed_headers = list(string)
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = list(string)
    max_age_seconds = number
  }))
  default = []
}

variable "lifecycle_rules" {
  type = list(object({
    id         = string
    prefix     = string
    enabled    = bool
    expiration = object({ days = number })
  }))
  default = []
}

variable "tags_s3" {
  type = map(string)
  default = {
    "Service" = "S3"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
