resource "google_sql_database_instance" "my-postgres" {
  name             = var.sql_instance_name
  region           = var.region
  database_version = var.instance_version

  settings {
    tier = var.sql_instance_type

    # Databse flags
    user_labels = var.labels

    ip_configuration {
      ipv4_enabled = true
    }

    # backup configuration settings
    dynamic "backup_configuration" {
      for_each = [var.backup_configuration]
      content {
        binary_log_enabled             = lookup(backup_configuration.value, "binary_log_enabled", null)
        enabled                        = lookup(backup_configuration.value, "enabled", null)
        start_time                     = lookup(backup_configuration.value, "start_time", null)
        location                       = lookup(backup_configuration.value, "location", null)
        point_in_time_recovery_enabled = lookup(backup_configuration.value, "point_in_time_recovery_enabled", null)
      }
    }

    availability_type = "REGIONAL"

    maintenance_window {
      day          = var.maintenance_window_day
      hour         = var.maintenance_window_hour
      update_track = var.maintenance_window_update_track
    }
  }

  deletion_protection = var.deletion_protection
}

resource "google_sql_database" "database_deletion_policy" {
  name     = "db1"
  instance = google_sql_database_instance.my-postgres.name
  charset = "utf8"
  deletion_policy = var.database_deletion_policy
}

resource "google_sql_user" "users" {
  name = "root"
  instance = google_sql_database_instance.my-postgres.name
  password = "myp@ssword"
}