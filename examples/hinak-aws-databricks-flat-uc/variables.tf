variable "aws_profile" {
  type        = string
  description = "AWS profile to use for authentication"
}

variable "region" {
  type        = string
  description = "AWS region to deploy to"
}

variable "databricks_account_id" {
  type        = string
  description = "Databricks Account ID"
}

variable "databricks_account_client_id" {
  type        = string
  description = "Client ID for Databricks account-level authentication"
}

variable "databricks_account_client_secret" {
  type        = string
  description = "Client secret for Databricks account-level authentication"
}

variable "databricks_workspace_id" {
  type        = string
  description = "The ID of the Databricks workspace to configure Unity Catalog"
}

variable "metastore_admin_user" {
  type        = string
  description = "User to be added as metastore admin"
}

variable "prefix" {
  type        = string
  description = "Prefix for resource names"
}
