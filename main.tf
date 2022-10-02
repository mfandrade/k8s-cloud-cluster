provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "keypair-k8s" {
  key_name   = "mfa@debian"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHmITOQ5ER5wJowTBEAMrglV1tG0MUxWJeV0HHsw7qXNx3q8ZGgRXGyN2nrZ8MbQCTFMXLEGG+q/BrkJiVEDsK/S8/cMxSVmtKoukzzMzg6Q9ujZSAPcGjP2+K9ac2WbytPBSS2AOTJ48RJPW2s/uVFEpFhWhWpsZA9FaBXADaX5hoFkfdlA4OX6gqXMAEF5OlAA8bVJRIpV47qfZMHcFINDSrDlTa2Y7iL+crXcZCYjcpz0wMeGiiEsOZRXhgr8jLwZrrDqM6t6t1KImAhbc6VI4F5reBwIm/wEV6PvH/1IWs5KS+j1hDvSG/QprF/zwIBsFkMTXM+7vbqDWcZQOb mfandrade@gmail.com"
}

resource "aws_security_group" "sg-k8s" {
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = var.IP_MY_CURRENT_WIFI
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}
