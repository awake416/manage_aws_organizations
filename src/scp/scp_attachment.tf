locals {
  dev_accounts = [for name, item in var.accounts : item.id if (length(regexall(".*dev", name)) > 0)]
  non_prod_accounts = [for name, item in var.accounts : item.id if (length(regexall(".*dev|.*prod", name))<0)]
  prod_accounts = [for name, item in var.accounts : item.id if (length(regexall(".*dev", name)) > 0)]

  common_policies = [
    aws_organizations_policy.ScpPolicy2.id,
    aws_organizations_policy.ScpPolicy3.id]
  dev_policies = {
  for pair in setproduct(local.common_policies, local.dev_accounts): "${pair[0]}-${pair[1]}" => {
    policy_id = pair[0]
    account_id = pair[1]
  }
  }

  non_prod_policies = {
  for pair in setproduct(local.common_policies, local.non_prod_accounts): "${pair[0]}-${pair[1]}" => {
    policy_id = pair[0]
    account_id = pair[1]
  }
  }

  prod_policies = {
  for pair in setproduct(local.common_policies, local.prod_accounts): "${pair[0]}-${pair[1]}" => {
    policy_id = pair[0]
    account_id = pair[1]
  }
  }

}

resource aws_organizations_policy_attachment dev {
  for_each = local.dev_policies
  policy_id = each.value.policy_id
  target_id = each.value.account_id
}

resource aws_organizations_policy_attachment non_prod {
  for_each = local.non_prod_policies
  policy_id = each.value.policy_id
  target_id = each.value.account_id
}

resource aws_organizations_policy_attachment prod {
  for_each = local.prod_policies
  policy_id = each.value.policy_id
  target_id = each.value.account_id
}