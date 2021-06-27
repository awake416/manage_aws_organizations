
resource aws_organizations_organizational_unit functional_ous {
  for_each = toset(var.functional_ous)
  name = each.key
  parent_id = var.root_parent_id
}

resource aws_organizations_organizational_unit environment_ous {
  for_each = {
    for item in local.environments : "${item.functional_ou}-${item.env_ou}" => item
  }
  name = each.key
  parent_id = each.value.parent_id
  depends_on = [aws_organizations_organizational_unit.functional_ous]
}

resource aws_organizations_account accounts {
  for_each = local.account_details
  name = each.key
  email = each.value.email_id
  iam_user_access_to_billing = var.allow_billing_access
  role_name = var.org_master_role
  parent_id = each.value.parent_id
  tags = local.account_tags
  depends_on = [aws_organizations_organizational_unit.environment_ous]
}

output functional_ou {
  value = aws_organizations_organizational_unit.functional_ous
}

output environment_ous {
  value = aws_organizations_organizational_unit.environment_ous
}

output accounts {
  value = aws_organizations_account.accounts
}