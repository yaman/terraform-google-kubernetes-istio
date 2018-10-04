resource "google_container_cluster" "gke_cluster" {
  name               = "${var.cluster_name}"
  region             = "${var.gcp_region}"
  min_master_version = "${var.master_version}"

   master_auth {
    username = "${var.master_username}"
    password = "${var.master_password}"
  } 

  lifecycle {
    ignore_changes = ["node_pool"]
  }

  node_pool {
    name = "default-pool"
  }
}

