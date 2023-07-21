##############################################################################
# terraform-ibm-iam-service-id
#
# Creates a IAM service IDs and add policies to them.
##############################################################################

locals {
  iam_service_id = var.iam_service_provision ? ibm_iam_service_id.service_id[0].id : data.ibm_iam_service_id.service_id_data[0].service_ids[0].id
}

resource "ibm_iam_service_id" "service_id" {
  count       = var.iam_service_provision ? 1 : 0
  name        = var.iam_service_id_name
  description = var.iam_service_id_description
  tags        = var.iam_service_id_tags
}

data "ibm_iam_service_id" "service_id_data" {
  count = var.iam_service_provision ? 0 : 1
  name  = var.iam_service_id_name
}

resource "ibm_iam_service_policy" "policy" {
  iam_service_id = local.iam_service_id

  for_each = var.iam_service_policies

  roles              = each.value["roles"]
  account_management = each.value["account_management"]
  tags               = each.value["tags"]

  dynamic "resources" {
    for_each = each.value["resources"] != null ? each.value["resources"] : []
    content {
      region               = lookup(element(each.value["resources"], 0), "region", null)
      attributes           = lookup(element(each.value["resources"], 0), "attributes", null)
      service              = lookup(element(each.value["resources"], 0), "service", null)
      resource_instance_id = lookup(element(each.value["resources"], 0), "resource_instance_id", null)
      resource_type        = lookup(element(each.value["resources"], 0), "resource_type", null)
      resource             = lookup(element(each.value["resources"], 0), "resource", null)
      resource_group_id    = lookup(element(each.value["resources"], 0), "resource_group_id", null)
    }
  }

  dynamic "resource_attributes" {
    for_each = each.value["resource_attributes"] != null ? each.value["resource_attributes"] : []
    content {
      name     = resource_attributes.value.name
      value    = resource_attributes.value.value
      operator = resource_attributes.value.operator
    }
  }
}
