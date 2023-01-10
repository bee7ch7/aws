variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = false
}

variable "provider_url" {
  description = "URL of the OIDC Provider. Use provider_urls to specify several URLs."
  type        = string
  default     = ""
}

variable "provider_urls" {
  description = "List of URLs of the OIDC Providers"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}

variable "role_name" {
  description = "IAM role name"
  type        = string
  default     = null
}

variable "oidc_fully_qualified_subjects" {
  description = "The fully qualified OIDC subjects to be added to the role policy"
  type        = set(string)
  default     = []
}

variable "create_policies" {
  type    = bool
  default = false
}
variable "policies" {
  type    = map(any)
  default = {}
}

