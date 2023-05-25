variable "HETZNER_TOKEN" {
  type = string
  sensitive = true
}

variable "ROOT_PASS" {
  type = string
  sensitive = true
}

variable "SSH_KEYFILE" {
  type = string
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