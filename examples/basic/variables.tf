##############################################################################
# Input Variables
##############################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "Restricted IBM Cloud API Key used only for writing Log Analysis archives to Cloud Object Storage"
  default     = null
  sensitive   = true
}

variable "prefix" {
  description = "Name of the service ID"
  type        = string
  default     = "test-iam-service-id"
}

variable "resource_tags" {
  description = "List of resource tags to apply to resources created by this module."
  type        = list(string)
  default     = []
}

variable "iam_service_policies" {
  description = "list of policies"
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = optional(set(string))
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  default = {
    test = {
      roles = ["Viewer", "Manager"]
      tags  = ["iam-service-policy-example-test"]
    }
  }
}
