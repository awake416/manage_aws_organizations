locals {
  enable = var.enable ? 1 : 0
  environments = [
  for pair in setproduct(var.functional_ous, var.environment_ous): {
    functional_ou = pair[0]
    env_ou = pair[1]
    parent_id = aws_organizations_organizational_unit.functional_ous[pair[0]].id
  }
  ]
  account_details = {
  for key, email in var.email_ids: key => {
    email_id: email,
    parent_id: aws_organizations_organizational_unit.environment_ous[key].id
  }
  }

  # TODO - calc tags
  account_tags = var.account_tags
}

