# manage_aws_organizations
This repo is used to manage aws organizations. This can create and add new accounts to org. Master account needs to be created manually.

We want to keep the environments variables in the form of tfvars in the same repo and we do not want to maintain the workspaces manually.

The approach we have taken here is to keep all the environment specific variables in same repo per environment like /env/dev/variables.tfvars.

Then use a module which wraps tfe details to provision the required workspace. 
