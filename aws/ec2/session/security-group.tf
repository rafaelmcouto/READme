resource "aws_security_group" "default" {
  name                   = "AllowTcp${local.name}"
  description            = "Allow TCP Inbound Traffic"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    var.tags_shared,
    tomap({
      "Name" = "SG${local.name}"
    })
  )
}
