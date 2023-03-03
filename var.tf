variable "url" {
  type        = string
  description = "The url for logging in to XOA."
  default = "ws://42.115.65.60/"
}
variable "username" {
  type        = string
  description = "The username for logging in to XOA."
  default = "admin"                                           ### define username to terraform apply in Keeper
}

variable "password" {
  type        = string
  description = "The password for logging in to XOA."
  default     = ""                                                            ##default  = ### define password to terraform apply in Keeper
}

variable "hostname" {
  type        = string
  description = "VM hostname"
  default  = ""
}
# variable "domain" {
#   type        = string
#   description = "Domain name"
#   default  = "amperecomputing.com"
# }
