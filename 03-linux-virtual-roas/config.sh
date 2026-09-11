# Add network namespaces to represent virtual devices - two hosts, a switch, and a router
ip netns add host-sales
ip netns add host-accounting
ip netns add vbr1
ip netns add vr1

# Create veth pairs to connect the namespaces
ip link add veth-a-host type veth peer name veth-a-vbr1
ip link add veth-b-host type veth peer name veth-b-vbr1
ip link add veth-c-vbr1 type veth peer name veth-c-vr1

# Wire them up
ip link set veth-a-host netns host-sales
ip link set veth-a-vbr1 netns vbr1
ip link set veth-b-host netns host-accounting
ip link set veth-b-vbr1 netns vbr1
ip link set veth-c-vbr1 netns vbr1
ip link set veth-c-vr1 netns vr1

# Create a bridge, and add the veth interfaces to it
ip -n vbr1 link add br1 type bridge vlan_filtering 1
ip -n vbr1 link set veth-a-vbr1 master br1
ip -n vbr1 link set veth-b-vbr1 master br1
ip -n vbr1 link set veth-c-vbr1 master br1

# veth-a and veth-b are untagged in 10 and 20, veth-c trunks 10 and 20
ip netns exec vbr1 bridge vlan del vid 1 dev veth-a-vbr1
ip netns exec vbr1 bridge vlan add vid 10 dev veth-a-vbr1 pvid untagged

ip netns exec vbr1 bridge vlan del vid 1 dev veth-b-vbr1
ip netns exec vbr1 bridge vlan add vid 20 dev veth-b-vbr1 pvid untagged

ip netns exec vbr1 bridge vlan del vid 1 dev veth-c-vbr1
ip netns exec vbr1 bridge vlan add vid 10 dev veth-c-vbr1
ip netns exec vbr1 bridge vlan add vid 20 dev veth-c-vbr1

# assign IP addresses to hosts
ip -n host-sales addr add 10.0.10.10/24 dev veth-a-host
ip -n host-accounting addr add 10.0.20.20/24 dev veth-b-host

# add router subinterfaces and assign IP addresses
ip -n vr1 link add name veth-c-vr1.10 link veth-c-vr1 type vlan id 10
ip -n vr1 addr add 10.0.10.1/24 dev veth-c-vr1.10

ip -n vr1 link add name veth-c-vr1.20 link veth-c-vr1 type vlan id 20
ip -n vr1 addr add 10.0.20.1/24 dev veth-c-vr1.20

# Bring up all interfaces
ip -n host-sales link set veth-a-host up
ip -n host-accounting link set veth-b-host up
ip -n vbr1 link set veth-a-vbr1 up
ip -n vbr1 link set veth-b-vbr1 up
ip -n vbr1 link set veth-c-vbr1 up
ip -n vr1 link set veth-c-vr1 up

ip -n vbr1 link set dev br1 up

# Add default gateways to hosts
ip -n host-sales route add default via 10.0.10.1
ip -n host-accounting route add default via 10.0.20.1

# Verify connectivity
ip netns exec host-sales ping 10.0.20.1
ip netns exec host-sales ping 10.0.20.20