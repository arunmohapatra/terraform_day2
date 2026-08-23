output "project_file" {
  description = "Path of the project information file"
  value       = local_file.project_info.filename
}

output "configuration_files" {
  description = "Configuration files created"
  value = {
    for environment, file in local_file.environment_config :
    environment => file.filename
  }
}

output "application_json" {
  description = "Application JSON file"
  value       = local_file.application_json.filename
}