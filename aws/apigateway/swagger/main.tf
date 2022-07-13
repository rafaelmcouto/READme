resource "aws_api_gateway_rest_api" "default" {
  name        = var.name
  description = var.description
  body = var.swagger_path != null ? (
    base64decode(var.swagger_path)) : (
    templatefile("${path.module}/values/swagger.yaml", {})
  )

  endpoint_configuration {
    types = [var.endpoint_type]
  }

  parameters = {
    ignore         = "documentation"
    failonwarnings = false
  }

  tags = merge(
    var.tags,
    var.tags_shared
  )
}

resource "aws_api_gateway_deployment" "default" {
  for_each      = local.tags_deployments_current
  rest_api_id = aws_api_gateway_rest_api.default.id
  depends_on  = [aws_api_gateway_rest_api.default]
  description = "deployment ${each.value}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "default" {
  for_each      = var.stages
  deployment_id = aws_api_gateway_deployment.default[sha1(aws_api_gateway_rest_api.default.body)].id
  rest_api_id   = aws_api_gateway_rest_api.default.id
  stage_name    = each.value.name
  variables     = each.value.variables

  depends_on = [aws_api_gateway_deployment.default]

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
