package main

import (
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/spring-media/lambda-blueprint/greeter"
)

func main() {
	lambda.Start(handler)
}

func handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{
		Body:       greeter.Greet("Hello World"),
		StatusCode: 200,
		Headers:    map[string]string{"Content-Type": "text/plain"},
	}, nil
}
