# Create a local directory
resource "local_file" "project_info" {
  filename = "C:/day2/output/project-info.txt"

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

# Create environment-specific configuration files
resource "local_file" "environment_config" {
  for_each = var.configurations

  filename = "C:/day2/output/${each.key}.conf"

  content = <<-EOT
    Environment Configuration
    ==========================

    Environment : ${each.key}
    Application : ${var.project_name}
    Owner       : ${var.owner}
    Port        : ${each.value.port}
    Debug       : ${each.value.debug}
    Tags        :${jsonencode(local.common_tags)}
  EOT
}

# Create a simple JSON file
resource "local_file" "application_json" {
  filename = "C:/day2/output/application.json"

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