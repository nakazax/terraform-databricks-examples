resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  prefix = "${var.prefix}${random_string.naming.result}"
}

// Create S3 bucket for metastore
resource "aws_s3_bucket" "metastore" {
  bucket        = "${local.prefix}-metastore"
  force_destroy = true

  tags = {
    Name = "${local.prefix}-metastore"
  }
}

// Create metastore admin group
data "databricks_user" "metastore_admin_user" {
  provider  = databricks.mws
  user_name = var.metastore_admin_user
}

data "databricks_service_principal" "metastore_admin_sp" {
  provider       = databricks.mws
  application_id = var.databricks_account_client_id
}

resource "databricks_group" "metastore_admins" {
  provider     = databricks.mws
  display_name = "${local.prefix}-metastore-admins"
}

resource "databricks_group_member" "metastore_admin_user" {
  provider  = databricks.mws
  group_id  = databricks_group.metastore_admins.id
  member_id = data.databricks_user.metastore_admin_user.id
}

resource "databricks_group_member" "metastore_admin_service_principal" {
  provider  = databricks.mws
  group_id  = databricks_group.metastore_admins.id
  member_id = data.databricks_service_principal.metastore_admin_sp.id
}

// Create metastore
resource "databricks_metastore" "this" {
  depends_on = [databricks_group_member.metastore_admin_user, databricks_group_member.metastore_admin_service_principal]
  provider      = databricks.mws
  name          = "${local.prefix}-metastore"
  storage_root  = "s3://${aws_s3_bucket.metastore.id}/metastore"
  owner         = databricks_group.metastore_admins.display_name
  region        = var.region
  force_destroy = true
}

// Assign metastore to workspace
resource "databricks_metastore_assignment" "this" {
  provider     = databricks.mws
  metastore_id = databricks_metastore.this.id
  workspace_id = var.databricks_workspace_id
}
