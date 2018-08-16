package main

import (
	"context"
	"fmt"
	"log"
	"math/rand"
	"os"
	"os/signal"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/rs/xid"
)

func main() {
	sess, err := session.NewSession(&aws.Config{
		Region: aws.String("eu-central-1")},
	)

	if err != nil {
		log.Fatalf("failed to create aws session: %v", err)
	}
	svc := dynamodb.New(sess)

	c1, cancel := context.WithCancel(context.Background())
	exitCh := make(chan struct{})
	fmt.Println("Press ^C to stop.")

	r := rand.Intn(5)
	go func(ctx context.Context) {
		for {
			fmt.Println("expect new dynamodb item")
			guid := xid.New()
			_, err = svc.PutItem(&dynamodb.PutItemInput{
				TableName: aws.String("example-stream-enabled-table"),
				Item: map[string]*dynamodb.AttributeValue{
					"id": &dynamodb.AttributeValue{S: aws.String(guid.String())},
				},
			})
			if err != nil {
				log.Printf("dynamodb put failed: %v", err)
			}
			time.Sleep(time.Second * time.Duration(r))

			select {
			case <-ctx.Done():
				exitCh <- struct{}{}
				return
			default:
			}
		}
	}(c1)

	signalCh := make(chan os.Signal, 1)
	signal.Notify(signalCh, os.Interrupt)
	go func() {
		select {
		case <-signalCh:
			cancel()
			return
		}
	}()
	<-exitCh
}
