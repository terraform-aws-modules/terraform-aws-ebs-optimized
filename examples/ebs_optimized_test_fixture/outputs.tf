output "supported" {
  description = "Answer for a known supported type."
  value       = "${module.supported_ebs.answer}"
}

output "unsupported" {
  description = "Answer for a known unsupported type."
  value       = "${module.unsupported_ebs.answer}"
}

output "unknown" {
  description = "Answer for an unknown type."
  value       = "${module.unknown_type.answer}"
}

output "ebs_optimized_instance_id" {
  description = "ebs optimized EC2 instance ID."
  value       = "${aws_instance.ebs_optimized.id}"
}

output "not_ebs_optimized_instance_id" {
  description = "ebs optimized EC2 instance ID."
  value       = "${aws_instance.ebs_not_optimized.id}"
}
