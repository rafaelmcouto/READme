############################################################################################
#   MSK Security Group Client/MSK
############################################################################################
resource "aws_security_group" "client" {
  name        = "MSK${title(var.msk_name)}Client"
  description = "Allow Connection with MSK ${title(var.msk_name)}"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.msk_allowed_output_ips
  }

  tags = merge(
    var.tags,
    var.tags_shared,
    tomap({
      "Name" = "MSK${title(var.msk_name)}Client"
    })
  )
}

resource "aws_security_group" "msk" {
  name        = "MSK${title(var.msk_name)}"
  description = "SG For MSK ${title(var.msk_name)}"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 2181
    to_port   = 2182
    protocol  = "tcp"
    security_groups = concat(
      var.msk_allowed_security_group_ids, tolist([aws_security_group.client.id])
    )
  }

  ingress {
    from_port = 9092
    to_port   = 9094
    protocol  = "tcp"
    security_groups = concat(
      var.msk_allowed_security_group_ids, tolist([aws_security_group.client.id])
    )
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.msk_allowed_output_ips
  }

  tags = merge(
    var.tags,
    var.tags_shared,
    tomap({
      "Name" = "MSK${title(var.msk_name)}"
    })
  )
}
