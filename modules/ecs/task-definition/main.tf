locals {
  task_execution_role               = length(var.execution_role_arn) > 0 ? var.execution_role_arn : var.task_execution_create_role ? module.task_execution_role[0].iam_role_arn : ""
  execution_custom_role_policy_arns = length(var.task_execution_custom_role_policy_arns) > 0 ? var.task_execution_custom_role_policy_arns : var.task_execution_policies_create ? module.task_execution_policies[0].list_of_policy_arns : []
  
  task_role                    = length(var.task_role_arn) > 0 ? var.task_role_arn : var.task_create_role ? module.task_role[0].iam_role_arn : ""
  task_custom_role_policy_arns = length(var.task_custom_role_policy_arns) > 0 ? var.task_custom_role_policy_arns : var.task_policies_create ? module.task_policies[0].list_of_policy_arns : []
  
}

resource "aws_ecs_task_definition" "this" {
  count                    = var.create ? 1 : 0
  family                   = "${var.name}-task-${var.environment}"
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  execution_role_arn       = local.task_execution_role
  task_role_arn            = local.task_role
  container_definitions    = var.container_definitions

  tags = var.tags

  lifecycle {
    ignore_changes = [
      container_definitions
    ]
  }

  depends_on = [
    module.task_execution_role
  ]
}
resource "aws_cloudwatch_log_group" "this" {
  count             = var.create_log_group ? 1 : 0
  name              = "/ecs/${var.name}-task-${var.environment}"
  retention_in_days = var.log_retantion_period

  tags = var.tags
}


module "task_execution_role" {
  count = var.task_execution_create_role ? 1 : 0
  source  = "github.com/bee7ch7/aws/iam/iam-assumable-role//."
  create_role = var.task_execution_create_role
  role_name = var.task_execution_role_name
  role_requires_mfa = var.task_execution_role_requires_mfa
  trusted_role_services = var.task_execution_trusted_role_services
  custom_role_policy_arns = local.execution_custom_role_policy_arns

  depends_on = [
    module.task_execution_policies
  ]
}

module "task_execution_policies" {
  count = var.task_execution_policies_create && length(var.task_execution_policies) > 0 ? 1 : 0
  source  = "github.com/bee7ch7/aws/iam/iam-policy//."
  policies = var.task_execution_policies
}

module "task_role" {
  count = var.task_create_role ? 1 : 0
  source  = "github.com/bee7ch7/aws/iam/iam-assumable-role//."
  create_role = var.task_create_role
  role_name = var.task_role_name
  role_requires_mfa = var.task_role_requires_mfa
  trusted_role_services = var.task_trusted_role_services
  custom_role_policy_arns = local.task_custom_role_policy_arns

  depends_on = [
    module.task_policies
  ]
}

module "task_policies" {
  count = var.task_policies_create && length(var.task_policies) > 0 ? 1 : 0
  source  = "github.com/bee7ch7/aws/iam/iam-policy//."
  policies = var.task_policies
}