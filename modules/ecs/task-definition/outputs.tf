output "aws_ecs_task_definition_arn" {
  value = aws_ecs_task_definition.this[0].arn
}

output "aws_ecs_task_definition_log_group" {
  value = aws_cloudwatch_log_group.this[0].name
}

output "task_policies" {
  value = try(module.task_policies[0].list_of_policy_arns, [])
}

output "task_execution_policies" {
  value = try(module.task_execution_policies[0].list_of_policy_arns, [])
}

output "task_execution_iam_role_arn" {
  description = "ARN of IAM role"
  value       = try(module.task_execution_role[0].iam_role_arn, "")
}

output "task_iam_role_arn" {
  description = "ARN of IAM role"
  value       = try(module.task_role[0].iam_role_arn, "")
}

