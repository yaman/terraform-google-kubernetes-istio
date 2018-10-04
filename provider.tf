provider "google" {
  version = "~> 1.18"
  
  credentials = "${var.credentials_file}"
  project = "${var.gcp_project}"
  region  = "${var.gcp_region}"
}

