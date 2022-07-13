variable "name" {
  type    = string
  default = "default"
}

variable "security_group_ids" { type = list(string) }

variable "subnets_ids" { type = list(string) }
variable "tags" {
  type = map(string)
  default = {
    "Service" = "VPC Links"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
