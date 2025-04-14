# AWS Databricks Unity Catalog Setup with Flat Architecture

このテンプレートは、Terraformを使用してDatabricksワークスペースを作成し、Unity Catalogを設定する方法を示しています。フラットなアーキテクチャを採用し、メタストア管理者グループの作成と既存のユーザー・サービスプリンシパルの追加を行います。

## 前提条件

- Terraformがインストールされていること
- 必要な権限を持つDatabricksアカウントがあること
- 既存のDatabricksユーザーとサービスプリンシパルが存在すること

## 使用方法

1. `~/.aws/credentials` ファイルに最新のAWSクレデンシャルが反映されていることを確認します。デフォルトのプロファイル名は `332745928618_databricks-sandbox-admin` です。

2. `terraform.tfvars`ファイルを編集し、必要な値を設定します。特に以下のDatabricksクレデンシャルが最新であることを確認してください：

```hcl
aws_profile                      = "your-aws-profile"
region                           = "your-aws-region"
databricks_account_id            = "your-databricks-account-id"
databricks_account_client_id     = "your-client-id"
databricks_account_client_secret = "your-client-secret"
metastore_admin_user             = "existing-user@example.com"
prefix                           = "your-prefix"
```

3. セットアップスクリプトを実行して、Databricksワークスペースを作成し、Unity Catalogを設定します：

```bash
chmod +x setup_flat_uc.sh
./setup_flat_uc.sh
```

このスクリプトは以下の操作を行います：
- `aws-databricks-flat`テンプレートを使用して新しいDatabricksワークスペースを作成
- ワークスペースIDを取得
- 新しく作成されたワークスペースにUnity Catalogを設定
- メタストア管理者グループを作成し、指定したユーザーとサービスプリンシパルを追加

## 主な変更点

- フラットなアーキテクチャを採用し、すべてのリソースを1つのTerraformモジュールで管理
- 既存のユーザーとサービスプリンシパルをデータソースとして参照
- メタストア管理者グループの作成と、ユーザー・サービスプリンシパルの自動追加

## 手動デプロイ

スクリプトを使用せずに手動でデプロイする場合は、以下の手順に従ってください：

1. `examples/hinak-aws-databricks-flat-uc`ディレクトリで以下を実行します：

```bash
terraform init
terraform apply
```

2. プロンプトが表示されたら、`yes`と入力して確認します。

## クリーンアップ

作成したリソースを削除するには、以下のコマンドを実行します：

```bash
./teardown_flat_uc.sh
```

注意：リソースの削除はDatabricks環境に影響を与える可能性があります。実行前に影響を十分に理解してください。

## トラブルシューティング

問題が発生した場合は、以下を確認してください：
- AWS認証情報が正しく設定されていること
- Databricksアカウント情報が正確であること
- 指定したユーザーとサービスプリンシパルが実際に存在すること
