variable "name" { type = string }
variable "ami" { default = "ami-09e67e426f25ce0d7" }
variable "instance_type" { default = "t3.small" }
variable "volume_size" { default = 10 }
variable "volume_type" { default = "gp3" }
variable "vpc_id" { type = string }
variable "subnet_id" { type = string }
variable "kms_arn" { type = string }
variable "delete_on_termination" { default = true }
variable "encrypted" { default = true }

variable "is_enabled_public_ip" { default = false }

variable "cloudwatch_is_enabled_create_alarm" { default = false }
variable "cloudwatch_threshold"    { default = 70 }
variable "cloudwatch_alarm_actions_sns_arn"  { default = [] }

variable "security_group_ingress" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "A list of listener blocks"
  default = [
    {
      description = null
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "tags" {
  type = map(string)
  default = {
    "Service" = "EC2"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
