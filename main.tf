terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "clusterk8s-backend"
    encrypt = "true"
    key     = "terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "mykey" {
  key_name   = "mfa@debian"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHmITOQ5ER5wJowTBEAMrglV1tG0MUxWJeV0HHsw7qXNx3q8ZGgRXGyN2nrZ8MbQCTFMXLEGG+q/BrkJiVEDsK/S8/cMxSVmtKoukzzMzg6Q9ujZSAPcGjP2+K9ac2WbytPBSS2AOTJ48RJPW2s/uVFEpFhWhWpsZA9FaBXADaX5hoFkfdlA4OX6gqXMAEF5OlAA8bVJRIpV47qfZMHcFINDSrDlTa2Y7iL+crXcZCYjcpz0wMeGiiEsOZRXhgr8jLwZrrDqM6t6t1KImAhbc6VI4F5reBwIm/wEV6PvH/1IWs5KS+j1hDvSG/QprF/zwIBsFkMTXM+7vbqDWcZQOb mfandrade@gmail.com"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "k8s-sg" {
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true # node-container communication
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["${var.MY_CURRENT_IP}/32"] # only me
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}

resource "aws_instance" "k8s-node" {
  count           = 9
  instance_type   = var.INSTANCE_TYPE_NODE
  ami             = data.aws_ami.ubuntu.id
  key_name        = aws_key_pair.mykey.key_name
  security_groups = ["${aws_security_group.k8s-sg.name}"]
  tags = {
    Project = var.PROJECT
    Owner   = var.OWNER
    Type    = "node"
    Name    = "node${count.index}"
  }
}
resource "aws_instance" "k8s-cplane" {
  count           = 1
  instance_type   = var.INSTANCE_TYPE_CPLANE
  ami             = data.aws_ami.ubuntu.id
  key_name        = aws_key_pair.mykey.key_name
  security_groups = ["${aws_security_group.k8s-sg.name}"]
  tags = {
    Project = var.PROJECT
    Owner   = var.OWNER
    Type    = "cplane"
    Name    = "cplane${count.index}"
  }
}
