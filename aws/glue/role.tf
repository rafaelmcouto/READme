resource "aws_iam_role" "default" {
  for_each              = var.add_crawler ? var.role_crawlers : {}
  name                  = "${var.prefix_role}-${each.value.name}"
  description           = each.value.description
  assume_role_policy    = data.aws_iam_policy_document.default.json
  force_detach_policies = var.force_detach_policies
  managed_policy_arns   = var.managed_policy_arns

  inline_policy {
    name = "${var.prefix_role}${each.value.name}"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          "Action" : [
            "s3:GetObject",
            "s3:PutObject"
          ],
          Resource = [
            "arn:aws:s3:::${each.value.bucket}*"
          ]
        },
      ]
    })
  }

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
