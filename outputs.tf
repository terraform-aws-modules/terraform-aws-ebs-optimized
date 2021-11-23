output "answer" {
  description = "Returns 1 (true) or 0 (false) depending on if the instance type is able to be EBS optimized"
  value       = lookup(local.ebs_optimized, var.instance_type, 0)
}
