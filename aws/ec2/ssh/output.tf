output "arn" {
  description = "The ARN of the Instance"
  value       = aws_instance.default.arn
}

output "public_ip" {
  description = "The Public IP address of the Instance"
  value       = element(compact(concat(aws_eip.default.*.public_ip, tolist([var.undefined_value]))), 0)
}

output "ssh" {
  description = "SSH Command"
  value       = "ssh -i ${path.module}${var.ssh_private_key_path} ubuntu@${element(compact(concat(aws_eip.default.*.public_dns, tolist([var.undefined_value]))), 0)}"
}
