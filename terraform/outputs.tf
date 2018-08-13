output "lambda_functions" {
  value = "${module.lambda-scheduled.lambda_functions}"
}
output "lambda_arns" {
  value = "${module.lambda-scheduled.lambda_arns}"
}