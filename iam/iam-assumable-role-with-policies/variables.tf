variable "role_arn" {
  description = "value"
  type        = string
  default     = ""
}

variable "create_role" {
  description = "value"
  type        = string
  default     = true
}

variable "role_name" {
  description = "value"
  type        = string
  default     = ""
}

variable "role_requires_mfa" {
  description = "value"
  type        = bool
  default     = false
}

variable "trusted_role_services" {
  description = "value"
  type        = list(any)
  default     = []
}

variable "create_policies" {
  description = "value"
  type        = bool
  default     = false
}

variable "custom_role_policy_arns" {
  description = "value"
  type        = list(any)
  default     = []
}

variable "policies" {
  description = "value"
  type        = map(any)
  default     = {}
}

variable "tags" {
  description = "value"
  type        = map(any)
  default     = {}
}
