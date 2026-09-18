#!/bin/sh
apk add --no-cache iproute2 dhcpcd dnsmasq
rm -f /bin/ip
ip address add 10.5.0.4/24 dev eth1
ip route add default via 10.5.0.1 metric 10
cat << 'EOF' >> /etc/dnsmasq.conf
listen-address=127.0.0.1,0.0.0.0
no-resolv
cname=www.jeremysitlab.com,jeremysitlab.com
EOF
cat << 'EOF' >> /etc/hosts
172.253.62.100    google.com
152.250.31.93     youtube.com
66.235.200.145    jeremysitlab.com
EOF
dnsmasq --group=root --user=root