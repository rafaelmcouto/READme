variable "name" {
  type    = string
  default = "default"
}
variable "description" {
  type    = string
  default = null
}
variable "load_balancer_arn" { type = string }

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
