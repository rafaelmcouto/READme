variable "name" {
  type    = string
  default = "default"
}

variable "description" {
  type    = string
  default = "-"
}

variable "swagger_path" { default = null }
variable "saved_deployments_path" { default = null }
variable "stages" {
  type    = map(any)
  default = {}
}

variable "endpoint_type" { default = "EDGE" }
variable "tags" {
  type = map(string)
  default = {
    "Service" = "API"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
