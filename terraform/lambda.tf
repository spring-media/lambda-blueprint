data "archive_file" "schedule-fct-zip" {
  type        = "zip"
  source_file = "${path.module}/../bin/schedule"
  output_path = "${path.module}/../bin/schedule.zip"
}

module "lambda-scheduled" {
  source              = "./modules/lambda-scheduled"
  
  function_name       = "lambda-blueprint-schedule-fct"
  handler             = "schedule"
  schedule_expression = "rate(1 minute)"

  filename            = "${path.module}/../bin/schedule.zip"
  source_code_hash    = "${data.archive_file.schedule-fct-zip.output_base64sha256}"
}