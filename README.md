# マーケットプレース用スクリプト

## AWS CLIの設定

AWS CLIを使うのでアクセスキー` ~/.aws/config `ファイルが必要です。

ここでは`mp`と名前をつけています。

```
 ~/.aws/config 
[default]
aws_access_key_id = AKIAXXXXXXXXXXXXXXXXXXXXX
aws_secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXXXXXX
region = ap-northeast-1

[profile mp]
aws_access_key_id = AKIAXXXXXXXXXXXXXXXX
aws_secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
region = us-east-1
```

## add_owner_to_ami.sh 

AMIとその元になっているSnapshotのpermisionにmarketplaceを追加します。

```
Add AWS MarketPlase OwnerID to your AMI and Snapshot.
  Usage:
    add_owner_to_ami.sh AMI_ID [PROFILE_NAME]
      AMI_ID: must
      PROFILE_NAME: optional
  Requiremets:
    - aws cli
    - jq
  Profile Configration:
    ~/.aws/config
```

amiのIDとプロファイル名を入れたら、MP用のオーナーがつきます。

```
$ ./add_owner_to_ami.sh ami-xxxxxx mp
```

