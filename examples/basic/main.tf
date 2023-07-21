##############################################################################
# IBM IAM Service ID
##############################################################################

module "ibm_iam_service_id" {
  source               = "../.."
  iam_service_policies = var.iam_service_policies
  iam_service_id_name  = var.prefix
}
