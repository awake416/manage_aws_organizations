# TAGS can be used for ABAC and there is some work that needs to be done

# we do not want to allow users to input these values
locals {
  mandatory_tags = {
    costCenter = ["sme", "consumer"]
    project = ["consumer-lab", "consumer-backend"]
  }

  mandatory_template = {
    "tags": {for key, value in local.mandatory_tags: key => {
      tag_key = {
        "@@operators_allowed_for_child_policies": ["@@none"],
        "@@assign": key
      },
      tag_value = {
        "@@operators_allowed_for_child_policies": ["@@append"],
        "@@assign": value
      }
    }}
  }
}

resource aws_organizations_policy tag_policy_mandatory {
  type = "TAG_POLICY"
  content = jsonencode(local.mandatory_template)
  name = "mandatory_tags"
}

resource aws_organizations_policy_attachment mandatory_policy {
  policy_id = aws_organizations_policy.tag_policy_mandatory.id
  target_id = var.root_parent_id
}