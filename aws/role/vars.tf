variable "name" { type = string }
variable "description" { default = "" }
variable "policy" { type = string }
variable "actions" { default = ["sts:AssumeRole"] }
variable "principals_type" { default = "Service" }
variable "principals_identifiers" { type = list(string) }
variable "force_detach_policies" { default = true }

variable "tags" {
  type = map(string)
  default = {
    "Service" = "Role"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
