# -------------------------------------------------
# Copyright 2021 Device42, Inc.
# -------------------------------------------------

## AWS Provider Creds
variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "aws_access_key" {
  type    = string
  default = null
}


variable "aws_secret_key" {
  type      = string
  default   = null
  sensitive = true
}


variable "aws_iam_access_key" {
  type    = string
  default = null
}


variable "aws_iam_secret_key" {
  type      = string
  default   = null
  sensitive = true
}

## Unique suffix for aws resources
variable "suffix" {
  type    = string
  default = "default"
}

## Default s3 force destroy flag
variable "s3_force_destroy" {
  type    = bool
  default = false
}

## custom domain for frontend
variable "custom_domain_for_frontend" {
  type = object({
    domain      = string
    hosted_zone = string
    enabled     = bool
  })
  default = {
    "domain"      = "datanormadmin.dev.device42.io"
    "hosted_zone" = "dev.device42.io"
    "enabled"     = false
  }
}

## cloudtrail logs flag
variable "cloudtrail_flag" {
  type    = bool
  default = false
}

## test resource flag
variable "test_resource_flag" {
  type    = bool
  default = false
}

## deployment env name
variable "deployment_env" {
  type    = string
  default = "dev"
}

## Dynamodb table provisioned capacity
variable "table_provisioned_capacity" {
  type = object({
    enabled = bool
    read    = number
    write   = number
  })

  default = {
    enabled = false
    read    = 0
    write   = 0
  }
}

## Google oAuth2 token uri
variable "auth_token_uri" {
  type    = string
  default = "https://oauth2.googleapis.com/token"
}

## Google oAuth2 client id
variable "auth_client_id" {
  type    = string
  default = "846196771053-oc3k22t2gq63ammuk0ac47j95fq0fnka.apps.googleusercontent.com"
}

## Google oAuth2 client secret
variable "auth_client_secret" {
  type      = string
  default   = "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"
  sensitive = true
}

## Google oAuth2 scopes
variable "auth_scopes" {
  type    = string
  default = "https://www.googleapis.com/auth/cloud-identity.groups.readonly"
}

## Google oAuth2 groups
variable "auth_group" {
  type      = string
  default   = "03tbugp13kore22"
  sensitive = true
}

## Pager duty flag
variable "pager_duty_flag" {
  type    = bool
  default = false
}

## PagerDuty Service Endpoint URL
variable "pager_duty_service_endpoint_url" {
  type    = string
  default = ""
}

## custom domain for data normalization
variable "custom_domain_for_data_norm" {
  type = object({
    domain      = string
    hosted_zone = string
    enabled     = bool
  })
  default = {
    "domain"      = "dnce.dev.device42.io"
    "hosted_zone" = "dev.device42.io"
    "enabled"     = false
  }
}

## Custom xray tracing flag
variable "xray_tracing_flag" {
  type    = bool
  default = false
}

## kms key reuse period in secpnds
variable "kms_key_reuse_period" {
  type    = number
  default = 300
}

## decorator_lambda_invocation_alarm Threshold (default 100)
variable "decorator_lambda_invocation_alarm_threshold" {
  type    = string
  default = "100"
}

## normalization_lambda_invocation_alarm Threshold (default 10)
variable "normalization_lambda_invocation_alarm_threshold" {
  type    = string
  default = "10"
}

## normalization_sqs_sent_msg_anomaly_alarm Threshold (default 10)
variable "normalization_sqs_sent_msg_anomaly_alarm_threshold" {
  type    = string
  default = "10"
}

## normalization_s3_bucket_size_anomaly_alarm Threshold (default 10485760)
variable "normalization_s3_bucket_size_anomaly_alarm_threshold" {
  type    = string
  default = "10485760"
}

## normalization_api_gateway_request_count_alarm Threshold (default 100)
variable "normalization_api_gateway_request_count_alarm_threshold" {
  type    = string
  default = "100"
}

## normalization_table_write_capacity_alarm Threshold (default 100)
variable "normalization_table_write_capacity_alarm_threshold" {
  type    = string
  default = "100"
}

## decorator_lambda_error_alarm Threshold (default 1)
variable "decorator_lambda_error_alarm_threshold" {
  type    = string
  default = "1"
}

## normalization_lambda_error_alarm Threshold (default 1)
variable "normalization_lambda_error_alarm_threshold" {
  type    = string
  default = "1"
}

## normalization_table_stream_record_count_alarm Threshold (default 1000)
variable "normalization_table_stream_record_count_alarm_threshold" {
  type    = string
  default = "1000"
}

## normalization_stream_error_alarm Threshold (default 1)
variable "normalization_stream_error_alarm_threshold" {
  type    = string
  default = "1"
}

## golden_record_table_stream_record_count_alarm Threshold (default 10000)
variable "golden_record_table_stream_record_count_alarm_threshold" {
  type    = string
  default = "10000"
}

## golden_record_stream_error_alarm Threshold (default 1)
variable "golden_record_stream_error_alarm_threshold" {
  type    = string
  default = "1"
}

## admin_ui_gateway_5xx_error_alarm Threshold (default 3)
variable "admin_ui_gateway_5xx_error_alarm_threshold" {
  type    = string
  default = "3"
}

## Cloudwatch log group retention days
variable "retention_in_days" {
  type = object({
    cw_log_grp_dnorm_gway = number
    cw_log_grp_opensearch = number
    cw_log_grp_cloudtrail = number
  })
  default = {
    cw_log_grp_dnorm_gway = 365
    cw_log_grp_opensearch = 365
    cw_log_grp_cloudtrail = 365
  }
}

## bitbucket build number
variable "bitbucket_build_number" {
  type = string
  default = null
}