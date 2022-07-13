
############################################################################################
#   MSK CloudWatch Log Group
############################################################################################
resource "aws_cloudwatch_log_group" "logs" {
  name              = "Msk${title(var.msk_name)}BrokerLogs"
  retention_in_days = var.cloudwatch_retention_in_days

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
