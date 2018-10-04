# terraform-google-kubernetes-istio [![CircleCI](https://circleci.com/gh/richardalberto/terraform-google-kubernetes-istio/tree/master.svg?style=svg)](https://circleci.com/gh/richardalberto/terraform-google-kubernetes-istio/tree/master)
Create a kubernetes cluster with istio enabled

## Usage
```
module "k8s_cluster" {
  source = "github.com/yaman/terraform-google-kubernetes-istio"

  gcp_project = "example-project"
  gcp_region  = "europe-west1-b"
  
  cluster_name    = "example-cluster"
  cluster_region  = "europe-west1-b"
  node_count      = 1
  
  master_username = "admin"
  master_password = "this_is_a_pretty_long_password_we_will_should_change!"

  credentials_file = "${file("./creds/serviceaccount.json")}"
  
  helm_repository = "https://chart-repo.storage.googleapis.com"
}
```
