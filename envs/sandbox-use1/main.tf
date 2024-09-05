module "ec2_standalone" {
  source    = "../../modules/instance-standalone"
  name      = var.name
  subnet_id = var.subnet_id
}

resource "aws_iam_role_policy_attachment" "efs" {
  role       = module.ec2_standalone.instance.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemsUtils"
}

resource "aws_ssm_association" "efs_utils" {
  name = "AmazonEFSUtils"

  targets {
    key    = "InstanceIds"
    values = [module.ec2_standalone.instance.id]
  }
}
