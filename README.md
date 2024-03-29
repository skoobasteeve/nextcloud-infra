# Nextcloud Deployment with Terraform and Ansible

This repo holds the configuration files for my personal Nextcloud server running in Hetzner Cloud. It uses rootless Podman on top of Centos Stream 9 running the following containers:
- [nextcloud-fpm](https://hub.docker.com/_/nextcloud)
- [mariadb](https://hub.docker.com/_/mariadb)
- [caddy](https://hub.docker.com/_/caddy)

The containers run in a Podman pod and are managed as user-level [Systemd service files](https://docs.podman.io/en/latest/markdown/podman-generate-systemd.1.html).

## Requirements

- [Ansible](https://docs.ansible.com)
- [Terraform](https://www.terraform.io)
- [Hetzner Cloud](https://www.hetzner.cloud) account and API token
- [Porkbun](https://porkbun.com) account and API token (for DNS)
- [Tailscale](https://tailscale.com/) account and [auth key](https://tailscale.com/kb/1085/auth-keys/)
- [LibreNMS](https://www.librenms.org/) server for SNMP and syslog monitoring
- [Borg](https://www.borgbackup.org/) repostiory for backups

## Instructions

### Terraform

The Terraform files in this repo will create a Hetzner Cloud server instance complete with an attached firewall and block storage volume. In addition, it will create a DNS "A" record in Porkbun that reflects the server's public IP address. After creation, the instance will be available via SSH at the domain name you specified in your `.tfvars` file.

1. Create a `terraform.tfvars` file in the `terraform` directory. This should contain values for all variables defined in `vars.tf`.
2. Create a `backend.s3.conf` file to intialize the S3 backend. This should contain values for `bucket`, `access_key`, and `secret_key`.
3. Initialize the terraform folder:  
    ``` shell
    cd terraform
    terraform init -backend-config=backend.s3.conf
4. Test with `terraform plan`.
5. Run `terraform apply` when ready.

Once complete, you can SSH into the server as the user assigned to the `USER` variable in your `vars.tf`.

### Ansible

The Ansible playbook in this repo will perform the following tasks:
- Add relevant SSH keys
- Enable auto-updates for Centos
- Install Tailscale and join the system to your Tailscale network
- Configure SNMP and rsyslog to send data to a LibreNMS server
- Install and configure Podman
- Add the Systemd service files for the Podman containers
- Configure the Caddy webserver
- Install and configure Borg for nightly backups
- Start the Nextcloud pod

The Ansible playbook in this repo makes use of [Ansible Vault](https://docs.ansible.com/ansible/latest/vault_guide/index.html) to store sensitive variables. Any variables in the `vars.yml` files that are set to an equivalent variable prefixed with "vault_" are configured in the accompanying `vault.yml` file.

1. Set the non-vault variables in all `vars.yaml` files.

2. Set the  variables in both `vault.yml` files:
    ``` shell
    ansible-vault edit roles/nextcloud/vars/vault.yml
    ansible-vault edit roles/tailscale/vars/vault.yml
    ansible-vault edit roles/borgbackup/vars/vault.yml
    ```

3. The playbook expects a host named "nextcloud-hetzner" in your [inventory](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html), so make sure to add/update it before running the playbook.

4. Once your inventory is up-to-date and variables have been edited in all instances of `vars.yml` and `vault.yml`, run the playbook.
    ``` shell
    ansible-playbook --vault-password-file=.vault_pass -i ~/.ansible/hosts --ask-become-pass playbook-nextcloud.yml
    ```

When the playbook finishes running, your Nextcloud server should be available at the domain name specified.

### Post-Install

#### **Nextcloud config file**
Once you've confirmed that the Nextcloud instance is up and running, add the following lines to `config/config.php` in your Nextcloud directory to optimize the instance and clear warnings:

Fix trusted proxy warning
``` php
'trusted_proxies' =>
  array (
    0 => 'localhost',
  ),
```

Set default phone region
``` php
'default_phone_region' => 'US',
```

Speed up photo thumbnail generation and reduce size
``` php
'preview_max_x' => '2048',
'preview_max_y' => '2048',
'jpeg_quality' => '60',
```

#### **Nextcloud apps**
- [Preview Generator](https://apps.nextcloud.com/apps/previewgenerator) - Automatically generate thumbnail previews for photos on a scheduled basis, speeding up load times for previews.
- [Two-Factor WebAuthn](https://apps.nextcloud.com/apps/twofactor_webauthn) - Use a FIDO2 security key as a second factor.
- [Tasks](https://apps.nextcloud.com/apps/tasks) - Task management with CalDAV sync.

## Backup
Backup is configured via the `borgbackup` Ansible role in the repo and uses the [Borg](https://www.borgbackup.org/) and [Borgmatic](https://torsion.org/borgmatic/) projects to back up the Nextcloud configuration, data directory, and MySQL database. This backup runs once daily.

Assuming you've set the variables in `roles/borgbackup/vars/vault.yml`, the only thing you'll need to do is add the generated SSH key to the `authorized_keys` file on the Borg server. Alternatively, if you use [Borgbase](https://www.borgbase.com), make sure you've added the key under SSH Keys and attached that key to the repo. 

First, initialize the borg repositories
``` bash
sudo /root/.local/bin/borgmatic init -e repokey
```

To test the backup, run:
``` bash
sudo /root/.local/bin/borgmatic
```