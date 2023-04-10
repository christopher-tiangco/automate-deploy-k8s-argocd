resource "kubernetes_namespace" "manage" {
  metadata {
    name = "argo-cd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = local.argo_cd_helm_chart_version
  namespace  = kubernetes_namespace.manage.id
}

resource "kubernetes_ingress_v1" "argo_cd_server_ingress" {
  metadata {
    name        = "argocd-server-ingress"
    annotations = local.argocd_ingress_annotations
    namespace   = kubernetes_namespace.manage.id
  }

  spec {
    tls {
      hosts       = [var.argo_cd_host]
      secret_name = "argocd-secret"
    }
    rule {
      host = var.argo_cd_host
      http {
        path {
          path = "/"
          backend {
            service {
              name = "argocd-server"
              port {
                name = "https"
              }
            }
          }
        }
      }
    }
  }
}