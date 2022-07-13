
############################################################################################
#   SETTINGS
############################################################################################
variable "eks_cluster_name" { default = "logging" }
variable "eks_region" { default = "us-east-1" }
variable "eks_profile" { default = "sandbox" }
variable "eks_kafka_namespace" { default = "kafka" }
variable "destination_filename" { default = "setup" }
variable "destination_file_path" { default = "./eks" }
variable "destination_file_permission" { default = "0755" }

############################################################################################
#   INSTALL SCHEMA REGISTRY
############################################################################################
variable "eks_install_schema_registry" { default = false }
variable "eks_schema_registry_node_selector" { default = "data" }
variable "eks_schema_registry_heap_options" { default = "-Xms512M -Xmx512M" }
variable "eks_schema_registry_bootstrap_servers" { default = null }
variable "eks_schema_registry_broker_client_encryption" { default = "PLAINTEXT" }

############################################################################################
#   INSTALL KAFKA CONNECT
############################################################################################
variable "eks_install_kafka_connect" { default = false }
variable "eks_kafka_connect_node_selector" { default = "worker" }
variable "eks_kafka_connect_heap_options" { default = "-Xms512M -Xmx4096M" }
variable "eks_kafka_connect_bootstrap_servers" { default = null }
variable "eks_kafka_connect_broker_client_encryption" { default = "PLAINTEXT" }

############################################################################################
#   INSTALL KSQL SERVER
############################################################################################
variable "eks_install_ksql_server" { default = false }

variable "eks_ksql_server_headless" { default = false }
variable "eks_ksql_server_logging_processing_stream" { default = true }
variable "eks_ksql_server_logging_processing_topic" { default = true }
variable "eks_ksql_server_node_selector" { default = "data" }
variable "eks_ksql_server_heap_options" { default = "-Xms512M -Xmx512M" }
variable "eks_ksql_server_bootstrap_servers" { default = null }
variable "eks_ksql_server_broker_client_encryption" { default = "PLAINTEXT" }

############################################################################################
#   INSTALL FLUENTD
############################################################################################
variable "eks_install_fluentd" { default = false }
variable "eks_fluentd_namespace" { default = "fluentd" }
variable "eks_fluentd_node_selector" { default = "data" }
variable "eks_fluentd_bootstrap_servers" { default = null }
variable "eks_fluentd_default_topic" { default = "k8s_fluentd" }
variable "eks_fluentd_broker_client_encryption" { default = "PLAINTEXT" }