locals {
  vpn_cidr = "10.0.0.0/8"
}

module "ec2_standalone" {
  source              = "../../modules/instance-standalone"
  name                = var.name
  subnet_id           = var.subnet_id
  cidr_whitelist_ipv4 = [local.vpn_cidr]
}

resource "aws_iam_role_policy_attachment" "efs" {
  role       = module.ec2_standalone.instance.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemsUtils"
}
