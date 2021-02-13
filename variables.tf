variable "name" {
  type        = string
  description = "A friendly name for this resource."
}

variable "namespace" {
  type        = string
  description = "A namespace for this resource."
}

variable "policy" {
  type        = list(string)
  description = "JSON of the IAM policy that will be attached to the role. Required if `additional_policies` not defined."
  default     = []
}

variable "trust_policy" {
  type        = string
  description = "Trust policy of the IAM role"
}

variable "additional_policies" {
  type        = list(string)
  description = "Additional policy ARNs to attach to this role. Required if `policy` not defined."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
}