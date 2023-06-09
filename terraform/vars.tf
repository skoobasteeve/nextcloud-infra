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

variable "USER" {
  type      = string
  sensitive = true
}

variable "PASS_HASH" {
  type      = string
  sensitive = true
}

variable "ALT_SSH_PORT" {
  type = string
  sensitive = false
}