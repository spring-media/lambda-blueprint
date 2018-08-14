package main

import (
	"context"
	"log"

	"github.com/spring-media/lambda-blueprint/greeter"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-lambda-go/lambdacontext"
)

// see https://docs.aws.amazon.com/lambda/latest/dg/go-programming-model.html for details
func main() {
	lambda.Start(handler)
}

func handler(ctx context.Context) error {
	lc, _ := lambdacontext.FromContext(ctx)
	log.Printf("%s", greeter.Greet(lc.AwsRequestID))
	return nil
}
