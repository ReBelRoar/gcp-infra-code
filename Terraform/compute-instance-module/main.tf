resource "google_compute_instance" "vm" {
  name                = "${var.name}-basic"
  zone                = var.zone
  machine_type        = var.machine_type
  project             = var.project_id
  deletion_protection = var.deletion_protection
  labels              = var.labels

  # boot disk for this VM
  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size_gb
      type  = var.disk_type 
    }
  }

  # network for this instance
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
      nat_ip = null
    }
  }

  service_account {
    email = var.service_account
    scopes = ["cloud-platform"]
  }

  metadata = {
    startup_script = var.startup_script
  }

}