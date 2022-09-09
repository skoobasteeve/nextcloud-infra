resource "linode_domain" "raylyon-dev" {
    type = "master"
    domain = "raylyon.dev"
    soa_email = "admin@raylyon.net"
}

resource "linode_domain_record" "nextcloud-dev" {
    domain_id = linode_domain.raylyon-dev.id
    name = "nextcloud-dev"
    record_type = "A"
    target = linode_instance.nextcloud.ip_address
}