locals {
  role_policy_arns = var.create_policies ? concat(var.role_policy_arns, module.policies[0].list_of_policy_arns) : var.role_policy_arns
}

module "iam_role_oidc" {
  count  = var.create_role ? 1 : 0
  source = "github.com/bee7ch7/aws/iam/iam-assumable-role-with-oidc"

  create_role      = var.create_role
  role_name        = var.role_name
  role_policy_arns = local.role_policy_arns

  provider_url                  = var.provider_url
  oidc_fully_qualified_subjects = var.oidc_fully_qualified_subjects

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
