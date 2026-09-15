#!/bin/bash
ip link set eth1 up
ip link set eth2 up
        
# Create the hardware passthrough bridge for the PC (Untagged Data)
ip link add name br0 type bridge
ip link set eth1 master br0
ip link set eth2 master br0
ip link set br0 up

# 4. Create the tagged Voice VLAN interface (e.g., VLAN 20)
ip link add link eth1 name eth1.20 type vlan id 20
ip link set eth1.20 up
