variable "name" {
    type = string
    default = "mano_paulo_v2"
}

variable "description" {
    type = string
    default = "Password from RDS"
}

variable "tags_shared" {
  type = map(string)
}
