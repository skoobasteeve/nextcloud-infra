resource "porkbun_dns_record" "nextcloud-dev" {
  domain  = "raylyon.dev"
  name    = "nextcloud-dev"
  type    = "A"
  content = hcloud_primary_ip.nextcloud.ip_address
}