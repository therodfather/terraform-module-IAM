# terraform-modules-aws-iam

## Simple Example

```hcl
module "role" {
  source              = "../"
  name                = "my-example-role"
  namespace           = "examples"
  tags                = module.namespace.tags
  trust_policy        = data.aws_iam_policy_document.example_trust.json
  policy              = [
    data.aws_iam_policy_document.example.json
  ]
  additional_policies = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | A friendly name for this resource. | `string` | n/a | yes |
| namespace | A namespace for this resource. | `string` | n/a | yes |
| tags | Additional tags. | `map(string)` | n/a | yes |
| trust\_policy | Trust policy of the IAM role | `string` | n/a | yes |
| additional\_policies | Additional policy ARNs to attach to this role. Required if `policy` not defined. | `list(string)` | `[]` | no |
| policy | JSON of the IAM policy that will be attached to the role. Required if `additional_policies` not defined. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) specifying the role. |
| id | The identifier of the IAM role created. |
| name | The name of the IAM role created. |
| unique\_id | The stable and unique string identifying the role. |

