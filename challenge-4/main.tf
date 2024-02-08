data "aws_caller_identity" "current" {}

resource "aws_iam_user" "name" {
    name = "admin-user-${data.aws_caller_identity.current.account_id}"
}

data "aws_iam_users" "users" {}

output "users" {
    value = data.aws_iam_users.users.names
}

output "number_of_users" {
    value = length(data.aws_iam_users.users.names)
}