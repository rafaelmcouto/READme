variable "bucket_name" { type = string }
variable "bucket_acl" { default = "private" }
variable "bucket_block_public_acls" { default = true }
variable "bucket_block_public_policy" { default = true }
variable "bucket_ignore_public_acls" { default = true }
variable "bucket_restrict_public_buckets" { default = true }
variable "bucket_policy" { default = null }

variable "dynamodb_table_name" { type = string }
variable "dynamodb_table_hash_key" { default = "LockID" }
variable "dynamodb_table_read_capacity" { default = 20 }
variable "dynamodb_table_write_capacity" { default = 20 }
variable "dynamodb_table_attribute_name" { default = "LockID" }
variable "dynamodb_table_attribute_type" { default = "S" }

variable "devops_user" { default = "terraform.devops" }

variable "tags_s3" {
  type = map(string)
  default = {
    "Service" = "S3"
  }
}

variable "tags_dynamodb" {
  type = map(string)
  default = {
    "Service" = "DynamoDB"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
