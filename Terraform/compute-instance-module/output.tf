output "instance_details" {
  description = "List all the details of VM"
  sensitive   = true
  value       = google_compute_instance.vm[*]
}