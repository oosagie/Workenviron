terraform {
  source = "../../../..//modules/oicd_worker"
}

include   "root" {
  path = find_in_parent_folders()
}

inputs = {
    proxy_role = "github_action_proxy"
    account_id = "590183935495"
    worker_role = "github_action_worker"
    worker_role_policy_name = "github_action_worker_policy"
}