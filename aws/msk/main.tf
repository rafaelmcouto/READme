
############################################################################################
#   MSK Configuration
#   * Create a custom MSK configuration where you set the following properties
#   * https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html
############################################################################################
resource "aws_msk_configuration" "server-properties" {
  kafka_versions = tolist(var.msk_version)
  name           = var.msk_name
  server_properties = var.msk_server_properties_file_path == null ? (
    templatefile("${path.module}/values/kafka.properties", {})) : (
    var.msk_server_properties_file_path
  )
}

############################################################################################
#   MSK Cluster
############################################################################################
resource "aws_msk_cluster" "msk" {
  cluster_name           = var.msk_name
  kafka_version          = element(var.msk_version, 0)
  number_of_broker_nodes = var.msk_number_of_brokers
  enhanced_monitoring    = var.msk_enhanced_monitoring

  configuration_info {
    arn      = aws_msk_configuration.server-properties.arn
    revision = aws_msk_configuration.server-properties.latest_revision
  }

  broker_node_group_info {
    instance_type   = var.msk_broker_instance_size
    ebs_volume_size = var.msk_broker_ebs_size
    client_subnets  = slice(var.private_subnets_ids, 0, 3)
    security_groups = [aws_security_group.msk.id]
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = var.msk_prometheus_jmx_exporter
      }
      node_exporter {
        enabled_in_broker = var.msk_prometheus_node_exporter
      }
    }
  }

  encryption_info {
    encryption_in_transit {
      client_broker = var.msk_broker_client_encryption_in_transit
      in_cluster    = var.msk_broker_in_cluster_encryption_in_transit
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.logs.name
      }

      s3 {
        enabled = true
        bucket  = aws_s3_bucket.logs.id
        prefix  = "logs/msk-"
      }
    }
  }

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
