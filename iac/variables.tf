variable "project" {
  type    = string
  default = "homelab-pi-510022"
}

variable "region" {
  type    = string
  default = "europe-west9"
}

variable "dns_project" {
  type    = string
  default = "theoboursy-fr"
}

variable "dns_zone" {
  type    = string
  default = "theoboursy"
}

variable "vip" {
  type    = string
  default = "192.168.1.200"
}

variable "vps_ip" {
  type    = string
  default = "92.222.85.53"
}
