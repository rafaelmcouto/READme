resource "aws_iam_policy" "deploy_lambda_apigateway" {
  count       = var.enable_lambda && var.enable_lambda_apigateway ? 1 : 0
  name        = "__${var.username}_deploy_lambda_apigateway"
  path        = "/"
  description = "API Gateway policy to deploy lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # API Gateway
      {
        Action   = [
          "apigateway:DELETE",
          "apigateway:PUT",
          "apigateway:PATCH",
          "apigateway:POST",
          "apigateway:GET"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:apigateway:*::/restapis",
          "arn:aws:apigateway:*::/restapis/*",
          "arn:aws:apigateway:*::/domainnames",
          "arn:aws:apigateway:*::/domainnames/*",
          "arn:aws:apigateway:*::/account",
          "arn:aws:apigateway:*::/clientcertificates",
          "arn:aws:apigateway:*::/clientcertificates/*",
          "arn:aws:apigateway:*::/vpclinks/*",
          "arn:aws:apigateway:*::/apikeys",
          "arn:aws:apigateway:*::/apikeys/*",
          "arn:aws:apigateway:*::/usageplans",
          "arn:aws:apigateway:*::/usageplans/*",
          "arn:aws:apigateway:*::/tags",
          "arn:aws:apigateway:*::/tags/*",
        ]
      },
      {
        Action   = [
          "apigateway:SetWebACL",
          "apigateway:UpdateRestApiPolicy",
          "apigateway:AddCertificateToDomain",
          "apigateway:RemoveCertificateFromDomain"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:apigateway:*::/domainnames",
          "arn:aws:apigateway:*::/domainnames/*",
          "arn:aws:apigateway:*::/restapis",
          "arn:aws:apigateway:*::/restapis/*",
        ]
      },
      # API Gateway V2
      {
        Action   = [
          "apigateway:DELETE",
          "apigateway:PUT",
          "apigateway:PATCH",
          "apigateway:POST",
          "apigateway:GET",
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:apigateway:*::/apis",
          "arn:aws:apigateway:*::/apis/*",
          "arn:aws:apigateway:*::/domainnames/*",
          "arn:aws:apigateway:*::/tags",
          "arn:aws:apigateway:*::/tags/*",
        ]
      },
    ]
  })

  tags = merge(
    var.tags,
    var.tags_shared
  )
}