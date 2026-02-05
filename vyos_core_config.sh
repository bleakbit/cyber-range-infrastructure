#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
conf

## Configure eth0 for WAN traffic
set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth0 description 'OUTSIDE'

## Configure eth1 for Servers traffic
set interfaces ethernet eth1 address '172.16.1.1/24'
set interfaces ethernet eth1 description 'SERVERS'

## Configure eth2 for Workstations trafficshow in
set interfaces ethernet eth2 address '172.16.2.1/24'
set interfaces ethernet eth2 description 'WORKSTATIONS'

## Configure eth3 for Soc traffic
set interfaces ethernet eth3 address '172.16.3.1/24'
set interfaces ethernet eth3 description 'SOC'

## Configure DHCP for the SERVERS subnet
set service dhcp-server shared-network-name SERVERS subnet 172.16.1.0/24 option default-router '172.16.1.1'
set service dhcp-server shared-network-name SERVERS subnet 172.16.1.0/24 option name-server '172.16.1.9'
set service dhcp-server shared-network-name SERVERS subnet 172.16.1.0/24 option domain-name 'blue.lab'
set service dhcp-server shared-network-name SERVERS subnet 172.16.1.0/24 lease '86400'
set service dhcp-server shared-network-name SERVERS subnet 172.16.1.0/24 range 0 start '172.16.1.9'
set service dhcp-server shared-network-name SERVERS subnet 172.16.1.0/24 range 0 stop '172.16.1.254'
set service dhcp-server shared-network-name SERVERS subnet 172.16.1.0/24 subnet-id '1'

## Configure DHCP for the WORKSTATIONS subnet
set service dhcp-server shared-network-name WORKSTATIONS subnet 172.16.2.0/24 option default-router '172.16.2.1'
set service dhcp-server shared-network-name WORKSTATIONS subnet 172.16.2.0/24 option name-server '172.16.1.9'
set service dhcp-server shared-network-name WORKSTATIONS subnet 172.16.2.0/24 option domain-name 'blue.lab'
set service dhcp-server shared-network-name WORKSTATIONS subnet 172.16.2.0/24 lease '86400'
set service dhcp-server shared-network-name WORKSTATIONS subnet 172.16.2.0/24 range 0 start '172.16.2.9'
set service dhcp-server shared-network-name WORKSTATIONS subnet 172.16.2.0/24 range 0 stop '172.16.2.254'
set service dhcp-server shared-network-name WORKSTATIONS subnet 172.16.2.0/24 subnet-id '2'

## Configure DHCP for the SOC subnet
set service dhcp-server shared-network-name SOC subnet 172.16.3.0/24 option default-router '172.16.3.1'
set service dhcp-server shared-network-name SOC subnet 172.16.3.0/24 option name-server '172.16.1.9'
set service dhcp-server shared-network-name SOC subnet 172.16.3.0/24 option domain-name 'blue.lab'
set service dhcp-server shared-network-name SOC subnet 172.16.3.0/24 lease '86400'
set service dhcp-server shared-network-name SOC subnet 172.16.3.0/24 range 0 start '172.16.3.9'
set service dhcp-server shared-network-name SOC subnet 172.16.3.0/24 range 0 stop '172.16.3.254'
set service dhcp-server shared-network-name SOC subnet 172.16.3.0/24 subnet-id '3'

## Configure DNS settings
set service dns forwarding cache-size '0'
set service dns forwarding listen-address '172.16.1.1'
set service dns forwarding listen-address '172.16.2.1'
set service dns forwarding listen-address '172.16.3.1'
set service dns forwarding allow-from '172.16.1.0/24'
set service dns forwarding allow-from '172.16.2.0/24'
set service dns forwarding allow-from '172.16.3.0/24'

## Configure NAT rules
set nat source rule 100 outbound-interface name 'eth0'
set nat source rule 100 source address '172.16.0.0/16'
set nat source rule 100 translation address masquerade

## Set dns server 
set system name-server 8.8.8.8

## Enable remote management
set service ssh port '22'

## Mirror Ports
set interfaces ethernet eth4 description 'mirror-port'
delete interfaces ethernet eth4 address

set interfaces ethernet eth0 mirror ingress eth4
set interfaces ethernet eth1 mirror ingress eth4
set interfaces ethernet eth2 mirror ingress eth4
set interfaces ethernet eth3 mirror ingress eth4
set interfaces ethernet eth0 mirror egress eth4
set interfaces ethernet eth1 mirror egress eth4
set interfaces ethernet eth2 mirror egress eth4
set interfaces ethernet eth3 mirror egress eth4

set system time-zone US/Central

commit
save
exit