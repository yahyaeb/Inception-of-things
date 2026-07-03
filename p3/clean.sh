#!/bin/bash
sudo virsh destroy yel-boukS 2>/dev/null
sudo virsh undefine yel-boukS 2>/dev/null
sudo virsh destroy yel-boukSW 2>/dev/null
sudo virsh undefine yel-boukSW 2>/dev/null
sudo virsh vol-delete --pool default yel-boukS.img 2>/dev/null
sudo virsh vol-delete --pool default yel-boukSW.img 2>/dev/null
sudo exportfs -ra
rm -rf .vagrant/
sudo snap remove --purge firefox
sudo snap remove --purge snap-store
sudo snap remove --purge gnome-42-2204
sudo snap remove --purge gnome-46-2404
sudo snap remove --purge gtk-common-themes
sudo snap remove --purge mesa-2404
sudo snap remove --purge snapd-desktop-integration
sudo snap remove --purge bare
