resource "google_storage_bucket" "bucket" {
    name          = "terraform_state_backend_bucket"
    location      = "US"
    # force_destroy when set to true, allows Terraform to delete the bucket and its contents if you decide to destroy the resource
    force_destroy            = true
}