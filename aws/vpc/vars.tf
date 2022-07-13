variable "vpc_name" { default = "default" }
variable "vpc_cidr_block" { default = "10.100.0.0/16" }
variable "app_subnets_cidr_block" { default = ["10.100.0.0/20", "10.100.16.0/20", "10.100.32.0/20", "10.100.48.0/20", "10.100.64.0/20", "10.100.80.0/20"] }
variable "data_subnets_cidr_block" { default = ["10.100.96.0/24", "10.100.97.0/24", "10.100.98.0/24"] }
variable "pub_subnets_cidr_block" { default = ["10.100.100.0/22", "10.100.104.0/22", "10.100.108.0/22"] }
variable "app_subnets" { default = 6 }
variable "data_subnets" { default = 3 }
variable "pub_subnets" { default = 3 }
variable "all_allowed_output_ips" { default = "0.0.0.0/0" }
variable "is_eks_enabled" { default = false }
variable "eks_name" { default = null }

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner" = "Engineer"
  }
}
