locals {
  tags_deployments_before = var.saved_deployments_path != null ? fileexists(var.saved_deployments_path) ? jsondecode(file(var.saved_deployments_path)): [] : []
}
locals {
  tags_deployments_current = toset(contains(local.tags_deployments_before, sha1(aws_api_gateway_rest_api.default.body)) ? local.tags_deployments_before : concat(local.tags_deployments_before, [sha1(aws_api_gateway_rest_api.default.body)]))
}

resource "local_file" "save-deployments" {
  count    = var.saved_deployments_path != null ? 1 : 0
  content = jsonencode(keys(aws_api_gateway_deployment.default))
  filename        = var.saved_deployments_path
  file_permission = "0666"
}