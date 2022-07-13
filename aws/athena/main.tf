resource "aws_athena_workgroup" "default" {
  name          = var.name
  description   = var.description
  state         = var.state
  force_destroy = var.force_destroy

  configuration {
    enforce_workgroup_configuration    = var.enforce_configuration
    publish_cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled

    dynamic "result_configuration" {
      for_each = var.result_configuration
      content {
        output_location = format("s3://%s/", result_configuration.value["output_location"])
        encryption_configuration {
          encryption_option = result_configuration.value.encryption_configuration.encryption_option
          kms_key_arn       = result_configuration.value.encryption_configuration.kms_key_arn
        }
      }
    }
  }

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
