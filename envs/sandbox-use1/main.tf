module "instance" {
  source    = "../../modules/instance-standalone"
  name      = var.name
  subnet_id = var.subnet_id
}
