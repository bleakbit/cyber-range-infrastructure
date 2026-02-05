#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
conf

## Configure eth0 for WAN traffic
set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth0 description 'OUTSIDE'

## Configure eth1 for LAN traffic
set interfaces ethernet eth1 address '10.0.0.1/24'
set interfaces ethernet eth1 description 'LAN'

## Configure eth2 for ATTACK traffic
set interfaces ethernet eth2 address '3.143.139.1/24'
set interfaces ethernet eth2 description 'ATTACK'

## Set dns server 
set system name-server 8.8.8.8

## Configure DHCP for the LAN subnet
set service dhcp-server shared-network-name LAN subnet 10.0.0.0/24 option default-router '10.0.0.1'
set service dhcp-server shared-network-name LAN subnet 10.0.0.0/24 option name-server '10.0.0.1'
set service dhcp-server shared-network-name LAN subnet 10.0.0.0/24 option domain-name 'blue.lab'
set service dhcp-server shared-network-name LAN subnet 10.0.0.0/24 lease '86400'
set service dhcp-server shared-network-name LAN subnet 10.0.0.0/24 range 0 start '10.0.0.9'
set service dhcp-server shared-network-name LAN subnet 10.0.0.0/24 range 0 stop '10.0.0.254'
set service dhcp-server shared-network-name LAN subnet 10.0.0.0/24 subnet-id '1'

## Configure DHCP for the Attack subnet
set service dhcp-server shared-network-name ATTACK subnet 3.143.139.0/24 option default-router '3.143.139.1'
set service dhcp-server shared-network-name ATTACK subnet 3.143.139.0/24 option name-server '3.143.139.1'
set service dhcp-server shared-network-name ATTACK subnet 3.143.139.0/24 option domain-name 'attacker.lab'
set service dhcp-server shared-network-name ATTACK subnet 3.143.139.0/24 lease '86400'
set service dhcp-server shared-network-name ATTACK subnet 3.143.139.0/24 range 0 start '3.143.139.9'
set service dhcp-server shared-network-name ATTACK subnet 3.143.139.0/24 range 0 stop '3.143.139.254'
set service dhcp-server shared-network-name ATTACK subnet 3.143.139.0/24 subnet-id '2'

## Configure DNS settings
set service dns forwarding cache-size '0'
set service dns forwarding listen-address '10.0.0.1'
set service dns forwarding listen-address '3.143.139.1'
set service dns forwarding allow-from '10.0.0.0/24'
set service dns forwarding allow-from '3.143.139.0/24'

## Configure NAT rules
set nat source rule 200 outbound-interface name 'eth0'
set nat source rule 200 source address '3.143.139.0/24'
set nat source rule 200 translation address masquerade

set nat source rule 100 outbound-interface name 'eth0'
set nat source rule 100 source address '10.0.0.0/24'
set nat source rule 100 translation address masquerade

## Enable remote management
set service ssh port '22'

set protocols static route 172.16.0.0/16 next-hop 10.0.0.9
set system time-zone US/Central

commit
save
exit
