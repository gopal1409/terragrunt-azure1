variable "resource_group_name" {
  type  =  string
  default = "terraform-storage-rg"
}
variable "resource_group_location" {
  type = string
  default = "West Europe"
}
variable "storage_account_name" {
  default = "notanotherstorageaccount"
  description = "this is the name of the storage account"
}