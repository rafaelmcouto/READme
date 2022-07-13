resource "aws_iam_policy" "update_ecr_repository_system" {
  count       = var.enable_eks ? 1 : 0
  name        = "__${var.username}_update_ecr_repository_system"
  path        = "/"
  description = "Update ECR Repository System"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:ListImages",
          "ecr:InitiateLayerUpload",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage"
        ]
        Effect   = "Allow"
        Resource = [for repo in var.ecr_repositories : "arn:aws:ecr:${repo.region}:${repo.account_id}:repository/*"]
      },
      {
        Action   = "ecr:GetAuthorizationToken"
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