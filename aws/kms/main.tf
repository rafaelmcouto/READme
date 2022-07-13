resource "aws_kms_key" "default" {
  description              = var.description
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  policy                   = var.policy == null ? data.aws_iam_policy_document.administrators-permissions.json : var.policy
  deletion_window_in_days  = var.deletion_window_in_days
  is_enabled               = var.is_enabled
  enable_key_rotation      = var.enable_key_rotation
  tags                     = var.tags_shared
}
