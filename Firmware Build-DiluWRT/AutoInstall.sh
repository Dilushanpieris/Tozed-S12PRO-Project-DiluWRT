#!/bin/sh

# ==========================================
#  Project-DiluWRT Auto Installer Script
# ==========================================

echo ""
echo "-----------------------------------------------------"
echo " Checking for Access Key ....."
echo "-----------------------------------------------------"

if [ -f "/etc/auth/.github_token" ]; then
    echo " Key Found. Proceeding..."
else
    echo " Key Is Not Installed."
    echo " Script Aborted."
    exit 1
fi


echo ""
echo "-----------------------------------------------------"
echo " Updating Necessary Packages ....."
echo "-----------------------------------------------------"
opkg update
opkg install luci-compat
opkg install luci-lib-ipkg


echo ""
echo "-----------------------------------------------------"
echo " Installing Argon Theme ....."
echo "-----------------------------------------------------"
wget -O /tmp/argon-remote-install.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/install-argon-theme.sh" && chmod +x /tmp/argon-remote-install.sh && sh /tmp/argon-remote-install.sh && rm -f /tmp/argon-remote-install.sh


echo ""
echo "-----------------------------------------------------"
echo " Installing Dashboard ....."
echo "-----------------------------------------------------"
wget -O /tmp/install-dashboard.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/install-dashboard.sh" && chmod +x /tmp/install-dashboard.sh && sh /tmp/install-dashboard.sh && rm -f /tmp/install-dashboard.sh


echo ""
echo "-----------------------------------------------------"
echo " Updating NCM Packages ....."
echo "-----------------------------------------------------"
opkg install kmod-usb-serial kmod-usb-serial-option sms-tool


echo ""
echo "-----------------------------------------------------"
echo " Testing NCM Modem ....."
echo "-----------------------------------------------------"
sms_tool -d /dev/ttyUSB3 at "AT+CSQ" 2>/dev/null
sleep 1
sms_tool -d /dev/ttyUSB3 at "AT+CSQ" 2>/dev/null
sleep 3


echo ""
echo "-----------------------------------------------------"
echo " Installing Watchdog Service ....."
echo "-----------------------------------------------------"
wget -O /tmp/modem_service_01.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/install-watchdog.sh" && chmod +x /tmp/modem_service_01.sh && sh /tmp/modem_service_01.sh && rm -f /tmp/modem_service_01.sh


echo ""
echo "-----------------------------------------------------"
echo " Checking Modem Status ....."
echo "-----------------------------------------------------"
logread -e 'modem-watchdog'
sleep 4


echo ""
echo "-----------------------------------------------------"
echo " Installing LED Controls ....."
echo "-----------------------------------------------------"
wget -O /tmp/modem_service_02.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/install-led-controls.sh" && chmod +x /tmp/modem_service_02.sh && sh /tmp/modem_service_02.sh && rm -f /tmp/modem_service_02.sh


echo ""
echo "-----------------------------------------------------"
echo " Installing Custom Feeds ....."
echo "-----------------------------------------------------"
grep -q IceG_repo /etc/opkg/customfeeds.conf || echo 'src/gz IceG_repo https://github.com/4IceG/Modem-extras/raw/main/myrepo' >> /etc/opkg/customfeeds.conf
wget https://github.com/4IceG/Modem-extras/raw/main/myrepo/IceG-repo.pub -O /tmp/IceG-repo.pub
opkg-key add /tmp/IceG-repo.pub
opkg update


echo ""
echo "-----------------------------------------------------"
echo " Installing 3ginfo-lite ....."
echo "-----------------------------------------------------"
opkg install luci-app-3ginfo-lite


echo ""
echo "-----------------------------------------------------"
echo " Updating 3ginfo-lite Package ....."
echo "-----------------------------------------------------"
wget -O /tmp/3ginfo-update.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/update3ginfo-lite.sh" && chmod +x /tmp/3ginfo-update.sh && sh /tmp/3ginfo-update.sh && rm -f /tmp/3ginfo-update.sh


echo ""
echo "-----------------------------------------------------"
echo " Installing Modemband From Feeds ....."
echo "-----------------------------------------------------"
opkg install luci-app-atcommands
opkg install luci-app-modemband


echo ""
echo "-----------------------------------------------------"
echo " Updating Band Locking Interface ....."
echo "-----------------------------------------------------"
wget -O /tmp/remote_update.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/main/Update_Scripts/update-modemband.sh" && chmod +x /tmp/remote_update.sh && sh /tmp/remote_update.sh && rm -f /tmp/remote_update.sh


echo ""
echo "-----------------------------------------------------"
echo " Configuring WIFI / WPS ....."
echo "-----------------------------------------------------"
opkg remove wpad-basic-mbedtls wpad-mini
opkg install wpad hostapd-utils


echo ""
echo "-----------------------------------------------------"
echo " Installing WPS LED Service ....."
echo "-----------------------------------------------------"
wget -O /tmp/install-wps-led-service.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/wps-led-install.sh" && chmod +x /tmp/install-wps-led-service.sh && sh /tmp/install-wps-led-service.sh && rm -f /tmp/install-wps-led-service.sh


echo ""
echo "-----------------------------------------------------"
echo " All Tasks Completed to Step 08. Rebooting System ....."
echo "-----------------------------------------------------"
reboot