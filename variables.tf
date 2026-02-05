
variable "proxmox_api_url" {
  type        = string
}

variable "proxmox_token_id" {
  type        = string
  sensitive   = true
}

variable "proxmox_token" {
  type        = string
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  type        = bool
  default     = true
}

variable "vm_id" {
  type        = number
}

# Windows Variables
variable "windc_num_vms" {
   type = number
}

variable "windc_clone_image" {
  type = string
}

variable "windc_cpu_cores" {
  type = number
}

variable "windc_memory" {
  type =  number
}

variable "vm_storage" {
  type = string
}

variable "windc_disk_size" {
  type = string
}      


# Vyos
variable "vyos_num_vms" {
   type = number
}

variable "vyos_clone_image" {
  type = string
}

variable "vyos_cpu_cores" {
  type = number
}

variable "vyos_memory" {
  type =  number
}

variable "vyos_disk_size" {
  type = string
} 

# Win11
variable "win11_num_vms" {
   type = number
}

variable "win11_clone_image" {
  type = string
}

variable "win11_cpu_cores" {
  type = number
}

variable "win11_memory" {
  type =  number
}

variable "win11_vm_disk_size" {
  type = string
} 

# Kali
variable "kali_cpu_cores" {
  type        = number
}

variable "kali_memory" {
  type        = number
}

variable "kali_disk_size" {
  type        = string
}

variable "kali_clone_image" {
  type        = string
}

variable "kali_num_vms" {
   type       = number
}

# Security Onion
variable "so_cpu_cores" {
  type        = number
}

variable "so_memory" {
  type        = number
}

variable "so_disk_size" {
  type        = string
}

variable "so_clone_image" {
  type        = string
}

variable "so_num_vms" {
   type       = number
}

# Attack-Kali
variable "attack_kali_cpu_cores" {
  type        = number
}

variable "attack_kali_memory" {
  type        = number
}

variable "attack_kali_disk_size" {
  type        = string
}

variable "attack_kali_clone_image" {
  type        = string
}

variable "attack_kali_num_vms" {
   type       = number
}

