resource "aws_kms_alias" "default" {
  name          = format("alias/%s", var.key_alias)
  target_key_id = aws_kms_key.default.key_id
}
