module "api-lambda" {
  source        = "github.com/spring-media/terraform-aws-lambda"
  name          = "api-lambda"
  description   = "Example Lambda with API Gateway event."
  function_name = "lambda-blueprint-fct"
  handler       = "api"
  s3_bucket     = "${var.s3_bucket}"
  s3_key        = "${var.version}/api.zip"
}

module "api" {
  source            = "github.com/spring-media/terraform-aws-api-gateway"
  name              = "Lambda-Blueprint-Example"
  stage_name        = "test"
  lambda_arn        = "${module.lambda.arn}"
  lambda_invoke_arn = "${module.lambda.invoke_arn}"
}

module "lambda" {
  source                  = "github.com/spring-media/terraform-aws-lambda"
  name                    = "lambda"
  description             = "Example Lambda with a stream event source mapping."
  function_name           = "lambda-blueprint-stream-fct"
  handler                 = "dynamodb"
  s3_bucket               = "${var.s3_bucket}"
  s3_key                  = "${var.version}/dynamodb.zip"
  stream_enabled          = true
  stream_event_source_arn = "${aws_dynamodb_table.dynamodb.stream_arn}"
}

module "scheduled-lambda" {
  source              = "github.com/spring-media/terraform-aws-lambda"
  name                = "scheduled-lambda"
  function_name       = "my-scheduled-function"
  handler             = "my-handler"
  s3_bucket           = "some-s3-bucket"
  s3_key              = "some-s3-key"
  schedule_expression = "rate(1 minute)"
}

resource "aws_dynamodb_table" "dynamodb" {
  name             = "example-stream-enabled-table"
  read_capacity    = 5
  write_capacity   = 5
  hash_key         = "id"
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"

  attribute = {
    name = "id"
    type = "S"
  }
}
