
variable "image" {
  type = "string"
  default = "Cirros"
}

variable "external_network" {
  type    = "string"
  default = "ext-net"
}

variable "provider_network" {
  type    = "string"
  default = "prov-net"
}

variable "dns" {
  type    = "list"
  default = ["8.8.8.8", "8.8.8.4"]
}

variable "flavor_small" {
  type    = "string"
  default = "m1.small"
}

variable "volume_size" {
  type    = "string"
  default = 40
}
