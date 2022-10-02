variable "LINODE_TOKEN" {
  type = string
  sensitive = true
}

variable "ROOT_PASS" {
  type = string
  sensitive = true
}

variable "IMAGE_LABEL" {
  type = string
  default = "packer-centos-stream-9"
}