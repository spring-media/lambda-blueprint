variable "aws_region" {
    default = "eu-central-1"
}

variable "function_name" {}

variable "enabled" {
    default = true
}

variable "timeout" {
    description = "Timeout in seconds"
    default = 3
}

variable "runtime" {
    default = "go1.x"
}

variable "memory_size" {
  default = 128
}

variable "handler" {}

variable "schedule_expression" {}

variable "source_code_hash" {}

variable "filename" {}

