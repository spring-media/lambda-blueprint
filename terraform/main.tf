module "lambda" {
  source              = "github.com/spring-media/terraform-aws-lambda"
  version             = ">= 1.2.0"
  name                = "scheduled"
  function_name       = "lambda-blueprint-scheduled-fct"
  s3_bucket           = "${var.s3_bucket}"
  s3_key              = "${var.version}/scheduled.zip"
  schedule_expression = "rate(1 minute)"

  tags {
    service    = "my-service"
    component  = "this-lambda"
    managed_by = "terraform"
  }
}
