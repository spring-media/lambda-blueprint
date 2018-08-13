output "function_name" {
  description = "The unique name of your Lambda Function."
  value = "${aws_lambda_function.lambda.*.function_name}"
}

output "function_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
  value = "${aws_lambda_function.lambda.*.arn}"
}