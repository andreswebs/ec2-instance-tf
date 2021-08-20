variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "name" {
  type = string
}

variable "volume_delete" {
  type    = bool
  default = true
}

variable "volume_encrypted" {
  type    = bool
  default = true
}

variable "volume_size" {
  type    = number
  default = 50
}

variable "instance_type" {
  type    = string
  default = "m5a.xlarge"
}

variable "instance_termination_disable" {
  type    = bool
  default = false
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ssh_key_name" {
  type    = string
  default = ""
}

variable "ami_id" {
  type    = string
  default = ""
}

variable "cidr_whitelist" {
  type = list(string)
}

variable "enclave_enabled" {
  type    = bool
  default = false
}

variable "linux_distribution" {
  type    = string
  default = "ubuntu"
  validation {
    condition     = can(regex("^amzn2|ubuntu$", var.linux_distribution))
    error_message = "Must be one of `amzn2`, `ubuntu`."
  }
}
