variable "vpc_id" { type = string }
variable "private_subnets_ids" { type = list(string) }
variable "msk_name" { type = string }

variable "msk_version" { default = ["2.8.0"] }
variable "msk_number_of_brokers" { default = 3 }
variable "msk_broker_instance_size" { default = "kafka.t3.small" }
variable "msk_broker_ebs_size" { default = 10 }
variable "msk_prometheus_jmx_exporter" { default = true }
variable "msk_prometheus_node_exporter" { default = true }
variable "msk_broker_client_encryption_in_transit" { default = "TLS" }
variable "msk_broker_in_cluster_encryption_in_transit" { default = true }
variable "msk_enhanced_monitoring" { default = "PER_BROKER" }
variable "msk_allowed_output_ips" { default = ["0.0.0.0/0"] }
variable "msk_allowed_security_group_ids" { default = [] }
variable "msk_server_properties_file_path" { default = null }
variable "msk_storage_autoscalling_config" {
  default = {
    msk_broker_maximum_ebs_size    = 100
    autoscalling_percentage_target = 75
  }
}
variable "cloudwatch_retention_in_days" { default = 7 }
variable "bucket_acl" { default = "private" }
variable "bucket_block_public_acls" { default = true }
variable "bucket_block_public_policy" { default = true }
variable "bucket_ignore_public_acls" { default = true }
variable "bucket_restrict_public_buckets" { default = true }

variable "tags" {
  type = map(string)
  default = {
    "Service" = "MSK"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}
