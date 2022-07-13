locals {
  config_dockerfile = <<CONFIGDOCKERFILE
FROM ${var.dockerfile_image}

${join("\n", var.dockerfile_runners)}
CONFIGDOCKERFILE
}

data "template_file" "shell-script-dockerfile" {
  template = file("${path.module}/values/docker.sh")
  vars = {
    DOCKERFILE = local.config_dockerfile
  }
}

resource "local_file" "dockerfile" {
  content         = data.template_file.shell-script-dockerfile.rendered
  filename        = "${var.destination_file_path}/${var.dockerfile_destination_filename}"
  file_permission = var.destination_file_permission
}

data "template_file" "shell-script-build" {
  template = file("${path.module}/values/build.sh")
  vars = {
    REGION   = var.registry_region
    REGISTRY = var.registry_url
    IMAGE    = var.registry_image_name
    TAG      = var.registry_image_tag
  }
}

resource "local_file" "build" {
  content         = data.template_file.shell-script-build.rendered
  filename        = "${var.destination_file_path}/${var.registry_destination_filename}.sh"
  file_permission = var.destination_file_permission
}
