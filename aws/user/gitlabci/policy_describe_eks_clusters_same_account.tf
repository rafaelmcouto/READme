resource "aws_iam_policy" "describe_eks_clusters_same_account" {
  count       = var.enable_eks ? 1 : 0
  name        = "__${var.username}_describe_eks_clusters_same_account"
  path        = "/"
  description = "Allow use of aws eks update-kubeconfig command"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:eks:*:${data.aws_caller_identity.current.account_id}:cluster/*"
        ]
      },
    ]
  })

  tags = merge(
    var.tags,
    var.tags_shared
  )
}