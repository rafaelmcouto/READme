resource "aws_directory_service_directory" "ds" {
  name     = var.ds_name
  password = var.password
  edition  = var.edition
  type     = var.type
  description = var.description

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = [element(var.subnet_ids, 0), element(var.subnet_ids, 1)]
  }

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
