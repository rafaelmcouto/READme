output "parameter_name" {
  description = "SSM`s parameter name"
  value = element(compact(concat(aws_ssm_parameter.parameter.*.name, tolist([var.undefined_value]))), 0)
}

output "parameter_arn" {
  description = "SSM`s parameter arn"
  value = element(compact(concat(aws_ssm_parameter.parameter.*.arn, tolist([var.undefined_value]))), 0)
}