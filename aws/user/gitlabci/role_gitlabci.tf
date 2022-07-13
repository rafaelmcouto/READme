resource "aws_iam_role" "gitlabci" {
  name                = "__${var.username}_role"
  assume_role_policy  = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect   = "Allow"
        Principal = {
          AWS = aws_iam_user.gitlabci.arn
        }
      }
    ]
  })

  tags = merge(
    var.tags,
    var.tags_shared
  )
}

resource "aws_iam_role_policy_attachment" "update_ecr_repository_system" {
  count      = var.enable_eks ? 1 : 0
  role       = aws_iam_role.gitlabci.name
  policy_arn = aws_iam_policy.update_ecr_repository_system[0].arn
}

resource "aws_iam_role_policy_attachment" "describe_eks_clusters_same_account" {
  count      = var.enable_eks ? 1 : 0
  role       = aws_iam_role.gitlabci.name
  policy_arn = aws_iam_policy.describe_eks_clusters_same_account[0].arn
}

resource "aws_iam_role_policy_attachment" "deploy_lambda_function" {
  count      = var.enable_lambda ? 1 : 0
  role       = aws_iam_role.gitlabci.name
  policy_arn = aws_iam_policy.deploy_lambda_function[0].arn
}

resource "aws_iam_role_policy_attachment" "deploy_lambda_iam" {
  count      = var.enable_lambda && length(local.lambda_roles_arns_merged) > 0 ? 1 : 0
  role       = aws_iam_role.gitlabci.name
  policy_arn = aws_iam_policy.deploy_lambda_iam[0].arn
}

resource "aws_iam_role_policy_attachment" "deploy_lambda_sqs" {
  count      = var.enable_lambda && var.enable_lambda_sqs ? 1 : 0
  role       = aws_iam_role.gitlabci.name
  policy_arn = aws_iam_policy.deploy_lambda_sqs[0].arn
}

resource "aws_iam_role_policy_attachment" "deploy_lambda_sns" {
  count      = var.enable_lambda && var.enable_lambda_sns ? 1 : 0
  role       = aws_iam_role.gitlabci.name
  policy_arn = aws_iam_policy.deploy_lambda_sns[0].arn
}

resource "aws_iam_role_policy_attachment" "deploy_lambda_apigateway" {
  count      = var.enable_lambda && var.enable_lambda_apigateway ? 1 : 0
  role       = aws_iam_role.gitlabci.name
  policy_arn = aws_iam_policy.deploy_lambda_apigateway[0].arn
}

resource "aws_iam_role_policy_attachment" "deploy_lambda_event_bridge" {
  count      = var.enable_lambda && var.enable_lambda_event_bridge ? 1 : 0
  role       = aws_iam_role.gitlabci.name
  policy_arn = aws_iam_policy.deploy_lambda_event_bridge[0].arn
}