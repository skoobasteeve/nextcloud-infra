terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.39.0"
    }
    porkbun = {
      source  = "cullenmcdermott/porkbun"
      version = "0.2.0"
    }
  }
}

provider "hcloud" {
  token = var.HETZNER_TOKEN
}

provider "porkbun" {
  api_key    = var.PORKBUN_API_KEY
  secret_key = var.PORKBUN_SECRET_KEY
}