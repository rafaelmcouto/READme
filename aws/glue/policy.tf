data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "default" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}
