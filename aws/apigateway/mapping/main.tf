resource "aws_api_gateway_base_path_mapping" "default" {
  api_id      = var.api_id
  stage_name  = var.stage_name
  domain_name = var.domain_name
  base_path   = var.base_path
}
