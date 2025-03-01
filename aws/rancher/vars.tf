variable "public_subnets_ids" { type = list(string) }
variable "ssh_allowed_ips" { default = ["0.0.0.0/0"]  }
variable "ssh_create_key" { default = true }
variable "ssh_public_key" { default = null }
variable "ssh_key_name" { type = string }
variable "instance_size" { default = "t3.medium" }
variable "rancher_ebs_type" { default = "gp3" }
variable "rancher_ebs_root_size_gb" { default = 10 }
variable "rancher_ebs_size_gb" { default = 20 }
variable "rancher_ebs_device_name" { default = "/dev/sdf" }
variable "rancher_ebs_mount_point" { default = "/data" }
variable "rancher_hostname_domain" { type = string }
variable "tags_shared" { type = map(string) }