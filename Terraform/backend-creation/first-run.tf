terraform{
    required_providers {
        google = {
            source  = "hashicorp/google"
            version = "4.51.0"
        }
    }
}
provider "google" {
    credentials   = "SA.json"
    project       = "test-project"
}
resource "google_storage_bucket" "terraform_state_backend_bucket" {
    name          = "terraform_state_backend_bucket"
    location      = "US"
    # force_destroy when set to true, allows Terraform to delete the bucket and its contents if you decide to destroy the resource
    force_destroy = true
}
