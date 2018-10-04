resource "null_resource" "install_istio" {
  triggers {
    cluster_ep = "${google_container_cluster.gke_cluster.endpoint}"
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "$${CA_CERTIFICATE}" > ca.crt
      kubectl config --kubeconfig=ci set-cluster k8s --server=$${K8S_SERVER} --certificate-authority=ca.crt
      kubectl config --kubeconfig=ci set-credentials admin --username=$${K8S_USERNAME} --password=$${K8S_PASSWORD}
      kubectl config --kubeconfig=ci set-context k8s-ci --cluster=k8s --namespace=default --user=admin
      kubectl config --kubeconfig=ci use-context k8s-ci
      export KUBECONFIG=ci

      kubectl create serviceaccount --namespace kube-system tiller || true
      kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller || true
      helm init --upgrade --service-account tiller --wait

      helm repo add kubernetes-istio-module $${HELM_REPO}
      helm repo update

      kubectl create ns istio-system || true
      helm upgrade istio kubernetes-istio-module/istio --install --wait \
          --namespace istio-system \
          --version $${ISTIO_VERSION}
    EOT

    environment {
      CA_CERTIFICATE = "${base64decode(google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate)}"
      K8S_SERVER     = "https://${google_container_cluster.gke_cluster.endpoint}"
      K8S_USERNAME   = "${var.master_username}"
      K8S_PASSWORD   = "${var.master_password}"
      HELM_REPO      = "${var.helm_repository}"
      ISTIO_VERSION  = "${var.istio_version}"
    }
  }

  depends_on = ["google_container_node_pool.gke_node_pool"]
}
