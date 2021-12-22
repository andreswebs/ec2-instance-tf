module "ubuntu_20_04_latest" {
  source  = "andreswebs/ami-ubuntu/aws"
  version = "1.1.0"
}

module "amzn2_latest" {
  source  = "andreswebs/ami-amzn2/aws"
  version = "1.0.0"
}

locals {
  ssh_key_name   = var.ssh_key_name != "" ? var.ssh_key_name : "${var.name}-ssh"
  default_ami_id = var.linux_distribution != "ubuntu" ? module.amzn2_latest.ami_id : module.ubuntu_20_04_latest.ami_id
  ami_id         = var.ami_id != "" ? var.ami_id : local.default_ami_id
}

resource "aws_security_group" "this" {
  vpc_id = var.vpc_id

  revoke_rules_on_delete = true

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_whitelist
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

module "ec2_keypair" {
  source             = "andreswebs/insecure-ec2-key-pair/aws"
  version            = "1.0.0"
  key_name           = local.ssh_key_name
  ssm_parameter_name = "/${var.name}/ssh-key"
}

module "ec2_role" {
  source       = "andreswebs/ec2-role/aws"
  version      = "1.0.0"
  role_name    = var.name
  profile_name = var.name
  policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
  ]
}

module "s3_requisites_for_ssm" {
  source  = "andreswebs/s3-requisites-for-ssm-policy-document/aws"
  version = "1.0.0"
}

resource "aws_iam_role_policy" "s3_requisites_for_ssm" {
  name   = "s3-requisites-for-ssm"
  role   = module.ec2_role.role.name
  policy = module.s3_requisites_for_ssm.json
}

resource "aws_instance" "this" {
  ami                     = local.ami_id
  disable_api_termination = var.instance_termination_disable
  key_name                = local.ssh_key_name
  vpc_security_group_ids  = [aws_security_group.this.id]
  subnet_id               = var.subnet_id
  iam_instance_profile    = module.ec2_role.instance_profile.name
  instance_type           = var.instance_type

  root_block_device {
    delete_on_termination = var.volume_delete
    encrypted             = var.volume_encrypted
    volume_size           = var.volume_size
  }

  enclave_options {
    enabled = var.enclave_enabled
  }

  tags = {
    Name = var.name
  }

  lifecycle {
    ignore_changes = [ ami, tags ]
  }

}
