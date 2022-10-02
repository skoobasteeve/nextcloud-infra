terraform {
  backend "s3" {
    # Below vars set in backend.s3.conf
    # endpoint = $endpoint
    # bucket = $bucket
    # access_key = $access_key
    # secret_key = $secret_key
    key    = "tfstate/terraform.tfstate"
    region = "main"

    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
    force_path_style = true
  }
}