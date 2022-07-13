variable "name" { default = null }
variable "name_prefix" { default = null }
variable "subnets_ids" { default = [] }
variable "internal" { default = false }
variable "load_balancer_type" { default = "network" }
variable "enable_deletion_protection" { default = false }
variable "idle_timeout" { default = 60 }
variable "enable_cross_zone_load_balancing" { default = true }

variable "access_logs" {
  type = list(object({
    bucket  = string
    prefix  = string
    enabled = bool
  }))
  description = "A bucket acess logs blocks"
  default     = []
}

variable "subnet_mapping" {
  type = list(object({
    subnet_id            = string
    allocation_id        = string
    private_ipv4_address = string
  }))
  description = "A list subnet mappings blocks"
  default     = []
}

variable "listeners" {
  type = map(object({
    port            = number
    protocol        = string
    ssl_policy      = string
    certificate_arn = string
    default_action = object({
      type             = string
      target_group_arn = string
    })
  }))
  description = "Map of listerners arguments of configuration."
  default     = {}
}

variable "tags" {
  type = map(string)
  default = {
    "Service" = "ELB"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
