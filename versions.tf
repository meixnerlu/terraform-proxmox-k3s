terraform {
  required_version = ">= 1.3.0"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc8"
    }

    macaddress = {
      source  = "ivoronin/macaddress"
      version = "0.3.0"
    }
  }
}

locals {
  authorized_keyfile = "authorized_keys"
}
