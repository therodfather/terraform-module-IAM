data "aws_region" "this" {}
data "aws_caller_identity" "this" {}

locals {
  account_id = data.aws_caller_identity.this.account_id
  region     = data.aws_region.this.name
  namespace  = "${var.namespace}-${var.name}"
}

resource "aws_iam_role" "default" {
  name                 = local.namespace
  assume_role_policy   = var.trust_policy
  permissions_boundary = "arn:aws:iam::${local.account_id}:policy/CloudCoreL3Permissions"
  tags                 = var.tags
}

resource "aws_iam_policy" "policy" {
  count       = length(var.policy)
  name        = local.namespace
  description = "Standardized IAM policy generated for ${local.namespace}"
  policy      = var.policy[count.index]
}

resource "aws_iam_role_policy_attachment" "attach_defined" {
  count      = length(var.policy)
  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.policy[count.index].arn
}

resource "aws_iam_role_policy_attachment" "attach_additional" {
  count      = length(var.additional_policies)
  role       = aws_iam_role.default.name
  policy_arn = element(var.additional_policies, count.index)
}