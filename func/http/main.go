package main

import (
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/spring-media/lambda-blueprint/api"
)

func main() {
	lambda.Start(handler)
}

func handler() error {
	return api.Get()
}
