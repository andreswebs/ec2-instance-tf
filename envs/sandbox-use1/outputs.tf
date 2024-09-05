output "id" {
  value = module.ec2_standalone.instance.id
}

output "public_ip" {
  value = module.ec2_standalone.instance.public_ip
}
