<!-- BEGIN MODULE HOOK -->

# IAM Service ID Module
<!-- UPDATE BADGE: Update the link for the following badge-->
[![Graduated (Supported)](https://img.shields.io/badge/Status-Graduated%20(Supported)-brightgreen)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-iam-service-id?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-iam-service-id/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

This module is used to create a IAM service IDs and add policies to them. A service ID identifies a service or application similar to how a user ID identifies a user. Create service IDs to enable access to your IBM Cloud services by applications hosted both inside and outside of IBM Cloud.

<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-iam-service-id](#terraform-ibm-iam-service-id)
* [Examples](./examples)
    * [Basic example](./examples/basic)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->

### Usage

```hcl
provider "ibm" {
  ibmcloud_api_key = "XXXXXXXXXX" # pragma: allowlist secret
  region           = "us-south"
}

module "iam_service_ids" {
  source                     = "terraform-ibm-modules/terraform-ibm-iam-service-id"
  version                    = "latest" # Replace "latest" with a release version to lock into a specific release
  iam_service_id_name        = "my-iam-service-id"
  iam_service_id_tags        = ["my-iam-service-id-tag"]
  iam_service_id_description = "my-iam-service-id-description"
  iam_service_policies       = {
                                my_policy_1 = {
                                    roles = ["Viewer"]
                                    tags  = ["iam-service-policy-1"]
                                }
                                my_policy_2 = {
                                    roles = ["Viewer"]
                                    tags  = ["iam-service-policy-2"]
                                }
                            }
}
```

### Required IAM access policies

All users have access to create a service ID in an account to which they are a member. However, to allow a user in an account access to view or manage a service ID that they did not personally create, they are required to have access with a role on the IAM identity service account management service. For more information, see [IAM identity service](https://cloud.ibm.com/docs/account?topic=account-account-services&interface=ui#identity-service-account-management).

❗ If the Restrict service ID creation IAM account setting is enabled, then everyone in the account, including account owners, is blocked from creating service IDs unless they are assigned explicit access. For more information, see [Restricting users from creating service IDs](https://cloud.ibm.com/docs/account?topic=account-restrict-service-id-create&interface=ui).

<!-- END MODULE HOOK -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.51.0, < 2.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_iam_service_id.service_id](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/iam_service_id) | resource |
| [ibm_iam_service_policy.policy](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/iam_service_policy) | resource |
| [ibm_iam_service_id.service_id_data](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/data-sources/iam_service_id) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_service_id_description"></a> [iam\_service\_id\_description](#input\_iam\_service\_id\_description) | Description to Service ID | `string` | `null` | no |
| <a name="input_iam_service_id_name"></a> [iam\_service\_id\_name](#input\_iam\_service\_id\_name) | Name of the service ID | `string` | n/a | yes |
| <a name="input_iam_service_id_tags"></a> [iam\_service\_id\_tags](#input\_iam\_service\_id\_tags) | List of resource tags to apply to resources created by this module. | `list(string)` | `[]` | no |
| <a name="input_iam_service_policies"></a> [iam\_service\_policies](#input\_iam\_service\_policies) | list of policies | <pre>map(object({<br>    roles              = list(string)<br>    account_management = optional(bool)<br>    tags               = optional(set(string))<br>    resources = optional(list(object({<br>      region               = optional(string)<br>      attributes           = optional(map(string))<br>      service              = optional(string)<br>      resource_instance_id = optional(string)<br>      resource_type        = optional(string)<br>      resource             = optional(string)<br>      resource_group_id    = optional(string)<br>    })))<br>    resource_attributes = optional(list(object({<br>      name     = string<br>      value    = string<br>      operator = optional(string)<br>    })))<br>  }))</pre> | n/a | yes |
| <a name="input_iam_service_provision"></a> [iam\_service\_provision](#input\_iam\_service\_provision) | Provision a new service ID? | `bool` | `true` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | The unique identifier of the service ID. |
| <a name="output_service_policy_ids"></a> [service\_policy\_ids](#output\_service\_policy\_ids) | List of service policy IDs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN CONTRIBUTING HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
<!-- Source for this readme file: https://github.com/terraform-ibm-modules/common-dev-assets/tree/main/module-assets/ci/module-template-automation -->
<!-- END CONTRIBUTING HOOK -->
