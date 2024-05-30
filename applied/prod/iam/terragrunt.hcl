terraform {
  source = "../../../..//infrastructure/region/iam"
}


include   "root" {
  path = find_in_parent_folders()
}