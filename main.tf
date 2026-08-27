# ============================================================
# Create directory
# ============================================================

resource "terraform_data" "create_directory" {

  input = local.config_directory

  provisioner "local-exec" {
    command     = "mkdir ${self.input}"
    interpreter = ["cmd", "/C"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "rmdir /S /Q ${self.input}"
    interpreter = ["cmd", "/C"]
  }
}


# ============================================================
# Project information
# ============================================================

resource "local_file" "project_info" {

  depends_on = [terraform_data.create_directory]

  filename = "${local.config_directory}\\project-info.txt"

  content = <<-EOT
    Terraform Local Hands-On Lab
    =============================

    Project Name : ${var.project_name}
    Environment  : ${var.environment}
    Owner        : ${var.owner}
    Description  : ${local.project_description}

    This file was created using Terraform.
  EOT
}


# ============================================================
# Environment-specific configuration
# ============================================================

resource "local_file" "environment_config" {

  for_each = var.configurations

  depends_on = [terraform_data.create_directory]

  filename = "${local.config_directory}\\${each.key}.conf"

  content = <<-EOT
    Environment Configuration
    ==========================

    Environment : ${each.key}
    Application : ${var.project_name}
    Owner       : ${var.owner}
    Port        : ${each.value.port}
    Debug       : ${each.value.debug}
    Tags        : ${jsonencode(local.common_tags)}
  EOT
}


# ============================================================
# Application JSON
# ============================================================

resource "local_file" "application_json" {

  depends_on = [terraform_data.create_directory]

  filename = "${local.config_directory}\\application.json"

  content = jsonencode({
    application = var.project_name
    environment = var.environment
    owner       = var.owner
    version     = var.application_version

    features = {
      logging    = true
      monitoring = true
      automation = true
    }
  })
}