# Nextcloud Deployment

## Terraform

1. Create a `terraform.tfvars` file. This should contain values for all variables defined in `vars.tf`
2. Create a *.conf file to intialize the S3 backend. This should contain values for `bucket`, `access_key`, and `secret_key`.
3. Initialize the terraform folder:  
    ``` shell
    cd terraform
    terraform init -backend-config=backend.s3.conf
4. Test with `terraform plan`.
5. Run `terraform apply` when ready.

## Podman

