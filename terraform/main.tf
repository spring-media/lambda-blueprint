module "lambda" {
  source        = "github.com/spring-media/terraform-aws//lambda"
  name          = "scheduled"
  function_name = "lambda-blueprint-scheduled-fct"
  s3_bucket     = "${var.s3_bucket}"
  s3_key        = "${var.version}/scheduled.zip"
}

module "lambda-http" {
  source              = "github.com/spring-media/terraform-aws//lambda"
  name                = "http"
  function_name       = "lambda-mzimmer-http-fct"
  s3_bucket           = "${var.s3_bucket}"
  s3_key              = "${var.version}/http.zip"
  schedule_expression = "rate(1 minute)"
}
