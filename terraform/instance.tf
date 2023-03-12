resource "linode_sshkey" "local" {
  label = "local"
  ssh_key = chomp(file("~/.ssh/id_rsa.pub"))
}

resource "linode_instance" "nextcloud" {
        image = "linode/centos-stream9"
        label = "Nextcloud"
        group = "Terraform"
        region = "us-east"
        type = "g6-nanode-1"
        authorized_keys = [linode_sshkey.local.ssh_key]
        root_pass = var.ROOT_PASS
}

resource "linode_volume" "nextcloud-data" {
    label = "nextcloud-data"
    region = linode_instance.nextcloud.region
    linode_id = linode_instance.nextcloud.id
    size = 120
}