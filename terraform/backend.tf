terraform {
  backend "s3" {
    # bucket, access key, secret key need to be set in config file
    key    = "tfstate/terraform.tfstate"
    endpoint = "https://s3.us-west-001.backblazeb2.com"
    region = "main"

    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
    force_path_style = true
  }
}