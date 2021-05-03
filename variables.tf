variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "key" {
  type = string
}

variable "container_name" {
  type = string
}

variable "location" {
  type    = string
  default = "East US"
}
