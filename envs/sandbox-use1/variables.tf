variable "name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "m7a.large"
}

variable "ami_id" {
  type    = string
  default = null
}
