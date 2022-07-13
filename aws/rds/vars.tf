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

variable "vpc_id" {
  type = string
}

variable "from_port" {
  type = number
  default = 5432
}

variable "to_port" {
  type = number
  default = 5432
}

variable "identifier" {
  type    = string
  default = "rdsidentifier"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "engine" {
  type    = string
  default = "postgres"
}

variable "engine_version" {
  type    = string
  default = "13.2"
}

variable "name" {
  type    = string
  default = "rds_name"
}

variable "password" {
  type    = string
  default = "rds_password"
}

variable "username" {
  type    = string
  default = "rds_username"
}

variable "storage_type" {
  type    = string
  default = "gp2"
}

variable "subnet_data_group" {
  type = string
  default = "sgd"
}

variable "maintenance_window" {
  type = string
  default = "Sun:00:00-Sun:01:00"
}

variable "data_subnets_ids" { type = list(any) }

variable "backup_retention_period" {
  type    = number
  default = 5
}

variable "allocated_storage" {
  type    = number
  default = 10
}

variable "max_allocated_storage" {
  type    = number
  default = 20
}

variable "apply_immediately" {
  type = bool
  default = true
}

variable "storage_encrypted" {
  type = bool
  default = true
}

variable "publicly_accessible" {
  type = bool
  default = false
}

variable "skip_final_snapshot" {
  type = bool
  default = true
}

variable "auto_minor_version_upgrade" {
  type = bool
  default = true
}

variable "delete_automated_backups" {
  type = bool
  default = true
}

variable "tags" {
  type = map(string)
  default = {
    "Service" = "RDS"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
