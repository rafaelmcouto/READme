resource "aws_iam_policy" "deploy_lambda_event_bridge" {
  count       = var.enable_lambda && var.enable_lambda_event_bridge ? 1 : 0
  name        = "__${var.username}_deploy_lambda_event_bridge"
  path        = "/"
  description = "Event Bridge policy to deploy lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "events:DescribeRule",
          "events:PutRule",
          "events:DeleteRule",
          "events:RemoveTargets",
          "events:PutTargets",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:events:*:${data.aws_caller_identity.current.account_id}:rule/*"
      }
    ]
  })

  tags = merge(
    var.tags,
    var.tags_shared
  )
}