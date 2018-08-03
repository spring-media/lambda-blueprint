variable "function_name" {}

variable "s3_bucket" {}

variable "s3_key" {}

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