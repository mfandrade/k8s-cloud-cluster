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
  ami             = "ami-085925f297f89fce1"
  instance_type   = "t2.medium"
  key_name        = "mykey"
  count           = 2
  tags            = var.TAGS_INSTANCES
  security_groups = ["${aws_security_group.k8s-sg.name}"]
}
resource "aws_instance" "k8s-master" {
  ami             = "ami-085925f297f89fce1"
  instance_type   = "t2.medium"
  key_name        = "mykey"
  count           = 1
  tags            = var.TAGS_INSTANCES
  security_groups = ["${aws_security_group.k8s-sg.name}"]
}
