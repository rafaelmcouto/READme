variable "databases" {
  description = "Map of database names to configuration."
  type        = map(any)
  default = {
    demo = { name = "demo", description = "-" }
  }
}

variable "prefix_role" { default = "AWSGlueServiceRole" }
variable "force_detach_policies" { default = false }
variable "managed_policy_arns" { default = ["arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"] }
variable "add_crawler" { default = true }

variable "role_crawlers" {
  description = "Map of crawlers names to configuration."
  type        = map(any)
  default = {
    demo = { name = "Demo", description = "-", bucket = "db-athena-output-dev" }
  }
}

variable "crawlers" {
  description = "Map of crawlers names to configuration."
  type        = map(any)
  default = {
    demo = { name = "demo", description = "-", bucket = "db-athena-output-dev", role = "Demo" }
  }
}

variable "tags" {
  type = map(string)
  default = {
    "Service" = "Glue"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
