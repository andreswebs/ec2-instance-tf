output "id" {
  value = module.ec2_standalone.instance.id
}

output "public_ip" {
  value = module.ec2_standalone.instance.public_ip
}

output "private_ip" {
  value = module.ec2_standalone.instance.private_ip
}

output "security_group_id" {
  value = module.ec2_standalone.instance.security_group.id
}

output "role_arn" {
  value = module.ec2_standalone.instance.instance_role.arn
}
