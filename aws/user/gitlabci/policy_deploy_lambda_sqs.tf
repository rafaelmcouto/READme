resource "aws_iam_policy" "deploy_lambda_sqs" {
  count       = var.enable_lambda && var.enable_lambda_sqs ? 1 : 0
  name        = "__${var.username}_deploy_lambda_sqs"
  path        = "/"
  description = "SQS policy to deploy lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:TagQueue",
          "sqs:UntagQueue",
          "sqs:DeleteQueue",
          "sqs:CreateQueue",
          "sqs:GetQueueAttributes",
          "sqs:SetQueueAttributes",
          "sqs:AddPermission",
          "sqs:RemovePermission",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:sqs:*:${data.aws_caller_identity.current.account_id}:*"
      }
    ]
  })

  tags = merge(
    var.tags,
    var.tags_shared
  )
}