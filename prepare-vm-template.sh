#!/usr/bin/env bash

# Download image
wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2
mv debian-12-generic-amd64.qcow2 d12-ci.qcow2

# Customize image
virt-customize -a d12-ci.qcow2 --install qemu-guest-agent
virt-customize -a d12-ci.qcow2 --truncate /etc/machine-id

# Setup image as template in Proxmox
qm create 667 --name "d12-ci-ready" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 667 d12-ci.qcow2 local-lvm
qm set 667 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-667-disk-0,ssd=1
qm set 667 --boot c --bootdisk scsi0
qm set 667 --ide2 local-lvm:cloudinit
qm set 667 --serial0 socket --vga serial0
qm set 667 --agent enabled=1
qm template 667
