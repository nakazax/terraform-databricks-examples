#!/bin/bash

set -e

# エラーハンドリング関数
handle_error() {
    echo "エラーが発生しました: $1"
    exit 1
}

# terraform.tfvarsファイルから変数を読み込む
if [ ! -f terraform.tfvars ]; then
    handle_error "terraform.tfvarsファイルが見つかりません。"
fi

read_var() {
    var=$(grep $1 terraform.tfvars | cut -d'=' -f2 | tr -d ' "')
    if [ -z "$var" ]; then
        handle_error "$1 が terraform.tfvars で設定されていません。"
    fi
    echo $var
}

aws_profile=$(read_var aws_profile)
region=$(read_var region)
databricks_account_id=$(read_var databricks_account_id)
databricks_account_client_id=$(read_var databricks_account_client_id)
databricks_account_client_secret=$(read_var databricks_account_client_secret)
metastore_admin_user=$(read_var metastore_admin_user)
prefix=$(read_var prefix)

echo "設定を読み込みました。以下の値で実行します："
echo "AWS Profile: $aws_profile"
echo "Region: $region"
echo "Prefix: $prefix"
echo "Databricks Account ID: $databricks_account_id"

# ワークスペース作成
echo "Databricksワークスペースを作成しています..."
cd ../aws-databricks-flat || handle_error "aws-databricks-flat ディレクトリに移動できません。"
terraform init || handle_error "Terraform初期化に失敗しました。"
terraform apply \
  -var="aws_profile=$aws_profile" \
  -var="region=$region" \
  -var="prefix=$prefix" \
  -auto-approve || handle_error "ワークスペース作成に失敗しました。"

# ワークスペースIDの取得
workspace_id=$(terraform output -raw workspace_id)
if [ -z "$workspace_id" ]; then
    handle_error "ワークスペースIDの取得に失敗しました。"
fi
echo "ワークスペースID: $workspace_id"

# Unity Catalog設定
echo "Unity Catalogを設定しています..."
cd ../hinak-aws-databricks-flat-uc || handle_error "hinak-aws-databricks-flat-uc ディレクトリに移動できません。"
terraform init || handle_error "Terraform初期化に失敗しました。"
terraform apply \
  -var="aws_profile=$aws_profile" \
  -var="region=$region" \
  -var="databricks_account_id=$databricks_account_id" \
  -var="databricks_account_client_id=$databricks_account_client_id" \
  -var="databricks_account_client_secret=$databricks_account_client_secret" \
  -var="databricks_workspace_id=$workspace_id" \
  -var="metastore_admin_user=$metastore_admin_user" \
  -var="prefix=$prefix" \
  -auto-approve || handle_error "Unity Catalog設定に失敗しました。"

echo "セットアップが完了しました！"
