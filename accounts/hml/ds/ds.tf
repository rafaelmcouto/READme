module "activedirectory" {
  source = "../../../modules/ds"

  name        = "example.int"
  environment = "test"
  layer       = "layer Name"
  project     = "AD Migration"
  service     = "Directory Service"

}
