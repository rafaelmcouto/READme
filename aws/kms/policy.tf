data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "administrators-permissions" {
  statement {
    sid = "Enable IAM Administrators Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = ["kms:*"]
    resources = ["*"]
  }
}