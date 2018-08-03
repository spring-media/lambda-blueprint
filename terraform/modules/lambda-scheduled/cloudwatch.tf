resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = 14
}

resource "aws_lambda_permission" "cloudwatch" {
    statement_id  = "AllowExecutionFromCloudWatch"
    action        = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.lambda.arn}"
    principal     = "events.amazonaws.com"
    source_arn    = "${aws_cloudwatch_event_rule.lambda.arn}"
    count         = "${var.enabled}"
}

resource "aws_cloudwatch_event_rule" "lambda" {
    name                = "${var.function_name}"
    schedule_expression = "${var.schedule_expression}"
    count               = "${var.enabled}"
}

resource "aws_cloudwatch_event_target" "lambda" {
    target_id = "${var.function_name}"
    rule      = "${aws_cloudwatch_event_rule.lambda.name}"
    arn       = "${aws_lambda_function.lambda.arn}"
    count     = "${var.enabled}"
}
