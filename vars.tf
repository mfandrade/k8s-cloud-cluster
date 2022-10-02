variable "MY_CURRENT_IP" {
  type        = string
  description = "My public IP (https://www.google.com/search?q=what+is+my+ip)."
}

variable "TAGS_INSTANCES" {
  type        = map(string)
  description = "Default tags for instances."
  default = {
    Name    = "k8s-instance"
    Owner   = "Marcelo F Andrade"
    Project = "MyK8SCluster"
  }
}
