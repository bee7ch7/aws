output "policy_id" {
  value = { for k, v in aws_iam_policy.this : k => v.id }
}

output "policy_arn" {
  value = { for k, v in aws_iam_policy.this : k => v.arn }
}

output "policy_name" {
  value = { for k, v in aws_iam_policy.this : k => v.name }
}

# output "policy" {
#   value = { for k, v in aws_iam_policy.this : k => v.policy }
# }
