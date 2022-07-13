resource "aws_iam_policy" "deploy_lambda_sns" {
  count       = var.enable_lambda && var.enable_lambda_sns ? 1 : 0
  name        = "__${var.username}_deploy_lambda_sns"
  path        = "/"
  description = "SNS policy to deploy lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sns:TagResource",
          "sns:UntagResource",
          "sns:GetTopicAttributes",
          "sns:SetTopicAttributes",
          "sns:DeleteTopic",
          "sns:CreateTopic",
          "sns:AddPermission",
          "sns:RemovePermission",
          "sns:Subscribe",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:sns:*:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        Action = [
          "sns:Unsubscribe",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = merge(
    var.tags,
    var.tags_shared
  )
}