output "metastore_id" {
  value       = databricks_metastore.this.id
  description = "ID of the created Unity Catalog metastore"
}

output "metastore_name" {
  value       = databricks_metastore.this.name
  description = "Name of the created Unity Catalog metastore"
}

output "metastore_storage_root" {
  value       = databricks_metastore.this.storage_root
  description = "Storage root of the created Unity Catalog metastore"
}
