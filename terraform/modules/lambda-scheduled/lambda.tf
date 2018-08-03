resource "aws_lambda_function" "lambda" {
    function_name    = "${var.function_name}"
    count            = "${var.enabled}"
  
    filename         = "${var.filename}"
    source_code_hash = "${var.source_code_hash}"

    runtime          = "${var.runtime}"
    handler          = "${var.handler}"
    timeout          = "${var.timeout}"
    memory_size      = "${var.memory_size}"

    role             = "${aws_iam_role.lambda.arn}"
}
