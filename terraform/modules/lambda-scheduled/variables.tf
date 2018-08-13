variable "function_name" {
    description = "A unique name for your Lambda Function."
}

variable "description" {
    description = "Description of what your Lambda Function does."
    default = ""
}

variable "s3_bucket" {
    description = "The S3 bucket location containing the function's deployment package. This bucket must reside in the same AWS region where you are creating the Lambda function."
}

variable "s3_key" {
    description = "The S3 key of an object containing the function's deployment package."
}

variable "timeout" {
    description = "The amount of time your Lambda Function has to run in seconds. Defaults to 3."
    default = 3
}

variable "runtime" {
    description = "The runtime environment for the Lambda function you are uploading. Defaults to go1.x"
    default = "go1.x"
}

variable "memory_size" {
    description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128."
    default = 128
}

variable "handler" {
    description = "The function entrypoint in your code."
}

variable "schedule_expression" {
    description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)."
}

variable "log_retention_in_days" {
    description = "Specifies the number of days you want to retain log events in the specified log group. Defaults to 14."
    default = 14
}