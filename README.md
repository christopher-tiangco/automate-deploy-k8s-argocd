# Deploying ArgoCD to Kubernetes cluster via Terraform

Terraform configuration for deploying ArgoCD to Kubernetes cluster (Rancher's k3s).

## Prerequisites
- Terraform CLI
- Running Kubernetes cluster
- The host that's running the Terraform CLI can SSH to the master node without using a password
- Deployment of ingress nginx controller (see https://github.com/christopher-tiangco/automate-deploy-k8s-ingress-nginx) as well as `cert-manager` (see https://github.com/christopher-tiangco/automate-deploy-k8s-cert-manager)
- A public DNS for accessing ArgoCD (e.g. argocd.example.com) as required by the `cert-manager` setup above

## Important
- I tested this with the version 5.28.1 helm chart which supports arm64 architecture
- This configuration was verified to work after provisioning a k3s cluster via https://github.com/christopher-tiangco/automate-k8s-cluster
- Make sure to add an `inputs.tfvars` file (which is set to be ignored by the repository) for setting the server target. Below is the format:
```
master_node = {
  host        = "ip address of the master node"
  private_key = "path/filename of the ssh private key for root user"
  user        = "root"
}

argo_cd_host = "the hostname to access ArgoCD (e.g. argocd.example.com) "
```

- To run the configuration, simply do the following commands
```
terraform init
terraform apply -var-file="inputs.tfvars"
```

- To login using ArgoCD initial password, run the following in the command line:
```
kubectl -n argo-cd get secret argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d; echo
```