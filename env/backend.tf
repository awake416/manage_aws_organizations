terraform {
  backend remote {
    hostname = "app.terraform.io"
    organization = "awake416"

    workspaces {
      name = "manage_aws_organization_workspace_setup"
    }
  }
}

provider tfe {
}