databricks_account_id            = "0d26daa6-5e44-4c97-a497-ef015f91254a"
databricks_account_client_id     = "7b96b0bb-b379-4f9d-8c1f-b54ebb9922fb"
databricks_account_client_secret = "dose494acc41a8b28263482ac1663556e2ab"

tags = {
}

spoke_cidr_block = "10.173.0.0/16"
hub_cidr_block   = "10.10.0.0/16"
region           = "ap-northeast-1"

whitelisted_urls = [
  ".pypi.org",
  ".pythonhosted.org",
  ".cran.r-project.org",
  ".maven.org",
  ".storage-download.googleapis.com",
  ".spark-packages.org"
]

enable_private_link = true
prefix              = "hinak-aws-ex"