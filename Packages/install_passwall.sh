#!/bin/sh
#
# OpenWrt PassWall and Dependencies Installation Script
# This script performs all necessary steps: updating packages, replacing dnsmasq,
# adding PassWall and v2rayA package feeds/keys, and installing required modules.

echo "--- Starting OpenWrt Dependency Installation Script ---"

# --- 1. Initial Package Update ---
echo "1. Performing initial opkg update..."
opkg update

# --- 2. dnsmasq Replacement ---
# PassWall often requires the full version of dnsmasq for enhanced features.
echo "2. Removing default dnsmasq and installing dnsmasq-full..."
opkg remove dnsmasq --no-check
if [ $? -eq 0 ]; then
    echo "Removed default dnsmasq successfully."
fi
opkg install dnsmasq-full
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to install dnsmasq-full. Please check connectivity and opkg status."
    exit 1
fi

# --- 3. PassWall Feed and Key Setup ---
echo "3. Setting up PassWall feeds and public key..."

# Get the public key for verifying PassWall packages
wget -O /tmp/passwall.pub "https://master.dl.sourceforge.net/project/openwrt-passwall-build/passwall.pub"
if [ -f "/tmp/passwall.pub" ]; then
    opkg-key add /tmp/passwall.pub
    rm /tmp/passwall.pub
else
    echo "WARNING: Could not download PassWall public key. Feed may not be trusted."
fi

# Read OpenWrt release and architecture information
. /etc/openwrt_release
RELEASE_MAIN="${DISTRIB_RELEASE%.*}" 
ARCH="$DISTRIB_ARCH"                

echo "Detected OpenWrt Release: $RELEASE_MAIN, Architecture: $ARCH"

# Add PassWall feeds to customfeeds.conf
PASSWALL_FEEDS="passwall_luci passwall_packages passwall2"
echo "Adding PassWall feeds to /etc/opkg/customfeeds.conf..."
for feed in $PASSWALL_FEEDS; do
  FEED_URL="https://master.dl.sourceforge.net/project/openwrt-passwall-build/releases/packages-$RELEASE_MAIN/$ARCH/$feed"
  echo "src/gz $feed $FEED_URL" | tee -a "/etc/opkg/customfeeds.conf"
done

# --- 4. v2rayA Feed and Key Setup ---
echo "4. Setting up v2rayA feed and public key..."

# Get the public key for verifying v2rayA packages
wget https://downloads.sourceforge.net/project/v2raya/openwrt/v2raya.pub -O /etc/opkg/keys/94cc2a834fb0aa03
if [ $? -ne 0 ]; then
    echo "WARNING: Could not download v2rayA public key."
fi

# Add v2rayA feed to customfeeds.conf
echo "Adding v2rayA feed to /etc/opkg/customfeeds.conf..."
V2RAYA_URL="https://downloads.sourceforge.net/project/v2raya/openwrt/$ARCH"
echo "src/gz v2raya $V2RAYA_URL" | tee -a "/etc/opkg/customfeeds.conf"

# --- 5. Final Update and Package Installation ---
echo "5. Performing final opkg update to load new feeds..."
opkg update
if [ $? -ne 0 ]; then
    echo "WARNING: Final opkg update failed. Check the customfeeds.conf file for typos."
fi

# Install required kernel modules and xray core
echo "6. Installing kmod-nft-tproxy, kmod-nft-socket, and xray-core..."
opkg install kmod-nft-tproxy kmod-nft-socket xray-core

echo "--- Installation Script Finished ---"
echo "You can check the new feeds in /etc/opkg/customfeeds.conf."
