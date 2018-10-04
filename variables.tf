variable "gcp_project" {
  description = "The name of the GCP Project where all resources will be launched."
}

variable "gcp_region" {
  description = "The region in which all GCP resources will be launched."
  default     = "europe-west1-b"
}

variable "cluster_name" {
  description = "GKE cluster name"
}

variable "master_version" {
  description = "Kubernetes cluster master version"
  default     = "1.10.7-gke.2"
}

variable "master_username" {
  description = "GKE cluster master username"
}

variable "master_password" {
  description = "GKE cluster master password"
}

variable "credentials_file" {
  description = "service account's credential file"
}

variable "cluster_region" {
  description = "GKE cluster region"
}

variable "helm_repository" {
  description = "Helm repository where the istio chart release is published"
  default     = "https://chart-repo.storage.googleapis.com"
}

variable "istio_version" {
  description = "Istio chart version"
  default     = "1.1.0"
}

variable "min_node_count" {
  description = "GKE cluster initial node count and min node count value"
  default     = 1
}

variable "max_node_count" {
  description = "GKE cluster maximun node autoscaling count"
  default     = 1
}
