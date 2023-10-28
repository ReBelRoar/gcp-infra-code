output "instance_name" {
  value       = google_sql_database_instance.my-postgres.name
  description = "The instance name for the master instance"
}

output "public_ip_address" {
  value       = google_sql_database_instance.my-postgres.public_ip_address
  description = "The first public (PRIMARY) IPv4 address assigned for the master instance"
}

output "private_ip_address" {
  description = "The first private (PRIVATE) IPv4 address assigned for the master instance"
  value       = google_sql_database_instance.my-postgres.private_ip_address
}

output "instance_ip_address" {
  value       = google_sql_database_instance.my-postgres.ip_address
  description = "The IPv4 address assigned for the master instance"
}

output "instance_first_ip_address" {
  value       = google_sql_database_instance.my-postgres.first_ip_address
  description = "The first IPv4 address of the addresses assigned."
}

output "instance_connection_name" {
  value       = google_sql_database_instance.my-postgres.connection_name
  description = "The connection name of the master instance to be used in connection strings"
}

output "instance_self_link" {
  value       = google_sql_database_instance.my-postgres.self_link
  description = "The URI of the master instance"
}

output "instance_service_account_email_address" {
  value       = google_sql_database_instance.my-postgres.service_account_email_address
  description = "The service account email address assigned to the master instance"
}