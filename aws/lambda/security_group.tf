resource "aws_security_group" "default" {
  name                   = ${split(".", var.function_name)[0]}
  description            = "Simple Security Group to Lambda"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  ingress {
    description = "SSH Access"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
  }

  dynamic "ingress" {
    for_each = var.ingress
    content {
      description     = ingress.value["description"]
      from_port       = ingress.value["from_port"]
      to_port         = ingress.value["to_port"]
      protocol        = ingress.value["protocol"]
      security_groups = ingress.value["security_groups"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {"Name" = "allow_connect"},
    var.tags,
    var.tags_shared
  )

  tags = {
    Name = split(".", var.function_name)[0]
  }

}