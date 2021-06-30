locals {
  dev_accounts = []
}
resource aws_organizations_policy_attachment dev {
  count = 0
  policy_id = ""
  target_id = ""
}