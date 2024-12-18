aws_profile                 = "332745928618_databricks-sandbox-admin" // For AWS cli authentication
region                      = "ap-northeast-1"                        // AWS region where you want to deploy your resources
cidr_block                  = "10.4.0.0/16"                           // CIDR block for the workspace VPC, will be divided in two equal sized subnets
my_username                 = "hiroyuki.nakazato@databricks.com"      // Username for tagging the resources
databricks_users            = ["hiroyuki.nakazato@databricks.com"]    // List of users that will be admins at the workspace level
databricks_metastore_admins = ["hiroyuki.nakazato@databricks.com"]    // List of users that will be admins for Unity Catalog
unity_admin_group           = "hinak-test-group-20241111"             // Metastore Owner and Admin
databricks_account_id       = "0d26daa6-5e44-4c97-a497-ef015f91254a"  // Databricks Account ID
databricks_client_id        = "7b96b0bb-b379-4f9d-8c1f-b54ebb9922fb"  // Databricks Service Principal Client ID
databricks_client_secret    = "dose3026bdf5557e138eb97d8ef75965a466"  // Databricks Service Principal Client Secret
workspace_name              = "hinak-tf-aws-uc-simple-20241111"       // Databricks Workspace Name - IF NOT PROVIDED or EMPTY it will defauly to a random "demo-<number>" prefix
tags = {
  Environment = "Demo-with-terraform"
  Owner       = "hiroyuki.nakazato@databricks.com"
}
