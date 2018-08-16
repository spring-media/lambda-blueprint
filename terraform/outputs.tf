output "function_name" {
  description = "The unique name of your Lambda Function."
  value       = "${module.lambda.function_name}"
}

output "arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
  value       = "${module.lambda.arn}"
}

output "invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri"
  value       = "${module.lambda.invoke_arn}"
}

output "invoke_url" {
  description = "The URL to invoke the API pointing to the stage, e.g. https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod"
  value       = "${module.api.invoke_url}"
}

output "stream_arn" {
  description = "The ARN of the DynamoDB table stream."
  value       = "${aws_dynamodb_table.dynamodb.stream_arn}"
}
