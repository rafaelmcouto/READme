resource "aws_ssm_parameter" "parameter" {
  count       = var.create ? 1 : 0
  name        = "${var.prefix}${var.key}${var.sufix}"
  description = var.description
  type        = var.type
  value       = var.value
  overwrite   = var.overwrite
  tags        = var.tags_shared
}
