resource "hcloud_ssh_key" "local" {
  name = "local"
  public_key = file(var.SSH_KEYFILE)
}

resource "hcloud_server" "nextcloud" {
  name = "Nextcloud"
  image = "centos-stream-9"
  server_type = "cpx11"
  location = "ash"
  ssh_keys = [hcloud_ssh_key.local.id]
  firewall_ids = [hcloud_firewall.nextcloud.id]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

resource "hcloud_volume" "nextcloud" {
  name = "nextcloud-data"
  size = 120
  server_id = hcloud_server.nextcloud.id
  automount = true
  format = "ext4"
}