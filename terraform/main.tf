module "lambda" {
  source        = "github.com/spring-media/terraform-aws//lambda"
  name          = "lambda"
  function_name = "lambda-blueprint-scheduled-fct"
  handler       = "scheduled"
  s3_bucket     = "${var.s3_bucket}"
  s3_key        = "${var.version}/scheduled.zip"
}
