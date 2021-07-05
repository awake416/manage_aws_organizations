data aws_organizations_organization org {}

locals {
  root_parent_id = data.aws_organizations_organization.org.*.roots[0][0].id
  email_domain = "@gmail.com"
  email_ids = length(var.account_email_ids) != 0 ? var.account_email_ids : {
    for pair in setproduct(var.functional_ous, var.environment_ous): "${pair[0]}-${pair[1]}" => "${pair[0]}-${pair[1]}${local.email_domain}"
  }
}

module organization {
  source = "./src/organization"
  enable = true
  functional_ous = var.functional_ous
  root_parent_id = local.root_parent_id
  environment_ous = var.environment_ous
  email_ids = local.email_ids
}

# Policy types Supported by tf - AISERVICES_OPT_OUT_POLICY|BACKUP_POLICY|SERVICE_CONTROL_POLICY (DEFAULT)|TAG_POLICY
# We added support for tags and scp for now
module scps {
  source = "./src/scp"
  accounts = module.organization.accounts
  # TODO - add enable variable, fine for now
}

# while attaching SCPs, to accounts, we want to keep dev account relatively open for experimentation

module tagpolicies {
  source = "./src/tagpolicies"
  root_parent_id = local.root_parent_id
}

output root {
  value = local.root_parent_id
}

output functional_ou {
  value = module.organization.functional_ou
}

output environment_ous {
  value = module.organization.environment_ous
}

output accounts {
  value = module.organization.accounts
}

output dev_accounts {
  value = module.scps.dev_accounts
}

output dev_policy {
  value = module.scps.dev_polcies
}

output prod_accounts {
  value = module.scps.prod_accounts
}

output prod_policy {
  value = module.scps.prod_polcies
}