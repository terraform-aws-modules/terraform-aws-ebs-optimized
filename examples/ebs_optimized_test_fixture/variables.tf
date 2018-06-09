variable "supported_type" {
  description = "a supported ebs optimized type."
  default     = "m1.large"
}

variable "unsupported_type" {
  description = "an unsupported ebs optimized type."
  default     = "c1.medium"
}
