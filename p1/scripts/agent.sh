#!/bin/bash
set -e

# Wait for server token
while ! curl -sk https://192.168.56.110:6443 > /dev/null 2>&1; do
  echo "Waiting for server..."
  sleep 5
done

# Install K3s in agent mode
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=mytoken123 sh -s -

echo "Agent ready!"