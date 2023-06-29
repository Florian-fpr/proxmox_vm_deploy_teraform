terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.7.4"
    }
  }
}


provider "proxmox" {
  pm_api_url = "https://192.168.1.1:8006/api2/json"
  pm_tls_insecure = true
  pm_user = var.pm_user
  pm_password = var.pm_password
}

resource "proxmox_vm_qemu" "test_vm" {
  name = "test-vm"
  target_node = "proxmoxC"

  # basic VM settings here. agent refers to guest agent
  agent = 1
  os_type = "Linux"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  iso      = "local:iso/lubuntu-23.04-desktop-amd64.iso"

  disk {
    # slot = 0
    size = "40G"
    type = "scsi"
    storage = "local-lvm"
    # iothread = 1
  }
  
  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  # cdrom {
  #   volume_id = "local:iso/lubuntu-23.04-desktop-amd64.iso"
  #   iso      = "local:iso/lubuntu-23.04-desktop-amd64.iso"
  # }

  # ipconfig0 = "ip=192.168.1.75/24,gw=192.168.1.254"
  
}