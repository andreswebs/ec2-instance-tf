locals {
  vpn_cidr = "10.0.0.0/8"
}

module "ec2_standalone" {
  source              = "../../modules/instance-standalone"
  name                = var.name
  instance_type       = var.instance_type
  ami_id              = var.ami_id
  subnet_id           = var.subnet_id
  cidr_whitelist_ipv4 = [local.vpn_cidr]
}
