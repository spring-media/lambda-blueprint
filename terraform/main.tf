module "lambda" {
  source        = "./modules/lambda"
  name          = "lambda"
  description   = "Example Lambda with API Gateway event."
  function_name = "lambda-blueprint-fct"
  handler       = "api"
  s3_bucket     = "${var.s3_bucket}"
  s3_key        = "${var.version}/api.zip"
}

module "api" {
  source            = "./modules/api"
  name              = "Lambda-Blueprint-Example"
  stage_name        = "test"
  lambda_arn        = "${module.lambda.arn}"
  lambda_invoke_arn = "${module.lambda.invoke_arn}"
}
