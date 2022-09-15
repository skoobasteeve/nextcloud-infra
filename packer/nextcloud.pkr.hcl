variable "LINODE_TOKEN" {
  type    = string
  default = ""
}

variable "USERNAME" {
  type    = string
  default = ""
}

variable "PASSWORD" {
  type    = string
  default = ""
}

locals {
    podman_dir = "/home/${var.USERNAME}/.podman"
}

source "linode" "nextcloud-centos" {
  image             = "linode/centos-stream9"
  image_description = "CentOS Stream 9 w/ local user and Podman"
  image_label       = "packer-centos-steam9-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  instance_label    = "temp-packer-centos-stream9"
  instance_type     = "g6-nanode-1"
  linode_token      = "${var.LINODE_TOKEN}"
  region            = "us-east"
  ssh_username      = "root"
}

build {
  sources = ["source.linode.nextcloud-centos"]
  provisioner "shell" {
    environment_vars = [
        "USERNAME=${var.USERNAME}",
        "PASSWORD=${var.PASSWORD}",
        "PODMAN_DIR=${local.podman_dir}"
    ]
    script = "image_conf.sh"
    }

  provisioner "file" {
    source = "../podman/systemd/"
    destination = "${local.podman_dir}/nextcloud"
  }

  provisioner "shell" {
    inline = [
        "chown -R ${var.USERNAME}:${var.USERNAME} ${local.podman_dir}",
        "chmod -R 750 ${local.podman_dir}"
    ]
  }
}