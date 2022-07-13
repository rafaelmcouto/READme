resource "aws_glue_catalog_database" "default" {
  for_each    = var.databases
  name        = each.value.name
  description = each.value.description
}
