# -------------------------------------------------
# Copyright 2021 Device42, Inc.
# -------------------------------------------------


provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  default_tags {
    tags = {
      Owner        = "Device42"
      Project      = "SaaS Data Normalization"
      BusinessUnit = ""
      Application  = "Normalization Service"
      Environment  = "Dev"
    }
  }
}

provider "aws" {
  alias   = "iam"
  region  = var.aws_region
  profile = var.aws_profile
  default_tags {
    tags = {
      Owner        = "Device42"
      Project      = "SaaS Data Normalization"
      BusinessUnit = ""
      Application  = "Normalization Service"
      Environment  = "Dev"
    }
  }
}

provider "aws" {
  alias   = "acm"
  region  = var.aws_region
  profile = var.aws_profile
  default_tags {
    tags = {
      Owner        = "Device42"
      Project      = "SaaS Data Normalization"
      BusinessUnit = ""
      Application  = "Normalization Service"
      Environment  = "Dev"
    }
  }
}

provider "aws" {
  alias   = "route53"
  region  = var.aws_region
  profile = var.aws_profile
  default_tags {
    tags = {
      Owner        = "Device42"
      Project      = "SaaS Data Normalization"
      BusinessUnit = ""
      Application  = "Normalization Service"
      Environment  = "Dev"
    }
  }
}

module "cloud_infra" {
  source = "../"
  providers = {
    aws         = aws
    aws.iam     = aws.iam
    aws.acm     = aws.acm
    aws.route53 = aws.route53
  }
  suffix                                                  = var.suffix
  s3_force_destroy                                        = var.s3_force_destroy
  custom_domain_for_frontend                              = var.custom_domain_for_frontend
  cloudtrail_flag                                         = var.cloudtrail_flag
  table_provisioned_capacity                              = var.table_provisioned_capacity
  test_resource_flag                                      = var.test_resource_flag
  auth_token_uri                                          = var.auth_token_uri
  auth_client_id                                          = var.auth_client_id
  auth_client_secret                                      = var.auth_client_secret
  auth_scopes                                             = var.auth_scopes
  auth_group                                              = var.auth_group
  pager_duty_flag                                         = var.pager_duty_flag
  pager_duty_service_endpoint_url                         = var.pager_duty_service_endpoint_url
  custom_domain_for_data_norm                             = var.custom_domain_for_data_norm
  xray_tracing_flag                                       = var.xray_tracing_flag
  kms_key_reuse_period                                    = var.kms_key_reuse_period
  decorator_lambda_invocation_alarm_threshold             = var.decorator_lambda_invocation_alarm_threshold
  normalization_lambda_invocation_alarm_threshold         = var.normalization_lambda_invocation_alarm_threshold
  normalization_sqs_sent_msg_anomaly_alarm_threshold      = var.normalization_sqs_sent_msg_anomaly_alarm_threshold
  normalization_s3_bucket_size_anomaly_alarm_threshold    = var.normalization_s3_bucket_size_anomaly_alarm_threshold
  normalization_api_gateway_request_count_alarm_threshold = var.normalization_api_gateway_request_count_alarm_threshold
  normalization_table_write_capacity_alarm_threshold      = var.normalization_table_write_capacity_alarm_threshold
  decorator_lambda_error_alarm_threshold                  = var.decorator_lambda_error_alarm_threshold
  normalization_lambda_error_alarm_threshold              = var.normalization_lambda_error_alarm_threshold
  normalization_table_stream_record_count_alarm_threshold = var.normalization_table_stream_record_count_alarm_threshold
  normalization_stream_error_alarm_threshold              = var.normalization_stream_error_alarm_threshold
  golden_record_table_stream_record_count_alarm_threshold = var.golden_record_table_stream_record_count_alarm_threshold
  golden_record_stream_error_alarm_threshold              = var.golden_record_stream_error_alarm_threshold
  admin_ui_gateway_5xx_error_alarm_threshold              = var.admin_ui_gateway_5xx_error_alarm_threshold
  retention_in_days                                       = var.retention_in_days
}

module "test_lambdas" {
  count  = var.test_resource_flag ? 1 : 0
  source = "../test_lambdas"
  providers = {
    aws     = aws
    aws.iam = aws.iam
  }
  suffix                     = var.suffix
  s3_force_destroy           = var.s3_force_destroy
  kms_arn                    = module.cloud_infra.kms_arn
  meta_info_table            = module.cloud_infra.meta_info_table
  golden_record_table        = module.cloud_infra.golden_record_table
  normalization_table        = module.cloud_infra.normalization_table
  db_import_log_table        = module.cloud_infra.db_import_log_table
  norm_audit_logs_table      = module.cloud_infra.norm_audit_logs_table
  gr_audit_logs_table        = module.cloud_infra.gr_audit_logs_table
  common_meta_info_arn       = module.cloud_infra.common_meta_info_arn
  golden_records_arn         = module.cloud_infra.golden_records_arn
  normalization_mappings_arn = module.cloud_infra.normalization_mappings_arn
  norm_audit_logs_arn        = module.cloud_infra.norm_audit_logs_arn
  gr_audit_logs_arn          = module.cloud_infra.gr_audit_logs_arn
  db_import_log_arn          = module.cloud_infra.db_import_log_arn
  common_utils_layers_arn    = module.cloud_infra.common_utils_layers_arn
  auth_token_uri             = var.auth_token_uri
  auth_client_id             = var.auth_client_id
  auth_client_secret         = var.auth_client_secret
  auth_scopes                = var.auth_scopes
  auth_group                 = var.auth_group
  xray_tracing_flag          = var.xray_tracing_flag
}
