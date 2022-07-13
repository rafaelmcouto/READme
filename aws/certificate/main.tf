resource "aws_acm_certificate" "default" {
  domain_name               = var.domain_name
  validation_method         = var.validation_method
  subject_alternative_names = var.subject_alternative_names

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    { "Name" = var.certificate_name },
    var.tags,
    var.tags_shared
  )
}
