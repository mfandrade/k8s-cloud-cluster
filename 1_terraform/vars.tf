variable "INSTANCE_TYPE_NODE" {
  type        = string
  description = "The instance type for a node."
  default     = "t2.micro"
}

variable "INSTANCE_TYPE_CPLANE" {
  type        = string
  description = "The instance type for a controlplane."
  default     = "t2.micro"
}

variable "AMI_IMAGE" {
  type        = string
  description = "AMI ID of your desired image."
  default     = "ami-09a41e26df464c548" # Debian 11 Bullseye
}

variable "NUM_OF_NODES" {
  type        = number
  description = "How many nodes do you want."
  default     = 2
}

variable "MY_CURRENT_IP" {
  type        = string
  description = "My public IP (https://www.google.com/search?q=what+is+my+ip)."
}

variable "PROJECT" {
  type        = string
  description = "An identification of the project."
  default     = "myk8s"
}

variable "OWNER" {
  type        = string
  description = "The responsible for the instance."
}

variable "INVENTORY_FILE" {
  type        = string
  description = "Relative path of inventory file for Ansible."
  default     = "../2_ansible/hosts.ini"
}
