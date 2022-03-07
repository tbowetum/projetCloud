resource "google_storage_bucket" "my_bucket" {

name = "instagradata1"

location = "EU"

force_destroy = true

uniform_bucket_level_access = true }

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "cakes_Terraform"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }

  access {
    role          = "OWNER"
    user_by_email = google_service_account.bqowner.email
  }

  access {
    role   = "READER"
    domain = "hashicorp.com"
  }
}

resource "google_service_account" "bqowner" {
  account_id = "bqowner-${local.name_suffix}"
}
