resource "porkbun_dns_record" "nextcloud-dev" {
  domain  = var.DOMAIN
  name    = var.SUBDOMAIN
  type    = "A"
  content = hcloud_primary_ip.nextcloud.ip_address
}