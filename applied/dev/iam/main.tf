resource "aws_iam_user" "my_users" {
  for_each = local.users
  name     = each.key
}

resource "aws_iam_user_policy_attachment" "my_users" {
  for_each   = local.users
  user       = aws_iam_user.my_users[each.key].name
  policy_arn = each.value
}

resource "aws_iam_group" "my_groups" {
  for_each = local.managed_policies
  name     = each.key
}

resource "aws_iam_group_policy_attachment" "my_groups_attachment" {
  for_each   = local.managed_policies
  group      = aws_iam_group.my_groups[each.key].name
  policy_arn = each.value
}

resource "aws_iam_group_policy" "groups_inline_policy" {
  for_each = local.inline_policies
  name     = "my-inline-policy"
  group    = aws_iam_group.my_groups[each.key].name
  policy   = each.value
}
