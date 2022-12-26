variable "create" {
  type    = bool
  default = true
}

variable "create_log_group" {
  type    = bool
  default = true
}

variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "network_mode" {
  type    = string
  default = "awsvpc"
}

variable "requires_compatibilities" {
  type    = list(any)
  default = ["FARGATE"]
}

variable "container_cpu" {
  type = number
}

variable "container_memory" {
  type = number
}

variable "execution_role_arn" {
  type    = string
  default = ""
}

variable "task_role_arn" {
  type    = string
  default = ""
}

variable "container_definitions" {
  type = string
}

variable "log_retantion_period" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(any)
  default = {}
}

#### execution ####

variable "task_execution_role_name" {
  type = string
  default = ""
}
variable "task_execution_role_requires_mfa" {
  type = bool
  default = false
}
variable "task_execution_create_role" {
  type = bool
  default = false
}
variable "task_execution_trusted_role_services" {
  type = list(any)
  default = []
}

variable "task_execution_custom_role_policy_arns" {
  type = list(any)
  default = []
}

variable "task_execution_policies_create" {
  type = bool
  default = false
}

variable "task_execution_policies" {
  type = map(any)
  default = {}
}

#### task ####
variable "task_role_name" {
  type = string
  default = ""
}
variable "task_role_requires_mfa" {
  type = bool
  default = false
}
variable "task_create_role" {
  type = bool
  default = false
}
variable "task_trusted_role_services" {
  type = list(any)
  default = []
}

variable "task_custom_role_policy_arns" {
  type = list(any)
  default = []
}

variable "task_policies_create" {
  type    = bool
  default = false
}

variable "task_policies" {
  type    = map(any)
  default = {}
}
