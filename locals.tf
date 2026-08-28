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

locals {
  default_configurations = {
    dev = {
      port  = 8080
      debug = true
    }

    test = {
      port = 8081
      debug = true
    }

    prod = {
      port = 8082
      debug = false
    }
  }

  configurations = merge(
    local.default_configurations,
    var.configuration_overrides
  )
}