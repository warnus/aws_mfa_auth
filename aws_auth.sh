#!/bin/bash


if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <MFA_TOKEN_CODE>"
  echo "Where:"
  echo "   <MFA_TOKEN_CODE> = Code from virtual MFA device"
  exit 2
fi

# aws 설치 여부 확인
AWS_CLI=`which aws`

if [ $? -ne 0 ]; then
  echo "AWS CLI is not installed; exiting"
  exit 1
else
  echo "Using AWS CLI found at $AWS_CLI"
fi

# 설정 파일 로드
. auth.config

# .aws 디렉토리 확인
if [ ! -d $HOME/.aws ]; then
  echo "Configure AWS Credential"
  aws configure set aws_access_key_id "$AWS_ACCESS_KEY"
  aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
fi

# token 가져오기
TOKEN=`aws sts get-session-token --serial-number ${MFA_SERIAL} --output text --token-code $1`
MFA_AWS_ACCESS_KEY=`echo $TOKEN | awk '{print $2}'`
MFA_AWS_SECRET_KEY=`echo $TOKEN | awk '{print $4}'`
MFA_AWS_SESSION_TOKEN=`echo $TOKEN | awk '{print $5}'`

aws configure set profile.mfa.aws_access_key_id "$MFA_AWS_ACCESS_KEY"
aws configure set profile.mfa.aws_secret_access_key "$MFA_AWS_SECRET_KEY"
aws configure set profile.mfa.aws_session_token "$MFA_AWS_SESSION_TOKEN"
