variable "name" { default = null }
variable "name_prefix" { default = null }
variable "security_groups_ids" { default = [] }
variable "subnets_ids" { default = [] }
variable "instances_ids" { default = [] }
variable "internal" { default = false }

variable "listeners" {
  type = list(object({
    instance_port      = number
    instance_protocol  = string
    lb_port            = number
    lb_protocol        = string
    ssl_certificate_id = string
  }))
  description = "A list of listener blocks"
}

variable "health_check" {
  type = list(object({
    healthy_threshold   = number
    unhealthy_threshold = number
    target              = string /* ${PROTOCOL}:${PORT}${PATH} */
    interval            = number
    timeout             = number
  }))
  description = "A health_check block."
  default     = []
}

variable "cross_zone_load_balancing" { default = true }
variable "idle_timeout" { default = 60 }
variable "connection_draining" { default = false }
variable "connection_draining_timeout" { default = 300 }

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
