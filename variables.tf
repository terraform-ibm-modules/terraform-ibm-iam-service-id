##############################################################################
# Input Variables
##############################################################################

variable "iam_service_id_name" {
  description = "Name of the service ID"
  type        = string
}

variable "iam_service_id_description" {
  description = "Description to Service ID"
  type        = string
  default     = null
}

variable "iam_service_provision" {
  type        = bool
  description = "Provision a new service ID?"
  default     = true
}

variable "tags" {
  description = "List of resource tags to apply to resources created by this module."
  type        = list(string)
  default     = []
}

##############################################################################

##############################################################################
# iam service policy variables
##############################################################################

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
}

##############################################################################
