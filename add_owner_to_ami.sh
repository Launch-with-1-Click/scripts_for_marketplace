#!/bin/bash

set -ex

## Exit options not passed.
if [ "$1" == "" ];then
  cat <<EOL
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
EOL
  exit
fi

MP_OWNERID=679593333241
AMI_ID=$1
PROFILE_NAME=$2

if [ "$2" == "" ]; then
  PROFILE_CMD=''
else
  PROFILE_CMD="--profile ${PROFILE_NAME}"
fi

SNAP_ID=`aws ec2 describe-images --image-ids "${AMI_ID}" ${PROFILE_CMD} | jq '.Images[0].BlockDeviceMappings[0].Ebs.SnapshotId'`

## Add Owner to AMI
aws ec2 modify-image-attribute ${PROFILE_CMD} --image-id ${AMI_ID} --launch-permission "{\"Add\": [{\"UserId\":\"${MP_OWNERID}\"}]}"

## Add Owner to Snapshot
aws ec2 modify-snapshot-attribute ${PROFILE_CMD} --snapshot-id ${SNAP_ID//\"} --create-volume-permission "{\"Add\": [{\"UserId\":\"${MP_OWNERID}\"}]}"

