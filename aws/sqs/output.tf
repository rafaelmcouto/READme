output "arn" {
  description = "ARN for the created Amazon SQS queue"
  value       = aws_sqs_queue.sqs_queue.arn
}


output "url" {
  description = "URL for the created Amazon SQS queue"
  value       = aws_sqs_queue.sqs_queue.id
}

output "error_arn" {
  description = "ARN for the created Amazon SQS error queue"
  value       = element(compact(concat(aws_sqs_queue.sqs_queue_error.*.arn, tolist([var.undefined_value]))), 0)
}


output "error_url" {
  description = "URL for the created Amazon SQS error queue"
  value       = element(compact(concat(aws_sqs_queue.sqs_queue_error.*.id, tolist([var.undefined_value]))), 0)
}


output "id" {
  description = "ID for the created Amazon SQS queue"
  value       = aws_sqs_queue.sqs_queue.id
}
