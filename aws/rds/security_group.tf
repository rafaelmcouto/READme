resource "aws_security_group" "allow_connect" {
  name        = "RDS${title(var.identifier)}AllowConnectDatabase"
  description = "Allow connect on DataBase"
  vpc_id      = var.vpc_id

  ingress {
    description = "Ingress - Allow connect on DataBase"
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/32"]
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
}
