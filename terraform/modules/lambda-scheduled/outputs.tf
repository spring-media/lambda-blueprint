output "lambda_functions" {
  value = "${aws_lambda_function.lambda.*.function_name}"
}

output "lambda_arns" {
  value = "${aws_lambda_function.lambda.*.arn}"
}