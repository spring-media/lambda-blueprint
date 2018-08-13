module "lambda-scheduled" {
  source              = "./modules/lambda-scheduled"
  
  function_name       = "lambda-blueprint-schedule-fct"
  handler             = "schedule"
  schedule_expression = "rate(1 minute)"

  s3_bucket           = "${var.s3_bucket}"
  s3_key              = "${var.version}/schedule.zip"
}