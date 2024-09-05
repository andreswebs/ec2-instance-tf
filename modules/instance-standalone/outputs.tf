output "instance" {
  value = merge(module.ec2_instance, module.ec2_base)
}
