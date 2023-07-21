##############################################################################
# Outputs
##############################################################################

output "service_id" {
  description = "The unique identifier of the service ID."
  value       = module.ibm_iam_service_id.service_id
}

output "service_policy_ids" {
  description = "List of service policy IDs"
  value       = module.ibm_iam_service_id.service_policy_ids
}
