resource "aws_cloudwatch_metric_alarm" "default" {
  count                     = var.cloudwatch_is_enabled_create_alarm ? 1 : 0
  alarm_name                = "HighCpuUtilizationAlarm${local.name}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  threshold                 = var.cloudwatch_threshold
  alarm_description         = "CpuUtilization Threshold Exceeded ${var.cloudwatch_threshold}%"
  insufficient_data_actions = []
  alarm_actions             = var.cloudwatch_alarm_actions_sns_arn

  metric_query {
    id          = "metric${lower(local.name)}"
    return_data = true

    metric {
      metric_name = "CPUUtilization${local.name}"
      namespace   = "AWS/EC2"
      period      = "300"
      stat        = "Maximum"
      unit        = "Percent"

      dimensions = {
        InstanceId = aws_instance.default.id
      }
    }
  }

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
