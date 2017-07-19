echo "Enter IP address"
read ip
echo "Enter netmask"
read netmask
echo "Enter gateway"
read gateway
cat > /etc/network/interfaces << EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).
#helllooooo
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto em1
iface em1 inet static
address $ip
netmask $netmask
gateway $gateway
dns-nameservers 192.168.4.12

EOF


reboot
