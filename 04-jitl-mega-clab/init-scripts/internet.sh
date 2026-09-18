#!/bin/sh
apk add --no-cache iproute2 dhcpcd bash dnsmasq
rm -f /bin/ip
ip address add 203.0.113.1/30 dev eth1
ip link add name google type dummy
ip address add 172.253.62.100/32 dev google
ip link add name youtube type dummy
ip address add 152.250.31.93/32 dev youtube
ip link add name jeremysitlab type dummy
ip address add 66.235.200.145/32 dev jeremysitlab
cat << 'EOF' >> /etc/dnsmasq.conf
interface=eth1
dhcp-range=203.0.113.2,203.0.113.2,255.255.255.252,12h
dhcp-option=3,203.0.113.1
dhcp-option=6,203.0.113.1
no-resolv
EOF
sysctl -w net.ipv4.ip_forward=1
dnsmasq --group=root --user=root