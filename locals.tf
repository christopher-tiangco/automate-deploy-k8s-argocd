locals {
  k3s_master_node_url        = "https://${var.master_node.host}:6443"
  k3s_cluster_ca_certificate = base64decode(yamldecode(data.remote_file.kubeconfig.content).clusters[0].cluster.certificate-authority-data)
  k3s_client_certificate     = base64decode(yamldecode(data.remote_file.kubeconfig.content).users[0].user.client-certificate-data)
  k3s_client_key             = base64decode(yamldecode(data.remote_file.kubeconfig.content).users[0].user.client-key-data)
  argocd_ingress_annotations = {
    "cert-manager.io/cluster-issuer"               = "letsencrypt-nginx"
    "kubernetes.io/ingress.class"                  = "nginx"
    "kubernetes.io/tls-acme"                       = "true"
    "nginx.ingress.kubernetes.io/ssl-passthrough"  = "true"
    "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"
  }
  argo_cd_helm_chart_version = "5.28.1"
}