terraform {
  source = "../../../..//infrastructure/iam_group"
}


include   "root" {
  path = find_in_parent_folders()
}
