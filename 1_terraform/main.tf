terraform {
  required_version = "1.3.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.33.0"
    }
  }
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
  count           = var.NUM_OF_NODES
  ami             = var.AMI_IMAGE
  instance_type   = var.INSTANCE_TYPE_NODE
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
  ami             = var.AMI_IMAGE
  instance_type   = var.INSTANCE_TYPE_CPLANE
  key_name        = aws_key_pair.mykey.key_name
  security_groups = ["${aws_security_group.k8s-sg.name}"]
  tags = {
    Project = var.PROJECT
    Owner   = var.OWNER
    Type    = "cplane"
    Name    = "cplane${count.index}"
  }
}
