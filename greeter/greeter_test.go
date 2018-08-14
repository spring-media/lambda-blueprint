package greeter_test

import (
	"testing"

	"github.com/spring-media/lambda-blueprint/greeter"
)

func TestGreet(t *testing.T) {
	g := greeter.Greet("Test")

	if "Hello Test" != g {
		t.Fatalf("Expected 'Hello Test', got %s", g)
	}
}
