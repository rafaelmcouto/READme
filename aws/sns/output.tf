output "arn" {
  description = "ARN for the created Amazon SNS"
  value       = aws_sns_topic.sns_topic.arn
}
