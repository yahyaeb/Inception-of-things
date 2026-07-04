#!/bin/bash
set -e

# Install K3s in server mode
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --disable traefik --disable metrics-server" K3S_TOKEN=mytoken123 sh -s -

# Wait for K3s to be ready
echo "Waiting for K3s..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 5
done

# Fix kubeconfig permissions
chmod 644 /etc/rancher/k3s/k3s.yaml

# Save token for agent
cat /var/lib/rancher/k3s/server/node-token > /vagrant/token

echo "Server ready!"