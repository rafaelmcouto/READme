variable "ds_name" { type = string }
variable "password" { type = string }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }

variable "description" {
  type = string
  default = "A new Active Directory"
}

variable "edition" {
  type = string
  default = "Standard"
}

variable "type" {
  type = string
  default = "MicrosoftAD"
}

variable "tags" {
  type = map(string)
  default = {
    "Service" = "Directory Service"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "SYS"
  }
}
