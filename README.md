# Nextcloud Deployment

## Requirements

- [Ansible](https://docs.ansible.com)
- [Terraform](https://www.terraform.io)
- [Hetzner Cloud](https://www.hetzner.cloud) account and API token

## Instructions

### Terraform

This will create a Hetzner Cloud instance using the image created above. After creation, the instance will be available via SSH at the domain name you specified in your `.tfvars` file.

1. Create a `terraform.tfvars` file in the `terraform` directory. This should contain values for all variables defined in `vars.tf`.
2. Create a *.conf file to intialize the S3 backend. This should contain values for `bucket`, `access_key`, and `secret_key`.
3. Initialize the terraform folder:  
    ``` shell
    cd terraform
    terraform init -backend-config=backend.s3.conf
4. Test with `terraform plan`.
5. Run `terraform apply` when ready.

### Ansible

Coming soon...

### Post-Install

Add the following line to `config/config.php` in your Nextcloud directory:
``` php
'trusted_proxies' =>
  array (
    0 => 'localhost',
  ),
'default_phone_region' => 'US',
```

