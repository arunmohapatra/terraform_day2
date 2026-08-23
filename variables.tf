variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-demo"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner of the application"
  type        = string
  default     = "Terraform Training"
}

variable "application_version" {
  description = "Application version"
  type        = string
  default     = "1.0.0"
}

variable "configurations" {
  description = "Environment configuration"

  type = map(object({
    port  = number
    debug = bool
  }))

  default = {
    dev = {
      port  = 8080
      debug = true
    }

    test = {
      port  = 8081
      debug = true
    }

    prod = {
      port  = 8082
      debug = false
    }
  }
}