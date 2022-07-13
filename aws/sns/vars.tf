variable "sns_name" { type = string }
variable "delivery_policy" {
  default = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false
  }
}
EOF
}
variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}

variable "allowed_accounts" {
  type    = list(string)
  default = []
}
variable "sqs_arns_subscriptions" {
  type    = list(string)
  default = []
}

variable "endpoints_subscriptions" {
  type    = list(string)
  default = []
}

variable "sqs_subscription_raw_delivery" { default = false }
variable "endpoint_subscription_raw_delivery" { default = false }

variable "sns_policy" { default = null }
