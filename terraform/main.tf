module "lambda" {
  source  = "spring-media/lambda/aws"
  version = "2.4.1"

  handler       = "scheduled"
  function_name = "lambda-blueprint-stream-fct"
  s3_bucket     = "${var.s3_bucket}"
  s3_key        = "${var.version}/scheduled.zip"

  event {
    type                = "cloudwatch-scheduled-event"
    schedule_expression = "rate(1 minute)"
  }

  tags {
    service    = "my-service"
    component  = "this-lambda"
    managed_by = "terraform"
  }
}
