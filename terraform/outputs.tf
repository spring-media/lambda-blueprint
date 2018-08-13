output "function_name" {
  description = "The unique name of your Lambda Function."
  value = "${module.lambda-scheduled.function_name}"
}
output "function_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
  value = "${module.lambda-scheduled.function_arn}"
}