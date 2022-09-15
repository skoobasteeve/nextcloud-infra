#!/bin/bash -x

useradd -m -U "$USERNAME"
echo "$PASSWORD" | passwd --stdin "$USERNAME"

usermod -aG wheel "$USERNAME"
mkdir -p "$PODMAN_DIR/nextcloud"

dnf update -y
dnf install -y podman
