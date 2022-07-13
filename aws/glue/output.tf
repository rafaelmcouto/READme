output "databases_arns" {
  description = "The Amazon Resource Glue Databases"
  value = tomap({
    for k, v in aws_glue_catalog_database.default : k => v.arn
  })
}

output "databases_ids" {
  description = "The Amazon Resource Glue Databases"
  value = tomap({
    for k, v in aws_glue_catalog_database.default : k => v.id
  })
}

output "crawlers_arns" {
  description = "The Amazon Resource Glue Crawlers"
  value = tomap({
    for k, v in aws_glue_crawler.default : k => v.arn
  })
}

output "crawlers_ids" {
  description = "The Amazon Resource Glue Crawlers"
  value = tomap({
    for k, v in aws_glue_crawler.default : k => v.id
  })
}
