variable "subnet_group_name" {
  default = "elasticache-subgroup"
}
variable "replication_group_id" { 
  default = "tf-rep-group-1"
}
variable "replication_group_description" {
  default = "test description" 
}
variable "node_type" {
  default = "cache.t3.small" 
}

variable "number_cache_clusters" {
  default = 1 
}
variable "parameter_group_name" { 
  default = "default.redis6.x" 
}
variable "port" { 
  default = 6379 
}
variable "vpc_id" { 
  type = string 
}

variable "availability_zones" {
  default = ["us-east-1a"]
}

variable "at_rest_encryption_enabled" {
  default = true
}

variable "transit_encryption_enabled" {
  default = true
}
variable "apply_immediately" {
  default = true
}

variable "maintenance_window" {
  default = "sun:05:00-sun:06:00"
}

variable "automatic_failover_enabled" {
  default = false
}

variable "subnet_ids" {
    type = list(string)
}

variable "ingress" {
  type = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    security_groups = list(string)
  }))
  default = []
}

variable "tags" {
  type = map(string)
  default = {
    "Service" = "Redis"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
