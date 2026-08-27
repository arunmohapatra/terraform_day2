locals {
  project_description = "${var.project_name}-${var.environment}"

  common_tags = {
    project     = var.project_name
    environment = var.environment
    owner       = var.owner
    managed_by  = "terraform"
  }

  config_directory = "C:\\dir_created_using_terraform"
}