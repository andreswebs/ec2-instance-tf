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

variable "cidr_whitelist_ipv4" {
  type    = list(string)
  default = []
}