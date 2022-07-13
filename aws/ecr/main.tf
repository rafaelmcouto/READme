resource "aws_ecr_repository" "default" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags_shared
}

resource "aws_ecr_repository_policy" "default" {
  count      = var.create_policy ? 1 : 0
  repository = aws_ecr_repository.default.name
  policy     = var.policy == null ? "" : var.policy
}
