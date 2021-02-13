output "name" {
  value       = aws_iam_role.default.name
  description = "The name of the IAM role created."
}

output "id" {
  value       = aws_iam_role.default.name
  description = "The identifier of the IAM role created."
}

output "unique_id" {
  value       = aws_iam_role.default.unique_id
  description = "The stable and unique string identifying the role."
}

output "arn" {
  value       = aws_iam_role.default.arn
  description = "The Amazon Resource Name (ARN) specifying the role."
}
