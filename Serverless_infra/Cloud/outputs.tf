# -------------------------------------------------
# Copyright 2021 Device42, Inc.
# -------------------------------------------------

output "normalization_api_url" {
  value = module.cloud_infra.normalization_api_url
}

output "admin_api_url" {
  value = module.cloud_infra.admin_api_url
}

output "test_lambdas_url" {
  value = var.test_resource_flag ? module.test_lambdas[0].test_lambdas_url : ""
}