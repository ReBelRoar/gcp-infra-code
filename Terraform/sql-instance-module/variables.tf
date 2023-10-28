variable "project" {
  description = "default project"
  type        = string
  default     = "test-project-400805"
}

# sql instance variables
variable "sql_instance_name" {
  description = "default SQL instance name"
  type        = string
  default     = "pgdb"
}

variable "instance_version" {
  description = "Default version of SQL instance"
  type        = string
  default     = "POSTGRES_15"
}

variable "sql_instance_type" {
  description = "default SQL instance type"
  type        = string
  default     = "db-f1-micro"
}

variable "region" {
  description = "default SQL instance region"
  type        = string
  default     = "asia-south1"
}

variable "backup_configuration" {
  description = "The backup_configuration settings subblock for the database setings"
  type = object({
    binary_log_enabled             = bool
    enabled                        = bool
    backup_start_time              = string
    location                       = string
    point_in_time_recovery_enabled = bool
  })
  default = {
      binary_log_enabled             = false
      enabled                        = true
      backup_start_time              = "02:00"
      location                       = "asia-south1"
      point_in_time_recovery_enabled = true
  }
}

variable "maintenance_window_day" {
  description = "The day of week (1-7) for the master instance maintenance."
  type        = number
  default     = 1
}

variable "maintenance_window_hour" {
  description = "The hour of day (0-23) maintenance window for the master instance maintenance."
  type        = number
  default     = 22
}

variable "maintenance_window_update_track" {
  description = "The update track of maintenance window for the master instance maintenance.Can be either `canary` or `stable`."
  type        = string
  default     = "canary"
}

variable "labels" {
  description = "labels"
  type        = map(string)
  default     = {}
}

variable "deletion_protection" {
  description = "Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply command that deletes the instance will fail."
  type        = string
  default     = false
}

variable "database_deletion_policy" {
  description = "The deletion policy for the database. Setting ABANDON allows the resource to be abandoned rather than deleted. This is useful for Postgres, where databases cannot be deleted from the API if there are users other than cloudsqlsuperuser with access. Possible values are: 'ABANDON', 'DELETE'. Defaults to 'DELETE'."
  type        = string
  default     = null
}