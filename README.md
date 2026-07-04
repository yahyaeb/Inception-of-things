# Inception-of-Things (IoT)

A system administration project exploring Kubernetes orchestration through three progressive parts, each building on the previous one.

## Overview

This project introduces Kubernetes concepts using lightweight tools — starting from VM provisioning with Vagrant, progressing to container-based clusters with K3d, and finalizing with a fully automated GitOps pipeline using Argo CD.

---

## Part 1 — K3s and Vagrant

**What I learned:**
Vagrant is a powerful provisioning tool that automates the creation and configuration of virtual machines. It accepts shell scripts as input, making it possible to fully automate the installation and configuration of any tool inside the VM — in this case K3s.

With a single `vagrant up` command:
- Two VMs are created automatically (Server + Agent)
- K3s is installed and configured on both
- The cluster is fully operational without any manual intervention

**Key outcome:** A running K3s cluster with a control plane node (`yel-boukS`) and a worker node (`yel-boukSW`), confirmed via `kubectl get nodes`.

**Stack:** Vagrant, K3s, libvirt/QEMU, Debian Bookworm

---

## Part 2 — K3s and Three Simple Applications

**What I learned:**
Kubernetes resources — Deployments, Services, and Ingress — and how they work together to route traffic to the right application.

- **Deployment** — defines what runs (which image, how many replicas)
- **Service** — exposes the deployment internally within the cluster
- **Ingress** — routes external traffic based on the HOST header

Also discovered that `kubectl` can generate YAML templates automatically via `--dry-run=client -o yaml`, which makes creating resources much faster than writing from scratch.

**Key outcome:** Three web applications running in a single K3s instance, with Traefik Ingress routing traffic based on hostname:
- `app1.com` → App 1
- `app2.com` → App 2 (3 replicas)
- Default → App 3

**Stack:** Vagrant, K3s, Traefik Ingress, Nginx, Debian Bookworm

---

## Part 3 — K3d and Argo CD

**What I learned:**
K3d runs K3s inside Docker containers instead of VMs — much lighter and faster than Vagrant. A full cluster starts in seconds instead of minutes.

Argo CD implements the **GitOps** pattern — Git becomes the single source of truth for the cluster state. Instead of manually running `kubectl apply`, you push a change to GitHub and Argo CD automatically syncs the cluster to match.

**The GitOps flow:**
```
Edit deployment.yaml → git push → Argo CD detects change → cluster updates automatically
```

Argo CD has both a web UI and can be fully configured via CLI/YAML, making it scriptable and automatable.

**Key outcome:** A fully automated CD pipeline where changing the Docker image tag in a GitHub repository automatically triggers a live deployment update — demonstrated by switching between `v1` and `v2` of the application.

**Stack:** K3d, Docker, Argo CD, Kubernetes, GitOps

---

## Key Takeaways

- **Vagrant** abstracts VM creation the same way **Terraform** abstracts cloud infrastructure
- **K3s** is lightweight Kubernetes — same concepts, smaller footprint
- **K3d** replaces VMs with Docker containers for even faster iteration
- **Argo CD** removes manual deployment steps entirely — push to Git, let the tool handle the rest
- `kubectl --dry-run=client -o yaml` generates any Kubernetes resource template instantly
- The progression from P1 → P2 → P3 mirrors real-world infrastructure evolution: manual → automated → fully declarative

---

## Repository Structure

```
.
├── p1/                  # K3s + Vagrant (2 nodes: server + agent)
│   ├── Vagrantfile
│   ├── scripts/
│   └── confs/
├── p2/                  # K3s + 3 apps + Ingress routing
│   ├── Vagrantfile
│   ├── scripts/
│   └── confs/
└── p3/                  # K3d + Argo CD + GitOps pipeline
    ├── scripts/
    │   ├── install.sh
    │   └── clean.sh
    └── confs/
        └── argocd-app.yaml
```

---

## Author

**yel-bouk** — École 42 Nice