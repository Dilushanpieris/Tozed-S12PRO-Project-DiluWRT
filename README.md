# TOZED S12 Pro Dialog Router - OpenWRT Project
Firmware Customized by Dilushan Nadika only For Superusers / Home Network Enthusiasts To Run S12 Pro on Steriods. Full Build Details Are Right Here.

![Image DiluWRT](https://live.staticflickr.com/65535/54798242597_0201fcfbc4_b.jpg)

## Step 01 - Firmware Selection

Install OpenWRT Using UART (Included In Directory): 
>[!TIP]
>[openwrt-24.10.2-ramips-mt7621-tozed_zlt-s12-pro-initramfs-kernel](https://downloads.openwrt.org/releases/24.10.2/targets/ramips/mt7621/openwrt-24.10.2-ramips-mt7621-tozed_zlt-s12-pro-initramfs-kernel.bin)

This Only Install WRT to RAM Refer Video on Youtube How To Install Kernal.bin [Video Link R1BNC](https://www.youtube.com/watch?v=yx-Qjkn_afw&t=21s&pp=ygUVT1BFTndydCBUT1pFRCBzMTIgcFJP) 

**UART Connection**

![UART Connection](https://live.staticflickr.com/65535/54783098367_3e0a422568.jpg) 


## Step 02 - Backup OEM Firmware
>[!WARNING]
>As A Safety Step Make Sure to Backup Original Dialog Firmware Using Luci > Backup/Restore > Backup Firmware

Backup of Dialog Firmware Can Be Also Found On This Directory If Something went Wrong.

How To Restore Backup And boot Back into Original Firmware [Video Link R1BNC](https://www.youtube.com/watch?v=NWw4_7FmG7Q&pp=ygUVT1BFTndydCBUT1pFRCBzMTIgcFJP)

![Flash On RAM](https://live.staticflickr.com/65535/54783098192_0c3ae9d379_b.jpg)

>[!CAUTION]
>Further Steps Make Permanant Changes to your Router Please Proceed With Caution!

## Step 03 Flash Router - Initial Setup

>[!TIP]
> You Can use Official Sysupgrade.bin from [OpenWRT S12Pro](https://downloads.openwrt.org/releases/24.10.2/targets/ramips/mt7621/openwrt-24.10.2-ramips-mt7621-tozed_zlt-s12-pro-squashfs-sysupgrade.bin) to Flash Router But The Firmware Given in The Directory is Same And Have minimal Mods Compared To Original Sysupgrade.bin

Flash Using Luci Interface > Upgrade/Restore > Flash Firmware / Select File Provided  (Sysupgrade.bin)

>openwrt-24.10.2-015ee654217a-ramips-mt7621-tozed_zlt-s12-pro-squashfs-sysupgrade

![First Boot](https://live.staticflickr.com/65535/54784179079_217072a029_b.jpg)

*After Reboot You Are Done with Flashing And Now You Can Log into Luci Interface With Following . SSH And WebUi both Enabled.*


**LUCI Interface** : http://192.168.2.1 (If You Flashed My Sysupgrade otherwise http://192.168.1.1)

**SSH Login/Default Login Luci (Can Change Later with Luci Interface)** <br>
* Username : root  
* password : dilu1212 (Default Password)

*You Can Update Password With Luci > System >Administration > Update Password (Same Password Updated for SSH And SCP)* 

>Make Sure to Attach SSH Interface As Lan In The Luci > System > Administration >SSH <br>
Your Configuring port Must Be Connected to Switchport LAN (Any LAN in The Router And PC)

>[!IMPORTANT]
>**Now Make Sure you Have Working Internet Supplied To Router Via NCM Modem (Sim) or Working Network to update Packages.**

#### This incldues Some Work.. (How To Connect To Existing Wifi)
Now Head Over to Luci > Network > Wireless > Scan Form 2.4Ghz Radio > Enable WLAN Radios (Now The WIFI Light Will Light Up On Router. and All the Wireless interfaces Attatch to br-lan) Now Scan From 2,4GHz Radio Connect to Network Using Password.

**Make Sure To Follow this Steps**
* Assign Firewall to WAN Zone
* Assign Name For Interface  -  *ex : HomeNET*
* Reboot
* Set Gateway Metrics (Lower Means Higher Priority)
* After Reboot Luci > Interface > HomeNET > Edit > Check Weather The Correct Device (Client) Assigned As With your Main Network SSID. 

**Interface Lookup**

Now Your Configuration PC Must Have Internet And Ip Address Assigned With 192.168.2.x Subnet. And Router Packages Can Be updated through.

**Interface View**

![Interface View JPG](https://live.staticflickr.com/65535/54783947506_25c680de34_b.jpg)

>[!IMPORTANT]
>Reboot Can cause NCM Modem (LTE) to loose Usb Interface Due to Boot up Delays we Will Fix That Later. for Now if You want to re-enable usb0 (LTE Modem) ssh into router and do manual network stack restart using.

```
/etc/init.d/network restart  # hard Reset Network Stack
```

#### Configuring Usb0 (NCM Modem) To Appear As "LTE" insted of wwan - Optional Only For Official Image

>[!CAUTION]
>This Step Is only For Official Image Users . Modified Image Alreafy Configured As LTE as Modem Interface

```
cat /etc/config/network  # show Network interface config
vi /etc/config/network   # Open Vim Editor 
```
* Press i to Enter edit mode And Edit wwan Interface Name As "LTE" Do Not Touch Other Entries. 
* Press Esc to Exit Edit Mode And Type :wq Then Press Enter to Save And Exit.
* Perform Reboot And Make sure to Reboot Network Stack Manually As Well.

>[!IMPORTANT]
>Now You Can See The Usb0 Modem Interface Has Changed but Firewall Rule Is Incorrect. Head Over to Interfaces > Locate Interface LTE (Usb0) > Edit > Firewall Settings > Attach to Wan Zone > Save And Apply

Please Ignore Dynamic interfaces When Using NCM Modem. (Ex : LTE_4)

**Reboot For Better Stability**

## Step 03.1 - SSH Access and Auth Key

>[!NOTE]
>Use Software Like Putty To Access Access Router Using SSH Client CLI > ip 192.168.2.1

**Add My Github Key**
```
This Is Currently Hidden Please Massage Me To Get A Key. +94762358660 on WA.
```

## Step 04 - Package Management/Themes

**Package Management**

Now Your S12-pro Have Internet Access Test With Luci > Network > Diagnostics > Ping/tracert Results must not Have Packet loss. 

Now Head To Luci Package Manager. Luci > System > Software > And update List

>[!WARNING]
>but Do Not **Upgrade** Packages Via SSH As it Can Cause Glitches. Only **Upgrade** Packages From Luci. My Firmware was built with Latest packages for today And you may not have much packages to Upgrade in Later Use.

**See if These Packages Are Installed**
```
opkg update
opkg install luci-compat
opkg install luci-lib-ipkg
```

**Luci-Argon-Full Theme Install Using wget-Require Auth Key to Work**
```
wget -O /tmp/argon-remote-install.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/install-argon-theme.sh" && chmod +x /tmp/argon-remote-install.sh && sh /tmp/argon-remote-install.sh && rm -f /tmp/argon-remote-install.sh
```

>[!NOTE]
>This Will Fully Install Argon Theme With [Argon Config Package](https://github.com/jerrykuku/luci-app-argon-config/releases/download/v0.9/luci-app-argon-config_0.9_all.ipk) ignore Argon-config Errors As The File is not Yet Created When Installing. 

**Log out From Luci And Log Back In**

>[!WARNING]
>Argon Best Runs on Google Chrome Rather Than MS Edge And Firefox So Make Sure to use Naitive Apllications For Web UI.

**Argon Theme Preview**

![Theme Argon](https://live.staticflickr.com/65535/54783098247_548dfbcd4b_b.jpg)

## Step 05 Configure Signal Lights / Modem Lights / LTE Network Watchdog

### See If The Drivers Are Installed
```
opkg install kmod-usb-serial kmod-usb-serial-option sms-tool
```
To Test Use Following AT Command That Verify sms_tool And Modem Communication (Standerd Port is /dev/ttyUSB3)

```
sms_tool -d /dev/ttyUSB3 at "AT+CSQ" 2>/dev/null
```

>[!NOTE]
>Must Output  +CSQ: 5,99 According to Signal Value. Even Without A Sim Card Some Modems Are Capable Of Reading CSQ Values. Only Use This For Testing sms_tool package is Working Correctly.

<hr>

### Watchdog Service For NCM Modem (usb0)

>[!IMPORTANT]
>This Is A MUST Script to Function LTE Modem in Both Reboots And Power Cycles.Otherwise The Modem Will Hang and won't Attach When performing Reboot Also There is a Possibility to Boot Hang The Modem in either conditions And Will Require Manual Network Stack restart. This Section Solve Those Problems By Modem-Watchdog Service.

**One Command Install - Modem-Watchdog-Service-Auth Key Required**

>[!IMPORTANT]
>Modem Interface Name Is Required to Run This Script Correctly If You Have Changed it please **NOTE** it Down Using Luci > Interfaces. <br>In Default sqashfs_openwrt it must be **wwan** and in DiluWRT_sqashfs its **LTE**. Then Run Following Command It Will Create All The Files And Services to Modem Watchdog.

```
wget -O /tmp/modem_service_01.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/install-watchdog.sh" && chmod +x /tmp/modem_service_01.sh && sh /tmp/modem_service_01.sh && rm -f /tmp/modem_service_01.sh
```

>[!CAUTION]
>To Test The Service Make sure you Have given Correct input to Interface Name otherwise It Will boot loop The Netstack Restart. **Then Run Following Command on CLI to See Weather the Modem Reconnects/Script Exits (Modem-UP).** if The Network Stack Restart more Than 3 Times That means you Have Provided Wrong interface And may require to Run Install Command Again. 

```
/usr/share/modemstatus/modem-watchdog.sh 
```

>[!NOTE]
>Reboot To Test The Service Function After CLI Test NCM Modem Will Now Be Attached to Usb0 in every reboot.

<hr>
