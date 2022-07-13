resource "aws_glue_crawler" "default" {
  for_each      = var.add_crawler ? var.crawlers : {}
  database_name = each.value.name
  description   = each.value.description
  #name          = replace(title(replace(each.value.name, "/[-_]/", " ")), " ", "")
  name          = each.value.name
  role          = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.prefix_role}-${each.value.role}"

  s3_target {
    path = format("s3://%s", each.value.bucket)
  }

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
