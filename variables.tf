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

variable "resource_tags" {
  description = "Add user resource tags to the IAM Service IDs instance to organize, track, and manage costs. [Learn more](https://cloud.ibm.com/docs/account?topic=account-tag&interface=ui#tag-types)."
  type        = list(string)
  default     = []
  validation {
    condition     = alltrue([for tag in var.resource_tags : can(regex("^[A-Za-z0-9 _\\-.:](1, 128)$", tag))])
    error_message = "Each resource tag must be 128 characters or less and may contain only A-Z, a-z, 0-9, spaces, underscore (_), hyphen (-), period (.), and colon (:)."
  }
}

variable "iam_service_id_apikey_provision" {
  description = "Create an API key for this service ID?"
  type        = bool
  default     = false
}

variable "iam_service_id_apikey_description" {
  description = "Description to Service ID API key."
  type        = string
  default     = null
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
