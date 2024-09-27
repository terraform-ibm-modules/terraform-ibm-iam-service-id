##############################################################################
# Outputs
##############################################################################

output "service_id" {
  description = "The unique identifier of the service ID."
  value       = var.iam_service_provision ? ibm_iam_service_id.service_id[0].id : data.ibm_iam_service_id.service_id_data[0].service_ids[0].id
}

output "iam_id" {
  description = "The IAM ID of the service ID."
  value       = var.iam_service_provision ? ibm_iam_service_id.service_id[0].iam_id : data.ibm_iam_service_id.service_id_data[0].service_ids[0].iam_id
}

output "service_policy_ids" {
  description = "List of service policy IDs"
  value = toset([
    for policy in ibm_iam_service_policy.policy : policy.id
  ])
}

output "service_id_apikey" {
  sensitive   = true
  description = "The API key created in the service ID."
  value       = var.iam_service_id_apikey_provision ? ibm_iam_service_api_key.service_id_apikey[0].apikey : null
}
