data "remote_file" "kubeconfig" {
  conn {
    host        = var.master_node.host
    user        = var.master_node.user
    private_key = file(var.master_node.private_key)
  }

  path = "/etc/rancher/k3s/k3s.yaml"
}