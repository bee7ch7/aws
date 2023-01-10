locals {
  iam_role                = length(var.role_arn) > 0 ? var.role_arn : var.create_role ? module.iam_role[0].iam_role_arn : ""
  custom_role_policy_arns = var.create_policies ? concat(var.custom_role_policy_arns, module.policies[0].list_of_policy_arns) : var.custom_role_policy_arns
}


module "iam_role" {
  count                   = var.create_role ? 1 : 0
  source                  = "github.com/bee7ch7/aws/iam/iam-assumable-role//."
  create_role             = var.create_role
  role_name               = var.role_name
  role_requires_mfa       = var.role_requires_mfa
  trusted_role_services   = var.trusted_role_services
  custom_role_policy_arns = local.custom_role_policy_arns

  depends_on = [
    module.policies
  ]

  tags = var.tags
}

module "policies" {
  count    = var.create_policies && length(var.policies) > 0 ? 1 : 0
  source   = "github.com/bee7ch7/aws/iam/iam-policy//."
  policies = var.policies
}
