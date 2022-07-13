############################################################################################
#   MSK Autocalling
#  * The scalable dimension associated with the scalable target. 
#  * This string consists of the service namespace, resource type, and scaling property.
#  * https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#API_RegisterScalableTarget_RequestParameters
############################################################################################
resource "aws_appautoscaling_target" "msk-storage-autoscalling" {
  count              = var.msk_storage_autoscalling_config != null ? 1 : 0
  service_namespace  = "kafka"
  scalable_dimension = "kafka:broker-storage:VolumeSize"
  resource_id        = aws_msk_cluster.msk.arn
  min_capacity       = 1
  max_capacity       = var.msk_storage_autoscalling_config.msk_broker_maximum_ebs_size
}

resource "aws_appautoscaling_policy" "msk-storage-autoscalling-policy" {
  count              = var.msk_storage_autoscalling_config != null ? 1 : 0
  name               = "msk-${var.msk_name}-storage-autoscalling-policy"
  service_namespace  = "kafka"
  scalable_dimension = "kafka:broker-storage:VolumeSize"
  resource_id        = aws_msk_cluster.msk.arn
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value = var.msk_storage_autoscalling_config.autoscalling_percentage_target
    predefined_metric_specification {
      predefined_metric_type = "KafkaBrokerStorageUtilization"
    }
  }
}
