variable "supported_type" {
  description = "a supported ebs optimized type"
  type        = string
  default     = "m1.large"
}

variable "unsupported_type" {
  description = "an unsupported ebs optimized type"
  type        = string
  default     = "c1.medium"
}
