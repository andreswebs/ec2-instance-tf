data "aws_subnet" "this" {
  id = var.subnet_id
}

module "ec2_base" {
  source  = "andreswebs/ec2-base/aws"
  version = "0.6.0"
  name    = var.name
  vpc_id  = data.aws_subnet.this.vpc_id

  cidr_whitelist_ipv4 = var.cidr_whitelist_ipv4

  extra_whitelisted_ingress_rules_ipv4 = [
    {
      ip_protocol = "icmp"
      from_port   = "8"
      to_port     = "0"
    }
  ]
}

module "ec2_instance" {
  source                 = "andreswebs/ec2-instance-linux/aws"
  version                = "0.10.0"
  name                   = var.name
  instance_type          = var.instance_type
  ami_id                 = var.ami_id
  subnet_id              = data.aws_subnet.this.id
  iam_profile_name       = module.ec2_base.instance_profile.name
  vpc_security_group_ids = [module.ec2_base.security_group.id]

  app_username = var.name

}
