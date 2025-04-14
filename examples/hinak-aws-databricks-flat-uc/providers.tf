terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.region
}

// Initialize provider in "MWS" mode to provision new workspace
provider "databricks" {
  alias         = "mws"
  host          = "https://accounts.cloud.databricks.com"
  account_id    = var.databricks_account_id
  client_id     = var.databricks_account_client_id
  client_secret = var.databricks_account_client_secret
}
