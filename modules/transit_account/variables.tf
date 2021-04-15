variable account {
  type        = string
  description = "Name of Account"
}

variable createdBy {
  type        = string
  description = "Who have created this resource: Jenkins / Username"
}

variable environment {
  type        = string
  description = "Environment of this resource: DEV / HML / PRD"
}

variable iac {
  type        = string
  description = "Created by Iac: Terraform / CloudFormation / False"
}

variable name {
  type        = string
  description = "Name of this resource"
}

variable product {
  type        = string
  description = "The name of Product"
}

variable project {
  type        = string
  description = "What Project of Product"
}

variable service {
  type        = string
  description = "The name of AWS resource was created"
}

Account                 Transit
createdBy               Jenkins / User
Environment             Production
IaC                     True / False
Name                    alb-eks-data
Project                 Sites
Product                 Chat
Service                 ALB
