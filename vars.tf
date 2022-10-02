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
