terraform {
  source = "../../..//modules/groups"
}


include   "root" {
  path = find_in_parent_folders()
}

