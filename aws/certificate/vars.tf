variable "certificate_name" { 
  type = string
  default = "-"
}
variable "domain_name" { type = string }
variable "validation_method" { default = "DNS" }
variable "subject_alternative_names" {
  type    = list(string)
  default = []
}

variable "tags" {
  type = map(string)
  default = {
    "Service" = "ACM"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
