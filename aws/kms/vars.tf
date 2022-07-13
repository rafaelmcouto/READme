variable "description" { default = "-" }
variable "key_usage" { default = "ENCRYPT_DECRYPT" }
variable "customer_master_key_spec" { default = "SYMMETRIC_DEFAULT" }
variable "policy" { default = null }
variable "deletion_window_in_days" { default = 30 }
variable "is_enabled" { default = true }
variable "enable_key_rotation" { default = false }

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}

variable "key_alias" { type = string }
