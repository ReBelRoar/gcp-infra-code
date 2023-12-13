terraform {
  backend "gcs" {
    bucket = "terraform_state_backend_bucket"
    prefix = "web-app1"
    //credentials = "backend-creation/SA.json"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project     = "test-project"
  credentials = file("../backend-creation/SA.json")
  region      = "asia-south1"
}

module "vm1" {
  source = "../compute-instance-module"

  project_id          = "test-project"
  name                = "vm1"
  region              = "asia-south1"
  zone                = "asia-south1-a"
  network             = "test-network"
  subnetwork          = "subnet1"
  deletion_protection = false
  machine_type        = "n2-standard-2"
  service_account     = "test-sa@test-project.iam.gserviceaccount.com"

  labels = {
    deployed = "terraform"
    env      = "rebelroar"
  }

  startup_script = <<-EOT
      #! /bin/bash
      NAME=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/name)
      ZONE=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/zone | sed 's@.*/@@')
      apt-get update
      apt-get install -y apache2
      cat <<EOF> /var/www/html/index.html
      <body style="font-family: sans-serif">
      <html><body><h1>Welcome!</h1>
      <p>My machine name is $NAME</p>
      <p>It is a pleasure to serve you from the $ZONE datacenter.</p>
      </body></html>
    EOT
}

module "vm2" {
  source = "../compute-instance-module"

  project_id          = "test-project"
  name                = "vm2"
  region              = "us-central1"
  zone                = "us-central1-a"
  network             = "default"
  subnetwork          = "default"
  deletion_protection = false
  machine_type        = "e2-medium"
  service_account     = "9804321232-compute@developer.gserviceaccount.com"

  labels = {
    deployed = "terraform"
    env      = "rebelroar"
  }

  startup_script = <<-EOT
      #! /bin/bash
      NAME=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/name)
      ZONE=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/zone | sed 's@.*/@@')
      apt-get update
      apt-get install -y apache2
      cat <<EOF> /var/www/html/index.html
      <body style="font-family: sans-serif">
      <html><body><h1>Welcome!</h1>
      <p>My machine name is $NAME</p>
      <p>It is a pleasure to serve you from the $ZONE datacenter.</p>
      </body></html>
    EOT
}

module "postgres-db" {
  source = "../sql-instance-module"

  project                         = "test-project"
  sql_instance_name               = "postgres-db-1"
  instance_version                = "POSTGRES_15"
  region                            = "asia-south1"
  sql_instance_type               = "db-f1-micro"
  maintenance_window_day          = "7"
  maintenance_window_hour         = "12"
  maintenance_window_update_track = "stable"
  deletion_protection             = false
  database_deletion_policy        = "DELETE"

  labels = {
    deployed = "terraform"
    env      = "rebelroar"
  }

  backup_configuration = {
    binary_log_enabled             = false
    enabled                        = true
    backup_start_time              = "02:00"
    location                       = "asia-south1"
    point_in_time_recovery_enabled = true
  }
}
