resource "aws_organizations_policy" "ScpPolicy1" {
  name = "scp_whitelist_region"
  description = "This SCP denies access to any operations outside of the specified AWS Region, except for actions in the listed services (These are global services that cannot be whitelisted based on region). "
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "NotAction": [
        "a4b:*",
        "acm:*",
        "aws-marketplace-management:*",
        "aws-marketplace:*",
        "aws-portal:*",
        "awsbillingconsole:*",
        "budgets:*",
        "ce:*",
        "chime:*",
        "cloudfront:*",
        "config:*",
        "cur:*",
        "directconnect:*",
        "ec2:DescribeRegions",
        "ec2:DescribeTransitGateways",
        "ec2:DescribeVpnGateways",
        "fms:*",
        "globalaccelerator:*",
        "health:*",
        "iam:*",
        "importexport:*",
        "kms:*",
        "mobileanalytics:*",
        "networkmanager:*",
        "organizations:*",
        "pricing:*",
        "route53:*",
        "route53domains:*",
        "s3:GetAccountPublic*",
        "s3:ListAllMyBuckets",
        "s3:PutAccountPublic*",
        "shield:*",
        "sts:*",
        "support:*",
        "trustedadvisor:*",
        "waf-regional:*",
        "waf:*",
        "wafv2:*",
        "wellarchitected:*"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotEquals": {
          "aws:RequestedRegion": [
            "ap-south-1",
            "us-east-1",
            "ap-southeast-1"
          ]
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy2" {
  name = "scp_root_account"
  description = "This SCP prevents restricts the root user in an AWS account from taking any action, either directly as a command or through the console. "
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:root"
          ]
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy3" {
  name = "scp_cloudtrail"
  description = "This SCP prevents users or roles in any affected account from disabling a CloudTrail log, either directly as a command or through the console. "
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudtrail:StopLogging",
        "cloudtrail:DeleteTrail"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role"
          ]
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy4" {
  name = "scp_config"
  description = "This SCP prevents users or roles in any affected account from running AWS Config operations that could disable AWS Config or alter its rules or triggers. "
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "config:DeleteConfigRule",
        "config:DeleteConfigurationRecorder",
        "config:DeleteDeliveryChannel",
        "config:StopConfigurationRecorder"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role"
          ]
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy5" {
  name = "scp_guardduty"
  description = "This SCP prevents users or roles in any affected account from disabling or modifying Amazon GuardDuty settings, either directly as a command or through the console. "
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "guardduty:DeleteDetector",
        "guardduty:DeleteInvitations",
        "guardduty:DeleteIPSet",
        "guardduty:DeleteMembers",
        "guardduty:DeleteThreatIntelSet",
        "guardduty:DisassociateFromMasterAccount",
        "guardduty:DisassociateMembers",
        "guardduty:StopMonitoringMembers",
        "guardduty:UpdateDetector"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role"
          ]
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy6" {
  name = "scp_securityhub"
  description = "This SCP prevents users or roles in any affected account from disabling AWS Security Hub, deleting member accounts or disassociating an account from a master Security Hub account."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "securityhub:DeleteInvitations",
        "securityhub:DisableSecurityHub",
        "securityhub:DisassociateFromMasterAccount",
        "securityhub:DeleteMembers",
        "securityhub:DisassociateMembers"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role"
          ]
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy7" {
  name = "scp_accessanalyzer"
  description = "This SCP prevents users or roles in any affected account from deleting AWS Access Analyzer in an AWS account."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "access-analyzer:DeleteAnalyzer"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role"
          ]
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy8" {
  name = "scp_igw"
  description = "This SCP prevents users or roles in any affected account from changing the configuration of your Amazon EC2 virtual private clouds (VPCs) to grant them direct access to the internet. It doesn't block existing direct access or any access that routes through your on-premises network environment. "
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:AttachInternetGateway",
        "ec2:CreateInternetGateway",
        "ec2:AttachEgressOnlyInternetGateway",
        "ec2:CreateVpcPeeringConnection",
        "ec2:AcceptVpcPeeringConnection"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role"
          ]
        }
      }
    },
    {
      "Action": [
        "globalaccelerator:Create*",
        "globalaccelerator:Update*"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role"
          ]
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy9" {
  name = "scp_organizations"
  description = "This SCP prevents users or roles in any affected account from leaving AWS Organizations, either directly as a command or through the console. "
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "organizations:LeaveOrganization"
      ],
      "Resource": "*",
      "Effect": "Deny"
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy10" {
  name = "scp_account_billing"
  description = "This SCP prevents users or roles in any affected account from modifying the account and billing settings, either directly as a command or through the console."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "aws-portal:ModifyAccount",
        "aws-portal:ModifyBilling",
        "aws-portal:ModifyPaymentMethods"
      ],
      "Resource": "*",
      "Effect": "Deny"
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy11" {
  name = "scp_deny_iam_user_creation"
  description = "This SCP restricts IAM principals from creating new IAM users or IAM Access Keys in an AWS account."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:CreateUser",
        "iam:CreateAccessKey"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role"
          ]
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy12" {
  name = "scp_s3_block_public_access"
  description = "This SCP prevents users or roles in any affected account from modifying the S3 Block Public Access Account Level Settings"
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutAccountPublicAccessBlock"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role",
            "arn:aws:iam::*:app/app_admin"
          ]
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy13" {
  name = "scp_s3_encryption"
  description = "This SCP requires that all Amazon S3 buckets use AES256 encryption in an AWS Account. "
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotEquals": {
          "s3:x-amz-server-side-encryption": "AES256"
        }
      }
    },
    {
      "Action": [
        "s3:PutObject"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "Bool": {
          "s3:x-amz-server-side-encryption": false
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy14" {
  name = "scp_flowlogs"
  description = "This SCP prevents users or roles in any affected account from deleting Amazon EC2 flow logs or CloudWatch log groups or log streams. "
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DeleteFlowLogs",
        "logs:DeleteLogGroup",
        "logs:DeleteLogStream"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role",
            "arn:aws:iam::*:app/app_admin"
          ]
        }
      }
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy15" {
  name = "scp_vpc_connectivity"
  description = "This SCP restricts IAM principals in an AWS account from changing creating, updating or deleting settings for Internet Gateways, NAT Gateways, VPC Peering, VPN Gateways, Client VPNs, Direct Connect and Global Accelerator."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:CreateNatGateway",
        "ec2:CreateInternetGateway",
        "ec2:DeleteNatGateway",
        "ec2:AttachInternetGateway",
        "ec2:DeleteInternetGateway",
        "ec2:DetachInternetGateway",
        "ec2:CreateClientVpnRoute",
        "ec2:AttachVpnGateway",
        "ec2:DisassociateClientVpnTargetNetwork",
        "ec2:DeleteClientVpnEndpoint",
        "ec2:DeleteVpcPeeringConnection",
        "ec2:AcceptVpcPeeringConnection",
        "ec2:CreateNatGateway",
        "ec2:ModifyClientVpnEndpoint",
        "ec2:CreateVpnConnectionRoute",
        "ec2:RevokeClientVpnIngress",
        "ec2:RejectVpcPeeringConnection",
        "ec2:DetachVpnGateway",
        "ec2:DeleteVpnConnectionRoute",
        "ec2:CreateClientVpnEndpoint",
        "ec2:AuthorizeClientVpnIngress",
        "ec2:DeleteVpnGateway",
        "ec2:TerminateClientVpnConnections",
        "ec2:DeleteClientVpnRoute",
        "ec2:ModifyVpcPeeringConnectionOptions",
        "ec2:CreateVpnGateway",
        "ec2:DeleteNatGateway",
        "ec2:DeleteVpnConnection",
        "ec2:CreateVpcPeeringConnection",
        "ec2:CreateVpnConnection"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role"
          ]
        }
      }
    },
    {
      "Action": [
        "directconnect:CreatePrivateVirtualInterface",
        "directconnect:DeleteBGPPeer",
        "directconnect:DeleteLag",
        "directconnect:AssociateHostedConnection",
        "directconnect:CreateInterconnect",
        "directconnect:CreatePublicVirtualInterface",
        "directconnect:CreateLag",
        "directconnect:CreateDirectConnectGateway",
        "directconnect:AssociateVirtualInterface",
        "directconnect:AllocateConnectionOnInterconnect",
        "directconnect:AssociateConnectionWithLag",
        "directconnect:AllocatePrivateVirtualInterface",
        "directconnect:DeleteInterconnect",
        "directconnect:AllocateHostedConnection",
        "directconnect:DeleteDirectConnectGateway",
        "directconnect:DeleteVirtualInterface",
        "directconnect:DeleteDirectConnectGatewayAssociation",
        "directconnect:CreateDirectConnectGatewayAssociation",
        "directconnect:DeleteConnection",
        "directconnect:CreateBGPPeer",
        "directconnect:AllocatePublicVirtualInterface",
        "directconnect:CreateConnection"
      ],
      "Resource": "*",
      "Effect": "Deny"
    },
    {
      "Action": [
        "globalaccelerator:DeleteListener",
        "globalaccelerator:DeleteAccelerator",
        "globalaccelerator:UpdateListener",
        "globalaccelerator:UpdateAccelerator",
        "globalaccelerator:CreateEndpointGroup",
        "globalaccelerator:UpdateAcceleratorAttributes",
        "globalaccelerator:UpdateEndpointGroup",
        "globalaccelerator:CreateListener",
        "globalaccelerator:CreateAccelerator",
        "globalaccelerator:DeleteEndpointGroup"
      ],
      "Resource": "*",
      "Effect": "Deny"
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy16" {
  name = "scp_protect_iam_principal"
  description = "This SCP restricts IAM principals in accounts from making changes to an IAM role created in an AWS account (This could be a common administrative IAM role created in all accounts in your organization). "
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:AttachRolePolicy",
        "iam:DeleteRole",
        "iam:DeleteRolePermissionsBoundary",
        "iam:DeleteRolePolicy",
        "iam:DetachRolePolicy",
        "iam:PutRolePermissionsBoundary",
        "iam:PutRolePolicy",
        "iam:UpdateAssumeRolePolicy",
        "iam:UpdateRole",
        "iam:UpdateRoleDescription"
      ],
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:infra/infra_admin",
            "arn:aws:iam::*:infra/org_master_role",
            "arn:aws:iam::*:app/app_admin"
          ]
        }
      }
    }
  ]
}
POLICY

}