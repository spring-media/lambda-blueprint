resource "aws_lambda_function" "lambda" {
  function_name = "${var.function_name}"
  description   = "${var.description}"

  s3_bucket = "${var.s3_bucket}"
  s3_key    = "${var.s3_key}"

  role        = "${aws_iam_role.lambda.arn}"
  runtime     = "${var.runtime}"
  handler     = "${var.handler}"
  timeout     = "${var.timeout}"
  memory_size = "${var.memory_size}"
}

resource "aws_iam_role" "lambda" {
  name = "${var.function_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cloudwatch-logs-policy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cloudwatch-logs-policy-attachment" {
  role       = "${aws_iam_role.lambda.name}"
  policy_arn = "${aws_iam_policy.cloudwatch-logs-policy.arn}"
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = "${var.log_retention_in_days}"
}

resource "aws_lambda_permission" "cloudwatch" {
  count         = "${var.schedule_expression != "" ? 1 : 0}"
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.arn}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.lambda.arn}"
}

resource "aws_cloudwatch_event_rule" "lambda" {
  count               = "${var.schedule_expression != "" ? 1 : 0}"
  name                = "${var.function_name}"
  schedule_expression = "${var.schedule_expression}"
}

resource "aws_cloudwatch_event_target" "lambda" {
  count     = "${var.schedule_expression != "" ? 1 : 0}"
  target_id = "${var.function_name}"
  rule      = "${aws_cloudwatch_event_rule.lambda.name}"
  arn       = "${aws_lambda_function.lambda.arn}"
}
