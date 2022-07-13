resource "aws_lb" "default" {
  name                             = var.name
  name_prefix                      = var.name_prefix
  internal                         = var.internal
  load_balancer_type               = var.load_balancer_type
  subnets                          = var.subnets_ids
  idle_timeout                     = var.idle_timeout
  enable_deletion_protection       = var.enable_deletion_protection
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing

  dynamic "access_logs" {
    for_each = var.access_logs
    content {
      bucket  = access_logs.value["bucket"]
      prefix  = access_logs.value["prefix"]
      enabled = access_logs.value["enabled"]
    }
  }

  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping
    content {
      subnet_id            = subnet_mapping.value["subnet_id"]
      allocation_id        = subnet_mapping.value["allocation_id"]
      private_ipv4_address = subnet_mapping.value["private_ipv4_address"]
    }
  }

  tags = merge(
    var.tags,
    var.tags_shared
  )
}

resource "aws_lb_listener" "default" {
  for_each          = var.listeners
  load_balancer_arn = aws_lb.default.arn
  port              = each.value.port
  protocol          = each.value.protocol
  ssl_policy        = each.value.ssl_policy
  certificate_arn   = each.value.certificate_arn

  default_action {
    type             = each.value.default_action.type
    target_group_arn = each.value.default_action.target_group_arn
  }
}
