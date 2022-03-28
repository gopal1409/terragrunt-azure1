variable "registry_name" {
  default = "gopalregistry"
  description = "the container registry name"
}

variable "resource_group_name" {
  default = "terraform-storage-rg"
}
variable "resource_group_location" {
  type = string
  default = "West Europe"
}