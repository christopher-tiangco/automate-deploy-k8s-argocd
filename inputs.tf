variable "master_node" {
  description = "k8s master control plane"
  type = object({
    host        = string
    user        = string
    private_key = string
  })
}
variable "argo_cd_host" {
  description = "hostname to access ArgoCD"
  type = string
}