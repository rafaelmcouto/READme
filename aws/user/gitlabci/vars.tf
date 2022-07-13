variable "ecr_repositories" {
  type = list(object({
    region     = string
    account_id = string
  }))
  default = [
    {
      region     = "us-east-1"
      account_id = "345403943107"
    }
  ]
}

variable "tags" {
  type = map(string)
  default = {
    "Service" = "IAM"
  }
}

variable "tags_shared" {
  type = map(string)
  default = {
    "Owner"       = "Engineer"
    "Environment" = "Dev"
  }
}

variable "username" {
  default = "gitlabci"
}

variable "enable_eks" {
  type = bool
  default = true
}

variable "enable_lambda" {
  type = bool
  default = true
}

variable "enable_lambda_sqs" {
  type = bool
  default = true
}

variable "enable_lambda_sns" {
  type = bool
  default = true
}

variable "enable_lambda_event_bridge" {
  type = bool
  default = true
}

variable "enable_lambda_apigateway" {
  type = bool
  default = true
}

variable "allow_lambda_role_lambda_full" {
  type = bool
  default = false
}

variable "lambda_roles_arns" {
  type = list(string)
  default = []
}