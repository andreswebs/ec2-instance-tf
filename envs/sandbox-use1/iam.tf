
# resource "aws_iam_role_policy_attachment" "efs" {
#   role       = module.ec2_standalone.instance.instance_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemsUtils"
# }
