output "list_of_policy_arns" {
  description = "List of policies ARNs"
  value       = try(module.policies[0].list_of_policy_arns, [])
}

output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = try(module.iam_role_oidc[0].iam_role_arn, "")
}

output "iam_role_name" {
  description = "IAM eole name"
  value       = try(module.iam_role_oidc[0].iam_role_name, "")
}
