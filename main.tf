terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token
  pm_tls_insecure     = var.proxmox_tls_insecure
}

# Vyos Edge
resource "proxmox_vm_qemu" "vyos_edge_router" {
  target_node = "proxmox"
 
  count = var.vyos_num_vms
  name        = "vyos-edge-${count.index + 1}" 
  vmid        = var.vm_id + count.index
  clone       = var.vyos_clone_image
  full_clone  = false
  memory      = var.vyos_memory
  agent       = 0
  onboot      = false
  bios      = "seabios"
  scsihw = "virtio-scsi-single"

  cpu {
     cores    = var.vyos_cpu_cores
  }
  
  disk {
    slot      = "scsi0"
    type      = "disk"
    storage   = var.vm_storage
    size      = var.vyos_disk_size
    iothread = true
  }

  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr0"
  }

  network {
    id        = 1
    model     = "virtio"
    bridge    = "vmbr2"
  } 
  
  network {
    id        = 12
    model     = "virtio"
    bridge    = "vmbr7"
  } 


  agent_timeout = 30
}

# Vyos Core
resource "proxmox_vm_qemu" "vyos_core_router" {
  target_node = "proxmox"
 
  count = var.vyos_num_vms
  name        = "vyos-core-${count.index + 1}" 
  vmid        = var.vm_id + count.index + var.vyos_num_vms
  clone       = var.vyos_clone_image
  full_clone  = false
  memory      = var.vyos_memory
  agent       = 0
  onboot      = false
  bios      = "seabios"
  scsihw = "virtio-scsi-single"

  cpu {
     cores    = var.vyos_cpu_cores
  }
  
  disk {
    slot      = "scsi0"
    type      = "disk"
    storage   = var.vm_storage
    size      = var.vyos_disk_size
    iothread = true
  }

  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr2"
  }

  network {
    id        = 1
    model     = "virtio"
    bridge    = "vmbr3"
  }

  network {
    id        = 2
    model     = "virtio"
    bridge    = "vmbr4"
  }
  
  network {
    id        = 3
    model     = "virtio"
    bridge    = "vmbr5"
  }  

  network {
    id        = 4
   model     = "virtio"
    bridge    = "vmbr6"
  }  

  agent_timeout = 30
}

# Win Server
resource "proxmox_vm_qemu" "dc_vm" {
  target_node = "proxmox"

  count       = var.windc_num_vms
  name        = "DC-${count.index + 1}"
  vmid        = var.vm_id + count.index + (var.vyos_num_vms * 2)
  clone       = var.windc_clone_image
  full_clone  = false
  memory      = var.windc_memory
  agent       = 1
  onboot      = false
  bios        = "ovmf"
  scsihw      = "virtio-scsi-single"
  
  vga {
       type   = "qxl"
  }


  cpu {
     cores    = var.windc_cpu_cores
  }
  
  disk {
    slot      = "scsi0"
    type      = "disk"
    storage   = var.vm_storage
    size      = var.windc_disk_size
    iothread = true
  }

  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr3"
  }

  agent_timeout = 30
}


# Win11
resource "proxmox_vm_qemu" "win11_vm" {
  target_node = "proxmox"
  
  count       = var.win11_num_vms
  name        = "win11vm-${count.index + 1}"
  vmid        = var.vm_id + count.index + (var.vyos_num_vms * 2) + var.windc_num_vms
  clone       = var.win11_clone_image
  full_clone  = false
  memory      = var.win11_memory
  agent       = 1
  onboot      = false
  bios        = "ovmf"
  scsihw      = "virtio-scsi-single"
 
  vga {
       type   = "qxl"
  }

  cpu {
     cores    = var.win11_cpu_cores
  }
  
  disk {
    slot      = "ide0"
    type      = "disk"
    storage   = var.vm_storage
    size      = var.win11_vm_disk_size
  }

  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr4"
  }

  agent_timeout = 30
}

# Kali
resource "proxmox_vm_qemu" "kali_vm" {
  target_node = "proxmox"

  count       = var.kali_num_vms
  name        = "kali-${count.index + 1}"
  vmid        = var.vm_id + count.index + (var.vyos_num_vms * 2) + var.windc_num_vms + var.win11_num_vms
  clone       = var.kali_clone_image
  full_clone  = false
  memory      = var.kali_memory
  agent       = 1
  onboot      = false
  bios        = "seabios"
  scsihw      = "virtio-scsi-single"  

  vga {
       type   = "qxl"
  }
  
  cpu {
      cores   = var.kali_cpu_cores
  }

  disk {
    slot     = "scsi0"
    type     = "disk"    
    storage  = var.vm_storage   
    size     = var.kali_disk_size
    iothread = true
  }

  network {
    id       = 0
    model    = "virtio"
    bridge   = "vmbr5"
  }

  agent_timeout   = 30
}

# Security Onion
resource "proxmox_vm_qemu" "so_vm" {
  target_node = "proxmox"

  count       = var.so_num_vms
  name        = "SecurityOnion-lab"
  vmid        = var.vm_id + count.index + (var.vyos_num_vms * 2) + var.windc_num_vms + var.win11_num_vms + var.kali_num_vms
  clone       = var.so_clone_image
  full_clone  = false
  memory      = var.so_memory
  agent       = 0
  onboot      = false
  bios        = "seabios"
  scsihw      = "virtio-scsi-single"  
  
  cpu {
      cores   = var.so_cpu_cores
      type = "x86-64-v2-AES"
  }

  disk {
    slot     = "scsi0"
    type     = "disk"    
    storage  = var.vm_storage   
    size     = var.so_disk_size
    iothread = true
  }

  network {
    id       = 0
    model    = "virtio"
    bridge   = "vmbr5"
  }

 network {
    id       = 1
    model    = "virtio"
    bridge   = "vmbr6"
  }

  agent_timeout   = 30
}

# Attack-Kali
resource "proxmox_vm_qemu" "redKali_vm" {
  target_node = "proxmox"

  count       = var.attack_kali_num_vms
  name        = "redKali-${count.index + 1}"
  vmid        = var.vm_id + count.index + (var.vyos_num_vms * 2) + var.windc_num_vms + var.win11_num_vms + var.kali_num_vms + var.so_num_vms
  clone       = var.attack_kali_clone_image
  full_clone  = false
  memory      = var.attack_kali_memory
  agent       = 1
  onboot      = false
  bios        = "seabios"
  scsihw      = "virtio-scsi-single"  

  vga {
       type   = "qxl"
  }
  
  cpu {
      cores   = var.attack_kali_cpu_cores
  }

  disk {
    slot     = "scsi0"
    type     = "disk"    
    storage  = var.vm_storage   
    size     = var.attack_kali_disk_size
    iothread = true
  }

  network {
    id       = 0
    model    = "virtio"
    bridge   = "vmbr7"
  }

  agent_timeout   = 30
}