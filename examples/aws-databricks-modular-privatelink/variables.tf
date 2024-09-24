variable "databricks_account_client_id" {
  type        = string
  description = "Application ID of account-level service principal"
}

variable "databricks_account_client_secret" {
  type        = string
  description = "Client secret of account-level service principal"
}

variable "databricks_account_id" {
  type        = string
  description = "Databricks Account ID"
}

variable "region" {
  type        = string
  description = "AWS region to deploy to"
  default     = "ap-northeast-1"
}

# cmk
# variable "cmk_admin" {
#   type    = string
#   default = "arn:aws:iam::332745928618:user/cmk_admin"
# }

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Optional tags to add to created resources"
}

variable "vpc_cidr" {
  default = "10.109.0.0/17"
}

variable "public_subnets_cidr" {
  type    = list(string)
  default = ["10.109.2.0/23"]
}

variable "privatelink_subnets_cidr" {
  type    = list(string)
  default = ["10.109.4.0/23"]
}

variable "workspace_vpce_service" {
  type    = string
  default = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-02691fd610d24fd64"
}

variable "relay_vpce_service" {
  type    = string
  default = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-02aa633bda3edbec0"
}

variable "workspace_1_config" {
  default = {
    private_subnet_pair = { subnet1_cidr = "10.109.6.0/23", subnet2_cidr = "10.109.8.0/23" }
    workspace_name      = "hinak-test-ws-1"
    prefix              = "hinak-ws1" // prefix decides subnets name
    region              = "ap-northeast-1"
    root_bucket_name    = "hinak-test-ws-1-rootbucket"
    block_list          = ["58.133.93.159"]
    allow_list          = ["65.184.145.97"] // if allow_list empty, all public IP not blocked by block_list are allowed
    tags = {
      "Name" = "hinak-test-ws-1-tags",
      "Env"  = "hinak-test-ws-1",
      "Owner" = "hiroyuki.nakazato@databricks.com"
    }
  }
}

/*
variable "workspace_2_config" {
  default = {
    private_subnet_pair = { subnet1_cidr = "10.109.10.0/23", subnet2_cidr = "10.109.12.0/23" }
    workspace_name      = "test-workspace-2"
    prefix              = "ws2" // prefix decides subnets name
    region              = "ap-southeast-1"
    root_bucket_name    = "test-workspace-2-rootbucket"
    block_list          = ["54.112.179.135", "195.78.164.130"]
    allow_list          = ["65.184.145.97"] // if allow_list empty, all public IP not blocked by block_list are allowed
    tags = {
      "Name" = "test-workspace-2-tags"
    }
  }
}
*/