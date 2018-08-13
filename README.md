lambda-blueprint
================

Blueprint for developing and deploying AWS Lambda functions using [Go](https://golang.org/dl/) an[Terraform](https://www.terraform.io/).

## dependencies

* (dev) [Go 1.10+](https://golang.org/dl/)
* (deploy) [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/installing.html) with configured [credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)
* (deploy) [Terraform 0.11.7+](https://www.terraform.io/)

## build

to lint, test, build and statically analyze the lambda functions run

```
make
```

check `make help` for all targets.

## infrastructure

All infrastructure targets support configuration of the AWS region. Example to override the default:

```
make REGION=eu-west-1 deploy
```

### init

to initialize S3 deployment bucket (one-time operation) run

```
make init
```

### deploy

to build/change infrastructure using Terraform run

```
make package deploy
```

### destroy

to destroy Terraform-managed infrastructure run

```
make destroy
```

### Rollback

to rollback to a previous version (uploaded to S3) provide the target version and run

```
make VERSION=v0.0.1 deploy
```

## todo

* CloudWatch alarms
* API Gateway event example
* support for policy config of module

