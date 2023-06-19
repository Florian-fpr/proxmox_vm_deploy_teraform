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

  cdrom {
    volume_id = "local:iso/lubuntu-23.04-desktop-amd64.iso"
    iso      = "local:iso/lubuntu-23.04-desktop-amd64.iso"
  }

  disk {
    slot = 0
    # set disk size here. leave it small for testing because expanding the disk takes time.
    size = "40G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 1
  }
  
  # if you want two NICs, just copy this whole network section and duplicate it
  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=192.168.1.75/24,gw=192.168.1.254"
  
}