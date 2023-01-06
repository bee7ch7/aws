# variable "create_policy" {
#   description = "Whether to create the IAM policy"
#   type        = bool
#   default     = true
# }

# variable "name" {
#   description = "The name of the policy"
#   type        = string
#   default     = ""
# }

# variable "path" {
#   description = "The path of the policy in IAM"
#   type        = string
#   default     = "/"
# }

# variable "description" {
#   description = "The description of the policy"
#   type        = string
#   default     = "IAM Policy"
# }

# variable "policy" {
#   description = "The path of the policy in IAM (tpl file)"
#   type        = string
#   default     = ""
# }

# variable "tags" { ##############
#   description = "A map of tags to add to all resources." ####### dev 777
#   type        = map(string) ############## dev 777
#   default     = {} ############ dev 777y feature-frest
# }

variable "policies" {
  type = map(any)
}
