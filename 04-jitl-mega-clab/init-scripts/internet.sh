#!/bin/sh
apk add --no-cache iproute2 dhcpcd bash dnsmasq chrony
rm -f /bin/ip
ip address add 203.0.113.1/30 dev eth1
ip link add name google type dummy
ip link set dev google up
ip address add 172.253.62.100/32 dev google
ip link add name youtube type dummy
ip link set dev youtube up
ip address add 152.250.31.93/32 dev youtube
ip link add name jeremysitlab type dummy
ip link set dev jeremysitlab up
ip address add 66.235.200.145/32 dev jeremysitlab
ip link add name ntpserver type dummy
ip link set dev ntpserver up
ip address add 216.239.35.0/32 dev ntpserver
ip route add 203.0.113.113/32 dev eth1 onlink
ip route add 203.0.113.200/29 dev eth1 onlink
cat << 'EOF' >> /etc/dnsmasq.conf
interface=eth1
dhcp-range=203.0.113.2,203.0.113.2,255.255.255.252,12h
dhcp-option=3,203.0.113.1
dhcp-option=6,203.0.113.1
no-resolv
EOF
cat << 'EOF' >> /etc/chrony/chrony.conf
allow 203.0.113.1/30
port 123
EOF
sysctl -w net.ipv4.ip_forward=1
dnsmasq --group=root --user=root
chronyd