#!/bin/sh
apk add --no-cache lldpd iproute2 dhcpcd
rm -f /bin/ip

ip link set eth1 up
ip link set eth2 up
        
# Create the hardware passthrough bridge for the PC (Untagged Data)
ip link add name br0 type bridge vlan_filtering 1
ip link set eth1 master br0
ip link set eth2 master br0
ip link set br0 up

# Add VLAN 20 to the bridge and to Eth1 (Voice VLAN)
bridge vlan add dev eth1 vid 20
bridge vlan add dev br0 vid 20

# Create the phone interface with VLAN 20
ip link add link br0 name phone0 type vlan id 20
ip link set phone0 up

ip route del default via 172.20.20.1

dhcpcd phone0