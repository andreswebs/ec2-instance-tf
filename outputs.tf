output "id" {
  value = data.aws_instance.this.id
}

output "public_ip" {
  value = data.aws_instance.this.public_ip
}