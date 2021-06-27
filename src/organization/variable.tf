variable enable {
  type = bool
  default = true
}

variable functional_ous {
  description = "List of OUs to be created under root parent"
  type = list(string)
}

variable root_parent_id {
  description = "Id of root ou from organization"
  type = string
}

variable environment_ous {
  description = "These OUs shall keep actual account in them and shall be created in each of funtional OUs"
  type = list(string)
}

variable allow_billing_access {
  description = "The new account enables IAM users to access account billing information"
  default = "ALLOW"
}

variable "org_master_role" {
  description = "The name of an IAM role that Organizations automatically preconfigures in the new member account"
  default = "org_master_role"
}

variable email_ids {
  description = "A map of email ids for each combination of accounts"
  type = map(string)
}

variable account_tags {
  default = {}
}