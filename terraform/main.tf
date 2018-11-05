module "lambda" {
  source        = "github.com/spring-media/terraform-aws-lambda?ref=v2.1.0"
  handler       = "scheduled"
  function_name = "lambda-blueprint-stream-fct"
  s3_bucket     = "${var.s3_bucket}"
  s3_key        = "${var.version}/scheduled.zip"

  event {
    type                = "cloudwatch-event"
    schedule_expression = "rate(1 minute)"
  }

  tags {
    service    = "my-service"
    component  = "this-lambda"
    managed_by = "terraform"
  }
}
