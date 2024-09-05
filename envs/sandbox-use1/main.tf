module "ec2_standalone" {
  source    = "../../modules/instance-standalone"
  name      = var.name
  subnet_id = var.subnet_id
}

# resource "aws_iam_role_policy_attachment" "efs" {
#   role       = module.ec2_standalone.instance_role.arn
#   policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemsUtils"
# }
