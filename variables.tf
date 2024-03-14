variable "name" {
  type = string
}

variable "cidr_whitelist" {
  type = list(string)
}

variable "instance_type" {
  type    = string
  default = "m5a.xlarge"
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}
