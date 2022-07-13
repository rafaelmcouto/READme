resource "aws_iam_policy" "deploy_lambda_iam" {
  count       = var.enable_lambda && length(local.lambda_roles_arns_merged) > 0 ? 1 : 0
  name        = "__${var.username}_deploy_lambda_iam"
  path        = "/"
  description = "IAM policy to deploy lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "iam:PassRole"
        Effect   = "Allow"
        Resource = local.lambda_roles_arns_merged
      }
    ]
  })

  tags = merge(
    var.tags,
    var.tags_shared
  )
}