terraform {
  backend "gcs" {
    bucket      = "terraform_state_backend_bucket"
    prefix      = "basics"
    credentials = "backend-creation/test-project-400805-76e4afe348bf.json"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project     = "test-project-400805"
  region      = "europe-central2"
  credentials = "backend-creation/test-project-400805-76e4afe348bf.json"
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "subnet2"
  ip_cidr_range = "10.2.0.0/16"
  region        = "europe-central2"
  network       = "test-network"
}

resource "google_compute_instance" "vm1" {
  name         = "vm1"
  zone         = "europe-central2-a"
  machine_type = "n1-standard-1"
  project      = "test-project-400805"

  # boot disk for this VM
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  # network for this instance
  network_interface {
    network    = "test-network"
    subnetwork = "subnet2"
  }

  # specifying lables
  labels = {
    deployed = "terraform"
    env      = "rebel"
  }
}

resource "google_sql_database_instance" "my-postgres" {
  name             = "my-postgres"
  region           = "asia-south1"
  database_version = "POSTGRES_15"

  settings {
    tier = "db-f1-micro"

    # Databse flags
    user_labels = {
      deployed = "terraform"
      env      = "rebel"
    }

    # backup configuration settings
    backup_configuration {
      enabled                        = true
      start_time                     = "02:00"
      point_in_time_recovery_enabled = true
      //location                       = "asia-south1"
      transaction_log_retention_days = 5
    }
  }
  deletion_protection = false
}