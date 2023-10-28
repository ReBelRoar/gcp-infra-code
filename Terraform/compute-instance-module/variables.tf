variable "project_id" {
  description = "default project"
  type        = string
  default     = "test-project-400805"
}

# compute instance variables

variable "network" {
  description = "network to deploy to"
  type        = string
  default     = ""
}

variable "subnetwork" {
  type        = string
  description = "subet to deploy to"
  default     = ""
}

variable "service_account" {
  type = string
  description = "Default Service account for VMs"
  default = null
}

variable "name" {
  type        = string
  description = "name of the vm"
  default     = ""
}

variable "region" {
  description = "default region of compute instances"
  type        = string
  default     = "europe-central2"
}

variable "zone" {
  description = "default zone, if not specified instances will be spread across all available zones in the region"
  type        = string
  default     = null
}

variable "labels" {
  description = "labels"
  type        = map(string)
  default     = {}
}

variable "deletion_protection" {
  description = "You must disable deletion protection before removing the resource, or the instance cannot be deleted and the Terraform run will not complete successfully."
  type        = bool
  default     = false
}

# machine specification

variable "machine_type" {
  description = "machine type to create"
  type        = string
  default     = "n1-standard-1"
}

variable "image" {
  description = "default image for compute instances"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  type        = string
  default     = "pd-standard"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  type        = string
  default     = "10"
}

variable "auto_delete" {
  description = "boot_disk should be deleted or not"
  type        = string
  default     = "true"
}

variable "startup_script" {
  description = "A startup script for VMs"
  type        = string
  default     = "echo 'Welcome to the GCP' > index.html ;  python3 -m http.server 8080 &"
}