variable "name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "g6e.xlarge"
}

variable "ami_id" {
  type    = string
  default = null
}
