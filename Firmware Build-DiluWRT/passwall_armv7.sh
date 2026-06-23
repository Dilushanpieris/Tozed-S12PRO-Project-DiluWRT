#!/bin/sh

# Define our two different storage locations
ZIP_PATH="/root/passwall.zip"          # Flash Memory
EXTRACT_DIR="/tmp/passwall_install"    # RAM/Temp

echo "-----------------------------------------------------"
echo " Preparing System for Passwall 2 (Armv7)..."
echo "-----------------------------------------------------"

opkg update

# Ensure unzip is installed
opkg install unzip

echo " Upgrading to dnsmasq-full..."
opkg remove dnsmasq 2>/dev/null
opkg install dnsmasq-full

# Install required kernel modules
opkg install kmod-ipt-tproxy iptables-mod-tproxy kmod-nft-tproxy coreutils-nohup coreutils-base64

mkdir -p "$EXTRACT_DIR"

echo "-----------------------------------------------------"
echo " Downloading Passwall 2 Core Packages..."
echo "-----------------------------------------------------"

# 1. Download the ZIP directly to FLASH MEMORY
echo " Downloading ZIP to Flash Memory (/root)..."
wget --no-check-certificate -O "$ZIP_PATH" "https://github.com/Openwrt-Passwall/openwrt-passwall2/releases/download/25.12.25-1/passwall_packages_ipk_arm_cortex-a7.zip"

# 2. Extract the contents to RAM
echo " Extracting Packages to RAM (/tmp)..."
unzip -q -o "$ZIP_PATH" -d "$EXTRACT_DIR"

# 3. Delete the ZIP from Flash to free up space BEFORE installing
echo " Freeing up Flash Memory..."
rm -f "$ZIP_PATH"

echo " Installing Core Packages..."
# 4. Install the extracted packages from RAM into the now-empty Flash
opkg install "$EXTRACT_DIR"/*.ipk

if [ $? -eq 0 ]; then
    echo "-----------------------------------------------------"
    echo " Core Packages Installed Successfully."
    echo " Downloading and Installing LuCI App..."
    echo "-----------------------------------------------------"

    # Download LuCI app directly to RAM
    wget --no-check-certificate -O "$EXTRACT_DIR/luci-app-passwall.ipk" "https://github.com/Openwrt-Passwall/openwrt-passwall2/releases/download/25.12.25-1/luci-app-passwall2_25.12.25-r1_all.ipk"
    
    # Install LuCI app
    opkg install "$EXTRACT_DIR/luci-app-passwall.ipk"
else
    echo "-----------------------------------------------------"
    echo " !!! ERROR: Core package installation failed."
    echo " Skipping LuCI App installation."
    echo "-----------------------------------------------------"
    rm -rf "$EXTRACT_DIR"
    rm -f "$ZIP_PATH"
    exit 1
fi

echo " Cleaning up RAM..."
# 5. Remove extracted files from RAM
rm -rf "$EXTRACT_DIR"

echo "-----------------------------------------------------"
echo " Passwall 2 Installation Complete!"
echo " The router will now reboot...."
echo "-----------------------------------------------------"
sleep 3
reboot