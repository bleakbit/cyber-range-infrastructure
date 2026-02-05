proxmox_api_url             = "https://YOUR-IP:PORT/api2/json"
proxmox_token_id            = "YOUR-TOKEN-ID"
proxmox_token               = "YOUR TOKEN"

# Overall Settings
vm_storage                  = "local-lvm"
vm_id                       = 500

# Vyos Settings
vyos_clone_image			= "Template-Vyos"
vyos_num_vms				= 1
vyos_cpu_cores				= 2
vyos_memory					= 2048
vyos_disk_size				= "10G"

# Server Settings
windc_clone_image           = "Template-WinServ2025"
windc_num_vms               = 3
windc_cpu_cores			    = 2
windc_memory		        = 4096
windc_disk_size             = "60G"

# Win11 Settings
win11_clone_image			= "Template-Win11UnattendGuestAgent"
win11_num_vms				= 20
win11_cpu_cores				= 4
win11_memory				= 4096
win11_vm_disk_size			= "50G"

# Kali Settings
kali_clone_image 			= "Template-Kali"
kali_num_vms 				= 1
kali_cpu_cores 				= 4
kali_memory 				= 4096
kali_disk_size 				= "32G"

# Security Onion Settings
so_clone_image 				= "Template-SecurityOnionLab"
so_num_vms 					= 0
so_cpu_cores 				= 4
so_memory 					= 14336
so_disk_size 				= "300G"

# Attack-Kali Settings
attack_kali_clone_image      = "Template-Kali-attack"
attack_kali_num_vms          = 1
attack_kali_cpu_cores        = 4
attack_kali_memory           = 5130
attack_kali_disk_size        = "32G"