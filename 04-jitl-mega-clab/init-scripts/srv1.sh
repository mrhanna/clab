#!/bin/sh
apk add --no-cache iproute2 dhcpcd dnsmasq rsyslog
rm -f /bin/ip
ip address add 10.5.0.4/24 dev eth1
ip route del default
ip route add default via 10.5.0.1 
cat << 'EOF' >> /etc/dnsmasq.conf
interface=eth1
no-resolv
cname=www.jeremysitlab.com,jeremysitlab.com
filter-AAAA
EOF
cat << 'EOF' >> /etc/hosts
172.253.62.100    google.com
152.250.31.93     youtube.com
66.235.200.145    jeremysitlab.com
EOF
cat << 'EOF' >> /etc/rsyslog.conf
# Provides UDP syslog reception
module(load="imudp")
input(type="imudp" port="514")
EOF
dnsmasq --group=root --user=root
rsyslogd
