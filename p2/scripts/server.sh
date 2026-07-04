#!/bin/bash
set -e

# Add swap
if [ ! -f /swapfile ]; then
  fallocate -l 1G /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap sw 0 0' >> /etc/fstab
fi

# Install K3s in server mode
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server" sh -s -

# Wait for K3s ready
echo "Waiting for K3s..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 5
done

# Wait for Traefik
echo "Waiting for Traefik..."
until kubectl get pods -n kube-system | grep "^traefik" | grep -q "Running"; do
  sleep 5
done
echo "Traefik ready!"

# Fix kubeconfig permissions
chmod 644 /etc/rancher/k3s/k3s.yaml

# Apply all configs
kubectl apply -f /vagrant/confs/

echo "P2 setup complete!"