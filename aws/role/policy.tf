data "aws_iam_policy_document" "default" {
  statement {
    actions = var.actions
    principals {
      type        = var.principals_type
      identifiers = var.principals_identifiers
    }
  }
}
