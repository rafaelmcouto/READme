resource "aws_directory_service_directory" "bar" {
  name     = var.name
  password = "PASSWORD"
  edition  = "Standard"
  type     = "MicrosoftAD"

  vpc_settings {
    vpc_id     = "vpc-ID"
    subnet_ids = ["subnet-ID", "subnet-ID"]
  }

  tags = local.common_tags
}
