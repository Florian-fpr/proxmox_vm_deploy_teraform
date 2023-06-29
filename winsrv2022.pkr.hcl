packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "winsrv2K22" {

  node                        = "proxmoxC"
  os                          = "other"
  password                    = "ProjetAnnuel2023!"
  proxmox_url                 = "https://192.168.1.4:8006/api2/json"
  template_description        = "Windows Server 2022"
  username                    = "benjamin@pve"
  vm_name                     = "WinSrv2022"
  winrm_insecure              = true
  winrm_password              = "ProjetAnnuel2023!"
  winrm_use_ssl               = true
  winrm_username              = "Superviseur"
  task_timeout                = "4m"
  insecure_skip_tls_verify    = true
  iso_file                    = "local:iso/winsrv-2022.iso"
  memory                      = 4096
  communicator                = "winrm"
  cores                       = "4"
  scsi_controller             = "virtio-scsi-single"
  
  additional_iso_files {
    device            = "sata3"
    iso_storage_pool  = "local"
    iso_file          = "local:iso/Autounattend.iso"
    unmount           = true
  }

  additional_iso_files {
    device            = "sata4"
    iso_storage_pool  = "local"
    iso_file          = "local:iso/virtio-win-0.1.229.iso"
    unmount           = true
  }

  disks {
    disk_size         = "50G"
    storage_pool      = "local-lvm"
    type              = "scsi"
  }

  network_adapters {
    bridge   = "vmbr0"
    model    = "e1000"
  }

}

build {
  sources = ["source.proxmox-iso.winsrv2K22"]
}
