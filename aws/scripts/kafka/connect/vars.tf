############################################################################################
#   DOCKERFILE
############################################################################################
variable "dockerfile_image" { default = "confluentinc/cp-kafka-connect:6.1.0" }

variable "dockerfile_runners" {
  type = list(string)
  default = [
    "RUN confluent-hub install --no-prompt debezium/debezium-connector-sqlserver:1.4.0",
    "RUN confluent-hub install --no-prompt debezium/debezium-connector-mysql:1.6.0",
    "RUN confluent-hub install --no-prompt confluentinc/kafka-connect-s3:10.0.0",
    "RUN confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.1.0",
    "RUN confluent-hub install --no-prompt mongodb/kafka-connect-mongodb:1.5.0",
    "RUN confluent-hub install --no-prompt confluentinc/kafka-connect-s3-source:1.4.4",
    "RUN confluent-hub install --no-prompt confluentinc/kafka-connect-replicator:5.3.1",
    "RUN confluent-hub install --no-prompt confluentinc/kafka-connect-elasticsearch:11.0.6"
  ]
}

variable "dockerfile_destination_filename" { default = "Dockerfile" }
variable "destination_file_path" { default = "./build" }
variable "destination_file_permission" { default = "0755" }

############################################################################################
#   REGISTRY
############################################################################################
variable "registry_url" { type = string }
variable "registry_region" { default = "us-east-1" }
variable "registry_image_name" { default = "kafka-connect" }
variable "registry_image_tag" { default = "latest" }
variable "registry_destination_filename" { default = "build" }
