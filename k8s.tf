provider "kubernetes" {
  version = "~> 1.2"

  host     = "https://${google_container_cluster.gke_cluster.endpoint}"

  username = "${var.master_username}"
  password = "${var.master_password}"

  client_certificate     = "${base64decode(google_container_cluster.gke_cluster.master_auth.0.client_certificate)}"
  client_key             = "${base64decode(google_container_cluster.gke_cluster.master_auth.0.client_key)}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate)}"
}


