resource "aws_db_instance" "default" {
  apply_immediately          = var.apply_immediately
  storage_encrypted          = var.storage_encrypted
  publicly_accessible        = var.publicly_accessible
  skip_final_snapshot        = var.skip_final_snapshot
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  delete_automated_backups   = var.delete_automated_backups
  backup_retention_period    = var.backup_retention_period
  allocated_storage          = var.allocated_storage
  max_allocated_storage      = var.max_allocated_storage
  identifier                 = var.identifier
  instance_class             = var.instance_class
  engine                     = var.engine
  engine_version             = var.engine_version
  name                       = var.name
  password                   = var.password
  username                   = var.username
  storage_type               = var.storage_type
  db_subnet_group_name       = aws_db_subnet_group.default.name
  maintenance_window         = var.maintenance_window

  vpc_security_group_ids = [aws_security_group.allow_connect.id]

  tags = merge(
    var.tags_shared,
    tomap({
      "Service" = "RDS"
    })
  )

}

resource "aws_db_subnet_group" "default" {
  name       = "${var.subnet_data_group}_${var.identifier}"
  subnet_ids = var.data_subnets_ids
  tags = merge(
    var.tags_shared,
    tomap({
      "Service" = "RDS"
    })
  )
}
