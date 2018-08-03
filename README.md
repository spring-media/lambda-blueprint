lambda-blueprint
================

Blueprint for developing and deploying AWS Lambda functions using [Go](https://golang.org/dl/) an[Terraform](https://www.terraform.io/).

## dependencies

* (dev) [Go 1.10+](https://golang.org/dl/)
* (dev) [vgo](https://research.swtch.com/vgo-tour) (no manuall installation necessary if Makefile is used)
* (deploy) [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/installing.html) with configured [credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)
* (deploy) [Terraform 0.11.7+](https://www.terraform.io/)

## build

to lint, test, build and statically analyze the lambda functions run

```
make
```

check `make help` for all targets.

## infrastructure

to build/change infrastructure using Terraform run

```
make deploy
```

to destroy Terraform-managed infrastructure run

```
make destroy
```

## todo

* CloudWatch alarms
* API Gateway event example
* replace vgo with go modules (1.11)

