variable "bucket" { type = string }
variable "acl" { default = "public-read" }
variable "policy" { type = string }
variable "block_public_acls" { default = false }
variable "block_public_policy" { default = false }
variable "ignore_public_acls" { default = false }
variable "restrict_public_buckets" { default = false }

variable "index_document" { default = "index.html" }

variable "error_document" { default = "error.html" }

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
