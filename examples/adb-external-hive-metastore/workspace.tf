resource "azurerm_databricks_workspace" "this" {
  name                         = "${local.prefix}-workspace"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  sku                          = "premium"
  tags                         = local.tags
  customer_managed_key_enabled = true
  custom_parameters {
    virtual_network_id                                   = azurerm_virtual_network.this.id
    private_subnet_name                                  = azurerm_subnet.private.name
    public_subnet_name                                   = azurerm_subnet.public.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private.id
    storage_account_name                                 = local.dbfsname
  }
  # We need this, otherwise destroy doesn't cleanup things correctly
  depends_on = [
    azurerm_subnet_network_security_group_association.public,
    azurerm_subnet_network_security_group_association.private
  ]
}


resource "databricks_cluster" "coldstart" {
  cluster_name            = "cluster - external metastore"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = var.node_type
  data_security_mode      = "SINGLE_USER"
  single_user_name        = local.my_username
  autotermination_minutes = 30
  autoscale {
    min_workers = 1
    max_workers = 1
  }

  spark_conf = {
    "spark.hadoop.javax.jdo.option.ConnectionDriverName" : "com.microsoft.sqlserver.jdbc.SQLServerDriver",
    "spark.hadoop.javax.jdo.option.ConnectionURL" : "{{secrets/hive/HIVE-URL}}",
    "spark.hadoop.metastore.catalog.default" : "hive",
    "spark.databricks.delta.preview.enabled" : true,
    "spark.hadoop.javax.jdo.option.ConnectionUserName" : "{{secrets/hive/HIVE-USER}}",
    "datanucleus.fixedDatastore" : true,
    "spark.hadoop.javax.jdo.option.ConnectionPassword" : "{{secrets/hive/HIVE-PASSWORD}}",
    "datanucleus.autoCreateSchema" : false,
    "spark.sql.hive.metastore.jars" : "/dbfs/tmp/hive/3-1-0/lib/*",
    "spark.sql.hive.metastore.version" : "3.1.0",
  }

  spark_env_vars = {
    "HIVE_PASSWORD" = "{{secrets/hive/HIVE-PASSWORD}}",
    "HIVE_USER"     = "{{secrets/hive/HIVE-USER}}",
    "HIVE_URL"      = "{{secrets/hive/HIVE-URL}}",
  }
  depends_on = [
    databricks_secret_scope.kv,
    azurerm_key_vault_secret.hiveuser,
    azurerm_key_vault_secret.hivepwd,
    azurerm_key_vault_secret.hiveurl
  ]
}
