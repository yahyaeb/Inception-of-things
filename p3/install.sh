#!/bin/bash

set -e #exit on error

# 1. Install Docker
echo "Installing Docker..."
sudo apt-get update
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo chmod 666 /var/run/docker.sock
echo "Docker installed!"

# 2. Install kubectl
echo "Installing kubectl..."
sudo snap install kubectl --classic
echo "kubectl installed!"

# 3. Install K3d
echo "Installing K3d..."
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
echo "K3d installed!"

# 4. Create K3d cluster
echo "Creating cluster: my-cluster..."
k3d cluster create my-cluster \
  --k3s-arg "--disable=traefik@server:0"
#necessary so that kubectl can communicate with the k3s API server.
k3d kubeconfig merge my-cluster --kubeconfig-switch-context
echo "Cluster created!"


# 5. Create namespaces
echo "Creating namespaces..."
kubectl create namespace argocd
kubectl create namespace dev
echo "Namespaces created!"

# 6. Install Argo CD
echo "Installing Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml || true
echo "Argo CD installed!"


# 7. Wait for Argo CD to be ready
echo "Waiting for Argo CD to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd
echo "Argo CD ready!"

# 8. Apply Argo CD application
echo "Configuring Argo CD application..."
kubectl apply -f confs/argocd-app.yaml
echo "Done! Argo CD is configured and watching your GitHub repo!"


echo "========================================="
echo "Installation complete!"
echo ""
echo "To access Argo CD UI run:"
echo "kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo ""
echo "Then open: https://localhost:8080"
echo ""
echo "Get admin password:"
echo "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d && echo"
echo ""
echo "to access the app run the following commad:"
echo "kubectl port-forward svc/wil-playground 8888:8888 -n dev"
echo "========================================="