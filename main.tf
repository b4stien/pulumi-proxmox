terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.64.0"
    }
  }
}

provider "proxmox" {
    # `endpoint` via `PROXMOX_VE_ENDPOINT` env var
    # `api_token` via `PROXMOX_VE_API_TOKEN` env var
    insecure = true
}

resource "proxmox_virtual_environment_vm" "proxmox_vm" {
  name = "simple-vm-via-opentofu"
  node_name = "proxmox"

  agent {
    enabled = true
  }

  started = true

  clone {
    full = true
    vm_id = 667
    node_name = "proxmox"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  stop_on_destroy = true
}

output "instance_ips" {
  value = proxmox_virtual_environment_vm.proxmox_vm.ipv4_addresses
}
