resource "aws_lambda_function" "lambda" {
    function_name = "${var.function_name}"
    count         = "${var.enabled}"
  
    s3_bucket     = "${var.s3_bucket}"
    s3_key        = "${var.s3_key}"

    role          = "${aws_iam_role.lambda.arn}"
    runtime       = "${var.runtime}"
    handler       = "${var.handler}"
    timeout       = "${var.timeout}"
    memory_size   = "${var.memory_size}"

}
