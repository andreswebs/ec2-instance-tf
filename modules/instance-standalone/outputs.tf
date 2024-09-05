# output "instance" {
#   value = module.ec2_instance.public_ip
# }

# output "id" {
#   value = module.ec2_instance.id
# }

output "instance" {
  value = merge(module.ec2_instance, module.ec2_base)
}
