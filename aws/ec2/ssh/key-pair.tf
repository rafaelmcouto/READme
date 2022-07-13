resource "aws_key_pair" "public" {
  key_name   = var.ssh_key_name
  public_key = file("${path.module}/${var.ssh_public_key_path}")

  tags = merge(
    var.tags,
    var.tags_shared
  )
}
