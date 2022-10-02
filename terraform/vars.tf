variable "LINODE_TOKEN" {
  type = string
  sensitive = true
}

variable "ROOT_PASS" {
  type = string
  sensitive = true
}

variable "IMAGE_LABEL" {
  type = string
  default = "packer-centos-stream9"
}

variable "DOMAIN" {
  type = string
  sensitive = true
}

variable "SUBDOMAIN" {
  type = string
  sensitive = true
}

variable "DOMAIN_EMAIL" {
  type = string
  sensitive = true
}