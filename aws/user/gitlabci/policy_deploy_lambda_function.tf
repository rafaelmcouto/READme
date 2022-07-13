resource "aws_iam_policy" "deploy_lambda_function" {
  count       = var.enable_lambda ? 1 : 0
  name        = "__${var.username}_deploy_lambda_function"
  path        = "/"
  description = "Lambda Function policy with Cloud Formation, S3 Bucket, Logs Cloudwatch and EC2 to deploy lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Lambda Function
      {
        Action = [
          "lambda:CreateFunction",
          "lambda:GetFunction",
          "lambda:DeleteFunction",
          "lambda:ListVersionsByFunction",
          "lambda:PublishVersion",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "lambda:RemovePermission",
          "lambda:AddPermission",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:lambda:*:${data.aws_caller_identity.current.account_id}:function:*"
      },
      {
        Action   = [
          "lambda:CreateEventSourceMapping",
          "lambda:GetEventSourceMapping",
          "lambda:DeleteEventSourceMapping",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      # Cloud Formation
      {
        Action = [
            "cloudformation:DescribeStacks",
            "cloudformation:CreateStack",
            "cloudformation:DescribeStackEvents",
            "cloudformation:DescribeStackResource",
            "cloudformation:UpdateStack",
            "cloudformation:ListStackResources"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:cloudformation:*:${data.aws_caller_identity.current.account_id}:stack/*/*"
      },
      {
        Action   = "cloudformation:ValidateTemplate"
        Effect   = "Allow"
        Resource = "*"
      },
      # S3 Bucket
      {
        Action = [
          "s3:PutEncryptionConfiguration",
          "s3:PutObject",
          "s3:PutBucketPolicy",
          "s3:CreateBucket",
          "s3:ListBucket",
          "s3:DeleteBucketPolicy",
          "s3:DeleteBucket",
          "s3:GetBucketPolicy",
          "s3:PutObject",
          "s3:GetObject"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::*"
      },
      # Logs Cloudwatch
      {
        Action = [
            "logs:CreateLogGroup",
            "logs:DeleteLogGroup",
            "logs:PutRetentionPolicy"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/*"
      },
      # EC2
      {
        Action = [
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs"
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