locals {
  name = replace(title(replace(var.name, "/[^a-zA-Z0-9]/", "-")), "-", "")
}
resource "aws_instance" "default" {
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = aws_key_pair.public.key_name
  subnet_id            = var.subnet_id
  iam_instance_profile = aws_iam_instance_profile.default.name

  vpc_security_group_ids = compact(concat(
    [aws_security_group.default.id],
    (length(var.allowed_security_group_id) > 0 ? var.allowed_security_group_id : [])
  ))

  root_block_device {
    delete_on_termination = var.delete_on_termination
    encrypted             = var.encrypted
    volume_type           = var.volume_type
    volume_size           = var.volume_size

    tags = merge(
      var.tags,
      var.tags_shared,
      tomap({
        "Name" = "EBS${local.name}"
      })
    )
  }

  tags = merge(
    var.tags,
    var.tags_shared,
    tomap({
      "Name" = title(var.name)
    })
  )

  depends_on = [aws_security_group.default]
}

resource "aws_eip" "default" {
  count    = var.is_enabled_public_ip ? 1 : 0
  vpc      = true
  instance = aws_instance.default.id

  tags = merge(
    var.tags,
    var.tags_shared,
    tomap({
      "Name" = "EIP${local.name}"
    })
  )
}
