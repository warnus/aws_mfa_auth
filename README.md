
# AWS Credential Script

AWS CLI 사용할 때 MFA 인증을 위해 사용하는 스크립트

## auth.config 생성

auth.config 파일을 생성 
auth.config 파일 내에 ACCESS KEY 관련 정보를 입력

```
$ cp auth.config.example auth.config
$ vi auth.config
```

```
AWS_ACCESS_KEY=[YOUR ACCESS KEY]
AWS_SECRET_ACCESS_KEY=[YOUR SECRET KEY]
MFA_SERIAL=[YOUR MFA SERIAL]
```

위 정보를 본인 환경에 맞게 설정

## 실행

```
$ ./aws_auth.sh <MFA TOKEN CODE>
```
