module "ec2_base" {
  # source = "github.com/andreswebs/terraform-aws-ec2-base"
  source         = "andreswebs/ec2-base/aws"
  version        = "0.0.1"
  vpc_id         = var.vpc_id
  cidr_whitelist = var.cidr_whitelist
  name           = var.name

  extra_ingress_rules = [
    {
      ip_protocol = "udp"
      from_port   = "41641"
      to_port     = "41641"
    }
  ]

}

module "ec2_instance" {
  # source = "github.com/andreswebs/terraform-aws-ec2-instance-linux"
  source                 = "andreswebs/ec2-instance-linux/aws"
  version                = "0.2.0"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.ec2_base.security_group.id]
  ssh_key_name           = module.ec2_base.key_pair.key_name
  iam_profile_name       = module.ec2_base.instance_profile.name
  name                   = var.name
  instance_type          = var.instance_type
}
