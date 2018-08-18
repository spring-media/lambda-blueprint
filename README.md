# lambda-blueprint [![Build Status](https://travis-ci.com/spring-media/lambda-blueprint.svg?branch=master)](https://travis-ci.com/spring-media/lambda-blueprint) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


Blueprint for developing and deploying AWS Lambda functions using [Go](https://golang.org/dl/) and [Terraform](https://www.terraform.io/).

## setup

### Go

Install [Go 1.10+](https://golang.org/dl/) and test your installation. If you are new to Go it's also recommended to take the [Tour of Go](https://tour.golang.org/welcome/1) and do the [Go Tooling Workshop](https://github.com/campoy/go-tooling-workshop).

### Source Code

With working Go installation and _GOPATH_ setup run

```
go get -d github.com/spring-media/lambda-blueprint
```

to get the source code and try to build, test and lint it

```
cd $GOPATH/src/github.com/spring-media/lambda-blueprint
make dep all 
```

### AWS CLI

Install the [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/installing.html), configure your [credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) and test the installation

```
aws --version
```

### Terraform

Install [Terraform 0.11.7+](https://www.terraform.io/) and test the installation

```
cd $GOPATH/src/github.com/spring-media/lambda-blueprint
make init plan
```

## build

to lint, test, build and statically analyze the lambda functions run

```
make
```

to vendor dependencies (in case compiler complains `cannot find package "github.com/aws/aws-lambda-go/events"`) run

```
make dep
```

check `make help` for all targets.

## infrastructure

### init

to initialize S3 deployment bucket (one-time operation) run

```
make s3-init
```

to initialize terraform run

```
make init
```

### package

to release and upload new lambda versions to S3 run

```
make package
```

### deploy

to build/change infrastructure using Terraform run

```
make deploy
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

