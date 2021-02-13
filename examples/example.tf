provider "aws" {
  region = var.region
}

module "namespace" {
  source              = "../"
  application_name    = "testing123"
  service_name        = "examples"
  workspace           = terraform.workspace
  application_id      = "123456"
  data_classification = "Public"
  owner               = "example"
  scm_branch          = var.scm_branch
  scm_commit_id       = var.scm_commit_id
  scm_project         = var.scm_project
  scm_repo            = var.scm_repo
  issrcl_level        = "Low"
  environment         = var.environment
  additional_tags = {
    "Release_Ref" = "555555555",
    "Yes"      = "Success"
  }
}

data "aws_iam_policy_document" "example" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeInstanceStatus"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "example_trust" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

module "example_iam_role" {
  source       = "../"
  name         = "my-example-role"
  namespace    = "examples"
  tags         = module.namespace.tags
  trust_policy = data.aws_iam_policy_document.example_trust.json
  policy = [
    data.aws_iam_policy_document.example.json
  ]
  additional_policies = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
  ]
}
