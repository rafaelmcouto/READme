variable "name" { default = "default" }
variable "description" { default = "" }
variable "state" { default = "ENABLED" }
variable "force_destroy" { default = false }
variable "enforce_configuration" { default = true }
variable "cloudwatch_metrics_enabled" { default = true }

variable "result_configuration" {
  type = list(object({
    output_location          = string
    encryption_configuration = object({ encryption_option = string, kms_key_arn = string })
  }))
  default = []
}

variable "tags" {
  type = map(string)
  default = {
    "Service" = "Athena"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
