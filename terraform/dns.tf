resource "linode_domain" "nextcloud-domain" {
    type = "master"
    domain = var.DOMAIN
    soa_email = var.DOMAIN_EMAIL
}

resource "linode_domain_record" "nextcloud-sub" {
    domain_id = linode_domain.nextcloud-domain.id
    name = var.SUBDOMAIN
    record_type = "A"
    target = linode_instance.nextcloud.ip_address
}