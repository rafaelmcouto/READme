data "template_file" "shell-script-setup" {
  template = file("${path.module}/values/setup.sh")
  vars = {
    PATH = var.source_file_path
  }
}

resource "local_file" "setup" {
  content         = data.template_file.shell-script-setup.rendered
  filename        = "${var.destination_file_path}/${var.destination_filename}.sh"
  file_permission = var.destination_file_permission
}
