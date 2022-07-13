variable "domain_name" { type = string }
variable "certificate_arn" { default = null }
variable "regional_certificate_arn" { default = null }
variable "security_policy" { default = "TLS_1_2" }

variable "endpoint_type" { default = "EDGE" }
variable "tags" {
  type = map(string)
  default = {
    "Service" = "API CDN"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
