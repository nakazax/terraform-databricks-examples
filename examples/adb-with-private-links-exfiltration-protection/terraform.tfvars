hubcidr          = "10.178.0.0/20"
spokecidr        = "10.179.0.0/20"
rglocation       = "japaneast"
metastoreip      = "40.78.233.2"
dbfs_prefix      = "dbfs"
workspace_prefix = "adb"
firewallfqdn = [                                                      // we don't need scc relay and dbfs fqdn since they will go to private endpoint
  "dbartifactsprodjapaneast.blob.core.windows.net",                        //databricks artifacts
  "dbartifactsprodjapanwest.blob.core.windows.net",                         //databricks artifacts secondary
  "dblogprodjapaneast.blob.core.windows.net",                            //log blob
  "prod-japaneast-observabilityeventhubs.servicebus.windows.net", //eventhub
  "cdnjs.com",                                                        //ganglia
]
tags = {
  Owner = "hiroyuki.nakazato@databricks.com"
}