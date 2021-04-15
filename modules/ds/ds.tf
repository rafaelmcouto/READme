resource "aws_directory_service_directory" "bar" {
  name     = var.name
  password = "7piU[FU-hOSf5{R"
  edition  = "Standard"
  type     = "MicrosoftAD"

  vpc_settings {
    vpc_id     = "vpc-0232f2bb5e6ccb6f2"
    subnet_ids = ["subnet-0d3ab156f67487af0", "subnet-0be4e3b2914f3a947"]
  }

  tags = local.common_tags
}
