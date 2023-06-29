packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "winsrv2K22" {
  additional_iso_files {
    device           = "sata3"
    // iso_storage_pool = "local"
    // iso_url          = "./Autounattend.iso"
    iso_checksum     = "none"
    iso_file          = "local:iso/Autounattend.iso"
    unmount          = true
  }
  additional_iso_files {
    device           = "sata4"
    iso_checksum     = "none"
    iso_file          = "local:iso/virtio-win-0.1.229.iso"
    unmount          = true
  }
  communicator = "winrm"
  cores        = "4"
  disks {
    disk_size         = "50G"
    format            = "qcow2"
    storage_pool      = "local-lvm"
    type              = "sata"
  }
  http_directory           = "http"
  insecure_skip_tls_verify = true
  iso_file                 = "local:iso/winsrv-2022.iso"
  memory                   = 4096
  network_adapters {
    bridge   = "vmbr0"
    model    = "e1000"
  }
  node                 = "ProxmoxC"
  os                   = "w2k22"
  password             = "ProjetAnnuel2023!"
  proxmox_url          = "https://192.168.1.1:8006/api2/json"
  template_description = "Windows Server 2022"
  username             = "benjamin@pve"
  vm_name              = "WinSrv2022"
  winrm_insecure       = true
  winrm_password       = "ProjetAnnuel2023!"
  winrm_use_ssl        = true
  winrm_username       = "WinRM"
}

build {
  sources = ["source.proxmox-iso.winsrv2K22"]

  // provisioner "windows-shell" {
  //   scripts = ["scripts/disablewinupdate.bat"]
  // }

  // provisioner "powershell" {
  //   scripts = ["scripts/disable-hibernate.ps1"]
  // }

}
