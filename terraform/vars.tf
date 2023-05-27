variable "HETZNER_TOKEN" {
  type      = string
  sensitive = true
}

variable "PORKBUN_API_KEY" {
  type      = string
  sensitive = true
}

variable "PORKBUN_SECRET_KEY" {
  type      = string
  sensitive = true
}

variable "SSH_KEYFILE" {
  type = string
}

variable "DOMAIN" {
  type      = string
  sensitive = true
}

variable "SUBDOMAIN" {
  type      = string
  sensitive = true
}

variable "DOMAIN_EMAIL" {
  type      = string
  sensitive = true
}