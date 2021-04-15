variable "name" {
  type        = string
  description = "Bucket Name"
}

variable "environment" {
  type        = string
  description = "Environment Name"
}

variable "layer" {
  type        = string
  description = "Layer Name"
}

variable "project" {
  type        = string
  description = "The Project Name"
}

variable "service" {
  type        = string
  default     = "s3"
  description = "description"
}
