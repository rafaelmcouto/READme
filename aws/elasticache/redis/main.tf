resource "aws_elasticache_subnet_group" "default" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "default" {
  name        = "${title(var.replication_group_id)}_Allow_Connect_Redis"
  description = "Allow connect on Redis - ${title(var.replication_group_id)}"
  vpc_id      = var.vpc_id

  ingress {
    description = "Ingress - Allow connect on Redis - ${title(var.replication_group_id)}"
    from_port   = var.port
    to_port     = var.port
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
    { "Name" = "${title(var.replication_group_id)}_Allow_Connect_Redis" },
    var.tags,
    var.tags_shared
  )
}

resource "aws_elasticache_replication_group" "example" {
  lifecycle {
    create_before_destroy = true
  }

  replication_group_id          = var.replication_group_id
  replication_group_description = var.replication_group_description
  node_type                     = var.node_type
  number_cache_clusters         = var.number_cache_clusters
  parameter_group_name          = var.parameter_group_name
  port                          = var.port
  availability_zones            = var.availability_zones
  at_rest_encryption_enabled    = var.at_rest_encryption_enabled
  transit_encryption_enabled    = var.transit_encryption_enabled
  security_group_ids            = [aws_security_group.default.id]
  subnet_group_name             = aws_elasticache_subnet_group.default.name
  apply_immediately             = var.apply_immediately
  maintenance_window            = var.maintenance_window
  automatic_failover_enabled    = var.automatic_failover_enabled

  tags = merge(
    var.tags,
    var.tags_shared
  )

}
