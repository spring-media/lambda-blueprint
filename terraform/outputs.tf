output "functions" {
  value = "${module.lambda-scheduled.functions}"
}
output "arn" {
  value = "${module.lambda-scheduled.arn}"
}