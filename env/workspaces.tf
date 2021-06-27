variable shared_cred_file {default=""} # I liked it for local testing
variable "functional_ous" {}
variable "environment_ous" {}
variable "account_email_ids" {}
variable "oauth_token_id" {}
variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

module manage_workspaces {
  source  = "app.terraform.io/awake416/manage_workspaces/tfe"
  version = "0.0.2"
//    source = "../../../manage_workspaces/"

  env = "dev"
  prefix = "manage_aws_organizations"
  oauth_token_id = var.oauth_token_id
  aws_access_key_id = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
}

resource tfe_variable functional_ous {
  hcl = true
  key = "functional_ous"
  value = jsonencode(var.functional_ous)
  category = "terraform"
  description = "List of functional OUs"
  workspace_id = module.manage_workspaces.workspace_id
}

resource tfe_variable environment_ous {
  hcl = true
  key = "environment_ous"
  value = jsonencode(var.environment_ous)
  category = "terraform"
  description = "List of environment OUs"
  workspace_id = module.manage_workspaces.workspace_id
}

resource tfe_variable account_email_ids {
  hcl = true
  key = "account_email_ids"
  value = join("", ["{", join(",", [for key, value in var.account_email_ids : "${key}=\"${value}\""]), "}"])
  category = "terraform"
  description = "List of email_ids for accounts to be created"
  workspace_id = module.manage_workspaces.workspace_id
}