resource "aws_iam_role" "default" {
  name                  = var.name
  description           = var.description
  assume_role_policy    = data.aws_iam_policy_document.default.json
  force_detach_policies = var.force_detach_policies

  tags = merge(
    var.tags,
    var.tags_shared
  )
}

resource "aws_iam_role_policy" "default" {
  name   = var.name
  role   = aws_iam_role.default.id
  policy = var.policy
}
