variable "databricks_account_id" {
  type = string
}

variable "databricks_account_client_id" {
  type        = string
  description = "Application ID of account-level service principal"
}

variable "databricks_account_client_secret" {
  type        = string
  description = "Client secret of account-level service principal"
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "tags" {
  default = {
    "Owner" = "hiroyuki.nakazato@databricks.com"
  }
}

variable "vpc_cidr" {
  default = "10.109.0.0/17"
}

variable "public_subnets_cidr" {
  type    = list(string)
  default = ["10.109.2.0/23"]
}

variable "private_subnet_pair" {
  type    = list(string)
  default = ["10.109.4.0/23", "10.109.6.0/23"]
}

variable "prefix" {
  description = "The prefix to use for resources"
  type        = string
  default     = "hinakflat"
}