# terraform-proxmox-k3s

!!! IGNORE THE 0.1.X VERSIONS !!!

A module for spinning up an expandable and flexible K3s server for your HomeLab.
I just forked this to get it running on my proxmox version (8.3.5)
I removed the original docs because I didnt test them.
I also removed the kube-config output since it didnt work in my Gitlab CI.
I dont know much about terraform modules so if you have PRs you can create them and I will have a look.

I posted the module to terraforms and opentofus registries.

## Usage

> Take a look at the complete auto-generated docs on the
[Official Registry Page](https://search.opentofu.org/module/meixnerlu/k3s/proxmox/latest).

```terraform
terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc8"
    }
    macaddress = {
      source = "ivoronin/macaddress"
      version = "0.3.0"
    }
  }
  backend "http" {
  }
}

provider "proxmox" {
  ...
}

module "k3s" {
  source  = "meixnerlu/k3s/proxmox"
  version = "v0.2.X"

  authorized_keys_file = "path to a pub key"
  private_key = "path to a priv key" # of course they need to be a pair

  proxmox_node = "your proxmox node"

  node_template = "debian-12-template" # I used a debian12 cloud image with qemu-guest-agent and nfs-common installed
  proxmox_resource_pool = "k3s"

  network_gateway = "10.0.0.1"
  lan_subnet = "10.0.0.0/20"

  support_node_settings = {
    cores = 2
    memory = 4096
    storage_id = "local-lvm"
    disk_size = "64G"
  }

  master_nodes_count = 2
  master_node_settings = {
    cores = 2
    memory = 4096
    storage_id = "local-lvm"
    disk_size = "64G"
  }

  control_plane_subnet = "10.0.0.160/28"

  node_pools = [
    {
      name = "default"
      size = 3
      subnet = "10.0.0.176/28"
      storage_id = "local-lvm"
      storage_type = "disk"
      disk_size = "64G"
    }
  ]
}
```
