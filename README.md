# Nextcloud Deployment

## Requirements

- [Packer](https://www.packer.io/)
- [Terraform](https://www.terraform.io)
- [Linode](https://www.linode.com) account and API token

## Instructions

### Packer

The image created by Packer will be an updated installation of Centos Stream 9 with Podman and all necessary files. 

1. Create a `pkvars.hcl` file in the `packer` directory. This should contain values for all variables defined in `nextcloud.pkr.hcl` including your Linode API token and the local username and password you'd like to use for the instance.
2. Initialize the packer config:
    ``` shell
    cd packer
    packer init nextcloud.pkr.hcl
3. Build the image in Linode:
    ``` shell
    packer build -var-file="pkvars.hcl" nextcloud.pkr.hcl
    ```

### Terraform

This will create a Linode instance using the image created above. After creation, the instance will be available via SSH at the domain name you specified in your `.tfvars` file.

1. Create a `terraform.tfvars` file in the `terraform` directory. This should contain values for all variables defined in `vars.tf`.
2. Create a *.conf file to intialize the S3 backend. This should contain values for `bucket`, `access_key`, and `secret_key`.
3. Initialize the terraform folder:  
    ``` shell
    cd terraform
    terraform init -backend-config=backend.s3.conf
4. Test with `terraform plan`.
5. Run `terraform apply` when ready.

### Podman

