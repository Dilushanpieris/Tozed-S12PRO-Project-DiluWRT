# Beware! This script will be in /rom/etc/uci-defaults/ as part of the image.
# Uncomment lines to apply:
#

#
root_password="dilu1212"
lan_ip_address="192.168.2.1"
#
# pppoe_username=""
# pppoe_password=""

# log potential errors
exec >/tmp/setup.log 2>&1

if [ -n "$root_password" ]; then
  (echo "$root_password"; sleep 1; echo "$root_password") | passwd > /dev/null
fi

# Configure LAN
# More options: https://openwrt.org/docs/guide-user/base-system/basic-networking
if [ -n "$lan_ip_address" ]; then
  uci set network.lan.ipaddr="$lan_ip_address"
fi

# Configure WLAN
uci set wireless.default_radio0.ssid='DiluWRT_2.4G'
uci set wireless.default_radio1.ssid='DiluWRT_5G'
uci commit wireless

# Configure PPPoE
# More options: https://openwrt.org/docs/guide-user/network/wan/wan_interface_protocols#protocol_pppoe_ppp_over_ethernet
if [ -n "$pppoe_username" -a "$pppoe_password" ]; then
  uci set network.wan.proto=pppoe
  uci set network.wan.username="$pppoe_username"
  uci set network.wan.password="$pppoe_password"
  uci commit network
fi

#Set Modem Interface
uci rename network.wwan="LTE"
uci commit network

# Set Banner And Hostname
uci set system.@system[0].hostname='DiluWRT'
uci commit system

echo "Updating SSH login banner to DiluWRT..."
cat << EOF > /etc/banner
8888888b.  d8b 888               888       888 8888888b. 88888888888 
888  "Y88b Y8P 888               888   o   888 888   Y88b    888     
888    888     888               888  d8b  888 888    888    888     
888    888 888 888 888  888      888 d888b 888 888   d88P    888     
888    888 888 888 888  888      888d88888b888 8888888P"     888     
888    888 888 888 888  888      88888P Y88888 888 T88b      888     
888  .d88P 888 888 Y88b 888      8888P   Y8888 888  T88b     888     
8888888P"  888 888  "Y88888      888P     Y888 888   T88b    888
                            >NET. Limits Redefined.                                                                                                                                  
                                          
EOF

echo "Hostname and SSH banner updated successfully."
echo "Changes to hostname will take effect after a reboot."
echo "All done!"
