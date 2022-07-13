
locals {
  kafka_chart_path  = "../${path.module}/values/kafka"
  fluent_chart_path = "../${path.module}/values/fluent"
}

data "template_file" "shell-setup-script" {
  template = file("${path.module}/scripts/setup.sh")
  vars = {
    CLUSTER_NAME = var.eks_cluster_name
    PROFILE      = var.eks_profile
    REGION       = var.eks_region
  }
}

data "template_file" "shell-kafka-schema-registry-script" {
  template = file("${path.module}/scripts/kafka/install_kafka_schema_registry.sh")
  vars = {
    INSTALL_SCHEMA_REGISTRY      = var.eks_install_schema_registry ? 1 : 0
    kAFKA_NAMESPACE              = var.eks_kafka_namespace
    KAFKA_SCHEMA_REGISTRY_VALUES = base64encode(templatefile("${path.module}/values/kafka/cp-schema-registry-values.tmpl", { HEAP_OPTIONS = var.eks_schema_registry_heap_options, BOOTSTRAP_SERVERS = join(",", formatlist("${upper(var.eks_schema_registry_broker_client_encryption)}://%s", split(",", var.eks_schema_registry_bootstrap_servers))), NODE_SELECTOR = var.eks_schema_registry_node_selector }))
    KAFKA_CHART_PATH             = local.kafka_chart_path
  }
}

data "template_file" "shell-kafka-connect-script" {
  template = file("${path.module}/scripts/kafka/install_kafka_connect.sh")
  vars = {
    INSTALL_KAFKA_CONNECT = var.eks_install_kafka_connect ? 1 : 0
    kAFKA_NAMESPACE       = var.eks_kafka_namespace
    KAFKA_CONNECT_VALUES  = base64encode(templatefile("${path.module}/values/kafka/cp-kafka-connect-values.tmpl", { HEAP_OPTIONS = var.eks_kafka_connect_heap_options, BOOTSTRAP_SERVERS = join(",", formatlist("${upper(var.eks_kafka_connect_broker_client_encryption)}://%s", split(",", var.eks_kafka_connect_bootstrap_servers))), NODE_SELECTOR = var.eks_kafka_connect_node_selector }))
    KAFKA_CHART_PATH      = local.kafka_chart_path
  }
}

data "template_file" "shell-ksql-server-script" {
  template = file("${path.module}/scripts/kafka/install_ksql_server.sh")
  vars = {
    INSTALL_KSQL_SERVER = var.eks_install_ksql_server ? 1 : 0
    kAFKA_NAMESPACE     = var.eks_kafka_namespace
    KSQL_SERVER_VALUES  = base64encode(templatefile("${path.module}/values/kafka/cp-ksql-server-values.tmpl", { HEAP_OPTIONS = var.eks_ksql_server_heap_options, BOOTSTRAP_SERVERS = join(",", formatlist("${upper(var.eks_ksql_server_broker_client_encryption)}://%s", split(",", var.eks_ksql_server_bootstrap_servers))), NODE_SELECTOR = var.eks_ksql_server_node_selector, HEADLESS = var.eks_ksql_server_headless, LOGGING_PROCESSING_STREAM = var.eks_ksql_server_logging_processing_stream, LOGGING_PROCESSING_TOPIC = var.eks_ksql_server_logging_processing_topic }))
    KAFKA_CHART_PATH    = local.kafka_chart_path
  }
}

data "template_file" "shell-fluentd-script" {
  template = file("${path.module}/scripts/fluent/install_fluentd.sh")
  vars = {
    INSTALL_FLUENTD    = var.eks_install_fluentd ? 1 : 0
    FLUENTD_NAMESPACE  = var.eks_fluentd_namespace
    FLUENTD_VALUES     = base64encode(templatefile("${path.module}/values/fluent/fluentd-values.tmpl", { BOOTSTRAP_SERVERS = join(",", formatlist("${upper(var.eks_fluentd_broker_client_encryption)}://%s", split(",", var.eks_fluentd_bootstrap_servers))), NODE_SELECTOR = var.eks_fluentd_node_selector, DEFAULT_TOPIC = var.eks_fluentd_default_topic }))
    FLUENTD_CHART_PATH = local.fluent_chart_path
  }
}

resource "local_file" "shell-eks-script" {
  content = join("\n", [
    data.template_file.shell-setup-script.rendered,
    data.template_file.shell-kafka-schema-registry-script.rendered,
    data.template_file.shell-kafka-connect-script.rendered,
    data.template_file.shell-ksql-server-script.rendered,
    data.template_file.shell-fluentd-script.rendered
  ])

  filename        = "${var.destination_file_path}/${var.destination_filename}.sh"
  file_permission = var.destination_file_permission
}
