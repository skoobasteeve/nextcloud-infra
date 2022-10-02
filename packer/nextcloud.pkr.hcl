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

variable "DOMAIN" {
  type    = string
  default = ""
}

locals {
    podman_dir = "/home/${var.USERNAME}/.podman"
}

locals {
    systemd_dir = "/home/${var.USERNAME}/.config/systemd/user"
}

source "linode" "nextcloud-centos" {
  image             = "linode/centos-stream9"
  image_description = "CentOS Stream 9 w/ local user and Podman"
  image_label       = "packer-centos-stream9-${formatdate("YYYYMMDDhhmmss", timestamp())}"
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
        "PODMAN_DIR=${local.podman_dir}",
        "SYSTEMD_DIR=${local.systemd_dir}"
    ]
    script = "image_conf.sh"
    }
  
  provisioner "file" {
    source = "../podman/sysctl.d/"
    destination = "/etc/sysctl.d"
  }

  provisioner "file" {
    source = "../podman/systemd/"
    destination = "${local.systemd_dir}"
  }

  provisioner "file" {
    source = templatefile("../podman/caddy/Caddyfile.tmpl", {domain = var.DOMAIN})
    destination = "${local.podman_dir}/nextcloud/caddy/Caddyfile"
  }

  provisioner "shell" {
    inline = [
        "chown -R ${var.USERNAME}:${var.USERNAME} ${local.podman_dir}",
        "chown -R ${var.USERNAME}:${var.USERNAME} /home/${var.USERNAME}/.config",
        "chmod -R 750 ${local.podman_dir}",
        "chmod -R 750 /home/${var.USERNAME}/.config"
    ]
  }
}