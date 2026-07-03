#!/bin/bash

echo "Cleaning up P3 environment..."

# Delete K3d cluster
k3d cluster delete my-cluster 2>/dev/null
# Clean Docker resources
docker system prune -af --volumes 2>/dev/null
# Remove kubeconfig
rm -f ~/.kube/config 2>/dev/null

echo "P3 cleanup done! Run install.sh to start fresh."