#!/bin/bash
# Cleanup
sudo virsh destroy yel-boukS 2>/dev/null
sudo virsh undefine yel-boukS 2>/dev/null
sudo virsh destroy yel-boukSW 2>/dev/null
sudo virsh undefine yel-boukSW 2>/dev/null
sudo virsh vol-delete --pool default yel-boukS.img 2>/dev/null
sudo virsh vol-delete --pool default yel-boukSW.img 2>/dev/null
sudo virsh net-destroy k3s-net 2>/dev/null
sudo virsh net-undefine k3s-net 2>/dev/null
rm -rf .vagrant/

# Start
vagrant up --provider=libvirt
echo "Done! Run 'vagrant ssh yel-boukS' to connect"