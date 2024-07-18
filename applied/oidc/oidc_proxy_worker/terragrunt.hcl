terraform {
  source = "../../../..//modules/oidc_proxy_backend"
}


include   "root" {
  path = find_in_parent_folders()
}