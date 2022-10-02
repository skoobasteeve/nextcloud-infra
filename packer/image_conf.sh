#!/bin/bash -x

useradd -m -U "$USERNAME"
echo "$PASSWORD" | passwd --stdin "$USERNAME"

usermod -aG wheel "$USERNAME"
mkdir -p "$PODMAN_DIR/nextcloud"
mkdir -p "$SYSTEMD_DIR"

dnf update -y
dnf install -y podman

sysctl net.ipv4.ip_unprivileged_port_start=80
