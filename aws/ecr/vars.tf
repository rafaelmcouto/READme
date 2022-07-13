variable "name" { type = string }
variable "image_tag_mutability" { default = "MUTABLE" }
variable "policy" { default = null }
variable "create_policy" { default = false }

variable "tags" {
  type = map(string)
  default = {
    "Service" = "ECR"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
