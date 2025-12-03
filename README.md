# TOZED S12 Pro Dialog Router - OpenWRT Project
Firmware Customized by Dilushan Nadika only For Superusers / Home Network Enthusiasts To Run S12 Pro on Steriods. Full Build Details Are Right Here.

![Image DiluWRT](https://live.staticflickr.com/65535/54798242597_0201fcfbc4_b.jpg)

## Step 01 - Firmware Selection

Install OpenWRT Using UART (Included In Directory): 
>[!TIP]
>[openwrt-24.10.2-ramips-mt7621-tozed_zlt-s12-pro-initramfs-kernel](https://downloads.openwrt.org/releases/24.10.2/targets/ramips/mt7621/openwrt-24.10.2-ramips-mt7621-tozed_zlt-s12-pro-initramfs-kernel.bin)

This Only Install WRT to RAM Address Refer Video on Youtube How To Install Kernal.bin [Video Link R1BNC](https://www.youtube.com/watch?v=yx-Qjkn_afw&t=21s&pp=ygUVT1BFTndydCBUT1pFRCBzMTIgcFJP) 

**UART Connection**

![UART Connection](https://live.staticflickr.com/65535/54783098367_9b12eecaa6_z.jpg) 


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

**For DiluWRT Flash my Sysupgrade From Releases TAB**

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

### Easy Way - Existing SIM Connection

Attach LTE (on Diluwrt > Luci > Interfaces) to WAN Zone And Then Restart LTE. Now You Have Internet through SIM

### Connecting to Existing WIFI Network.

#### This incldues Some Work.. 
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
/etc/init.d/network restart  # hard Reset Network Stack.
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

>[!CAUTION]
>Before Requesting Key : <br>**Fully Read The Guideline From Start to End And Undersatnd The Process.** <br> **Installed DiluDRT Sysupgrade**<br> **Router Have Working Internet Connection**<br>
Get Familier with The Process. Only The Starting Key Command is Provided to Paste to your SSH Console. 

**Get Install Key From**

![WA Contact](https://live.staticflickr.com/65535/54953867207_c1c615b248.jpg)

**Key Install Format**
```
GH_TOKEN="" 

mkdir -p /etc/auth && echo "$GH_TOKEN" > /etc/auth/.github_token && chmod 600 /etc/auth/.github_token
```

# Auto Install without Exroot Config.
>[!CAUTION]
>This Is The Simple Install Method for Those Who only Need DiluWRT Build Without Custom Configs. If You Use This Build Will Be All Auto Installed Till Step 8. Please Make Sure you Have Followed Till Step 03 And Have Working internet To Router Test with **opkg update**

## One Click Install Command
```
wget --no-check-certificate -O /tmp/AutoInstall.sh "https://raw.githubusercontent.com/Dilushanpieris/Tozed-S12PRO-Project-DiluWRT/refs/heads/main/Firmware%20Build-DiluWRT/AutoInstall.sh" && chmod +x /tmp/AutoInstall.sh && /tmp/AutoInstall.sh
```
# Manual Build - 100% Stable Install
>[!WARNING]
>Followed Step 03.1 now You Can Install Build in Full Manual Mode. This Mode Is Best for Custom Install with either Official DiluWRT Sysupgrade or Official OpenWrt24.01 Sysupgrade Proceed From Step 8 After as you Done Necessary Modifications. **(Optional Features Are At Step 8 And Step 9)**


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

### Dashboard Install Oneline Command - Require Auth Key.

```
wget -O /tmp/install-dashboard.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/install-dashboard.sh" && chmod +x /tmp/install-dashboard.sh && sh /tmp/install-dashboard.sh && rm -f /tmp/install-dashboard.sh
```

**Preview Of Dashboard**

![Dashboard Preview](https://live.staticflickr.com/65535/54832039002_53d9e07bf9_b.jpg)

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
>To Test The Service Make sure you Have given Correct input to Interface Name otherwise It Will Attach Usb0 to modem And The Script Will Exit (Failsafe Condition) **Then Run Following Command on CLI to See Weather the Modem Reconnects/Script Exits (Modem-UP).** if The Network Stack Restart more Than 3 Times That means you Have Provided Wrong interface And may require to Run Install Command Again. 


**Test Logs With**
```
logread -e 'modem-watchdog'
```

>[!NOTE]
>Reboot To Test The Service Function After CLI Test NCM Modem Will Now Be Attached to Usb0 in every reboot.

<hr>

### Signal Indicator light Configs
>[!IMPORTANT]
>This Section Scripts Are Meant to Control LEDs With Custom Scripts That Respond To AT Commands Using sms_tool Library Before Procceding Further Make Sure that sms_tool Is Fully Functional By Using Test Commands

**Single Command Install Require Auth Key**

>[!WARNING]
>To Run Below Command The Git hub Key Must Be Installed into Router First. it Will Create Modem Watchdog Service.

```
wget -O /tmp/modem_service_02.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/install-led-controls.sh" && chmod +x /tmp/modem_service_02.sh && sh /tmp/modem_service_02.sh && rm -f /tmp/modem_service_02.sh
```

>[!NOTE]
>Now Your Router Has All Functional lights And Signal indicators. Test by Using SIM Card That Have Signifficant Signal Strength. And Vary the Place If Necessary.

![Preview Router](https://live.staticflickr.com/65535/54784186628_995f51e5da_z.jpg)

## Step 06 Modem Management Interface - 3ginfo-lite/AT Commands/ModemBand
>[!TIP]
>To Install 3ginfo Lite Package you Must First Add Custom Feeds From [4IceG Custom Feeds](https://github.com/4IceG/Modem-extras) Here I Have Forked All The Codes Needed to Fully Setup 3gInfo-Lite Package. 

**Install Custom Feeds**
```
grep -q IceG_repo /etc/opkg/customfeeds.conf || echo 'src/gz IceG_repo https://github.com/4IceG/Modem-extras/raw/main/myrepo' >> /etc/opkg/customfeeds.conf
wget https://github.com/4IceG/Modem-extras/raw/main/myrepo/IceG-repo.pub -O /tmp/IceG-repo.pub
opkg-key add /tmp/IceG-repo.pub
opkg update
```

### 3ginfo-Lite Luci App

**Now You Can install Official 3ginfo-Lite Package From [4IceG](https://github.com/4IceG/luci-app-3ginfo-lite?tab=readme-ov-file) Use These Commands**

```
opkg install luci-app-3ginfo-lite
```
>[!IMPORTANT]
>This Script From 4IceG Does not Work Staright Away. As it Lack Support For Modem LT72-A Now We Will Replace it With Out Own Script to Make It Work. You Can Test it on Luci > Modem >3G/4G Connection

**One Command update Require Key Form Git**
```
wget -O /tmp/3ginfo-update.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/update3ginfo-lite.sh" && chmod +x /tmp/3ginfo-update.sh && sh /tmp/3ginfo-update.sh && rm -f /tmp/3ginfo-update.sh
```

>[!TIP]
>Now Perfom Reboot For Optional Stability And Test Luci For Signal Indicator Page Configuration Page Also included.

**View of 3gInfo-Lite Package**

![3ginfo-lite](https://live.staticflickr.com/65535/54785920988_8793134957_b.jpg)

### AT Commands Section - for Debugging/Testing 
```
opkg install luci-app-atcommands
```
**Now You Can See AT Commands Section In the Modem Section.**

### Band Locking using Modemband Package
>[!IMPORTANT]
>This Package Is Not Fully Supported By Default Just like 3ginfo Package So We May Need To Have Custom Configs To Send Band Lock Commands.Update Using Following Command from wget

```
opkg install luci-app-modemband
```


**One Command Update -Require Auth Key**

```
wget -O /tmp/remote_update.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/main/Update_Scripts/update-modemband.sh" && chmod +x /tmp/remote_update.sh && sh /tmp/remote_update.sh && rm -f /tmp/remote_update.sh
```

## Step 07 - Wireless Interface Configuration (WPS/WPA2/PSK)
>[!CAUTION]
>As a Default Wireless Interfaces Does Not Have Encryption bound in. Wifi toggle Button Usually Works on Tozed S12 Pro And The WPS Button is Disabled by Default for Security Enforcement. But It Can Be Enabled For Use As Follows. **Only Enable WPS if Necessary**

### Initial Setup - WPS/WIFI AP Security

**Test If The Pacakges Are Fully Installed**
```
opkg remove wpad-basic-mbedtls wpad-mini
opkg install wpad hostapd-utils
```

>[!IMPORTANT]
>Make Sure To Configure APs with Encryption And Perform Reboot Then you Can Head Over To Luci > Wireless >Security And then Enable WPS Support For Desired AP. (2.4Ghz) Recommended. 

**WPS Enable 2.4Ghz AP (phy0-ap0)**

![WPS Settings](https://live.staticflickr.com/65535/54786250445_0faf7d228a_c.jpg)

**You Can Configure Encryption Settings Here As Well And Now The WPS Push button Works**

<hr>

### WPS LED SCRIPTS
>[!WARNING]
>You Must Enable WPS For Required Interface otherwise Following Scripts Won't Work.Careful When Selecting Interfaces. and Leds.

**One Command Install WPS_LED Require Auth Key**
```
wget -O /tmp/install-wps-led-service.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/wps-led-install.sh" && chmod +x /tmp/install-wps-led-service.sh && sh /tmp/install-wps-led-service.sh && rm -f /tmp/install-wps-led-service.sh
reboot
```

>[!NOTE]
>Now When you Press WPS Button The LED Of Your Choice (Power:yellow) Will Light up until The WPS Success or Timeout after 120 Secs. 

## Step 08 - MultiWan Failover Setup
>[!CAUTION]
>This Section Is To Configure Multiwan Failover Setup That Handle 2 or More WAN Connections to Router And Switch Between According to Metric Value Assigned. **Keep In mind That Mwan3 Uses old Firewall 3 And it Can Cause Problems With Newer Firewall 04 So Use It At your Risk** For Simple Failover you Can Use Gateway Metrics At Interfaces.

### Initial Installian

**Start By Installing This**
```
opkg update
opkg install luci-app-mwan3
```
**Now Head Over to Luci > Network > MultiWan Manager > Add Modem Interface To Interface Section In My Case LTE**

>[!WARNING]
>Remove All The Interfaces/Members/ Policies Otherwise Internet Won't Work As Expected In Configuring PC 

![MwManager View](https://live.staticflickr.com/65535/54786495806_40c39a3f68_b.jpg)

>[!IMPORTANT]
>IF You Plan to Use LAN Port 04 (Switch Port: Wan) As A Main Internet Connection From Home Router/ISP Head Over To Network > Devices And Configure Br-Lan And **De-attach Switchport:wan** From the Bridge. Then Create New Interface With with Switchport:wan And Assign WAN Firewall Rule. Make Sure to Add Gateway Metrics In The Interfaces Tab.

**Set Gateway Metrics in Network > Interfaces Tab Lower Gateway Metrics Means High Priority.** <br>
>HomeWan Metric = 5 | HomeNet Metric = 10 | LTE Metric = 15 Means HomeNet Have More Priority Over LTE.

**Now Attach Interfaces In MultiWAN Manager**
>[!WARNING]
>To Correctly Check Weather The Interface Is Up Or Not. Use Google/ Cloufalre DNS To Ping Otherwise Its Not Able to Detect the Interface Is Up or Not.<br>
**Google 8.8.8.8** <br>
**Cloudflare 1.1.1.1**


### Mwan3 Settings/ Advanced Settings - Interfaces
**Interfaces-Mwan Manager**

![Mwan Settings-intf](https://live.staticflickr.com/65535/54788384854_8a243b2156_b.jpg)

**Settings to Track Interface status**

![Tracking Params](https://live.staticflickr.com/65535/54788409508_bbae41b7a4.jpg)

>Must Add Tracking To All Wan Interfaces Here I Have Added to HomeWan | HomeNet | LTE

### Mwan3 Settings/ Advanced Settings - Members

**Now Define New Members Of MultiWan**

![Member Configs](https://live.staticflickr.com/65535/54788153281_fe4b060374_b.jpg)
>[!TIP]
>Metrics Are only Used In This Setup to Control Simple Failover Rule . It Determines Priority of Members And Weight is not Set Due to This Failover Setup Is Not Designed to Split Traffic between WAN Connections. If You Want To Split Traffic The Weight Calculations Are Follows . (If not Keep it defualt just To Switch)
<br><br>
HomeNet | **Metric 10** **Weight 200**<br>
LTE       | **Metric 15** **Weight 300**<br>
**Weight is Irrelevent Here only Switches using Metrics Low Metric = High Priority**
<br><hr>
HomeNet | **Metric 3** **Weight 200**<br>
LTE       | **Metric 3** **Weight 300**<br><br>
**Total Weight = 300+200 = 500**<br>
HomeNet Traffic = 200/500 = 0.4 (40% of Total Traffic) <br>
LTE Traffic = 300/500 = 0.6 (60% of Total Traffic)


### Mwan3 Settings/ Advanced Settings - Policies

**Now Configure Policy And Attach All The Members We Created**

![Policy Image](https://live.staticflickr.com/65535/54788409498_fbe382c074_b.jpg)

>[!NOTE]
>One Policy That Have All The Members Is Enough to Switch Between Mambers . if you Plan to Split Traffic you May Require More than one policies.

**Now Attach New Policy into https/default_rule_v4 To Route Traffic Save And Apply**

![Policy Table](https://live.staticflickr.com/65535/54787310492_7c30d8e3c4_b.jpg)

**Now Router Will Switch Between Interfaces According to Metrics And I Have Tested With 3 WAN Connections.**

## Step 09 - Smart Traffic Control QoS/SQM
>[!TIP]
>Used For Limit Bandwidth Between WAN And LAN Netwroks to Manage Traffic Upon Uplink Router / LAN Connections To Router. This Section Divided Into <br>
* WAN SQM(Smart Queue Management) <br>
* LAN SQM(Smart Queue Management)

**Installing Of QoS/SQM Package**
```
opkg update
opkg install luci-app-sqm
```
### WAN SQM/QOS
>[!WARNING]
>Changes Done Here Will Affect Bandwidth of All The Router Conncetions (Lan Bridge And Attached Interfaces to Specific LAN) Also you Can Customize With Individual WANs As Well. 

To Setup WAN Bandwidth Limit First Create Interfaces As Per Your Requirement Using Interface Management Tab Luci > Network > Interfaces 

>[!TIP]
>Now Test Your Speeds Using [SpeedTest](https://Speedtest.net) or [WaveForm](https://www.waveform.com/tools/bufferbloat) and Acquire Test Results in kbp/s For Setting WAN 85-95% of uplink Speed Is Recommended. <br>
**Ex: Test Results 245,000 Kbp/s Down And 150,000 Kbp/s Up Setup SQM For About 90% As** <br>
* SQM Downlink 220,500 Kbp/s     
* SQM Uplink  135,000 Kbp/s
* Setting 0 Kbp/s means no control Applied 

**Now Head Over To Luci > Network > Qos/SQM Tab and Select Interface Of WAN Then Set Uplink/Downlink**

![Sample Basic Settings](https://live.staticflickr.com/65535/54791182544_e90fae9bb6_b.jpg)

>[!NOTE]
>If you Need Download of 70Mbp/s And Upload of 50Mbps Put Speeds As above.

**Link Layer Adaptation Tab**
>[!NOTE]
>The purpose of Link Layer Adaptation is to give the shaper more knowledge about the actual size of the packets so it can calculate how long packets will take to send. When the upstream ISP technology adds overhead to the packet, we should try to account for it. This primarily makes a big difference for traffic using small packets, like VOIP or gaming traffic. If a packet is only 150 bytes and say 44 bytes are added to it, then the packet is 29% larger than expected and so the shaper will be under-estimating the bandwidth used if it doesn't know about this overhead. 44 byte With Ethernet Overhead is Recommended for MultiWan Setup Like This.

![Smaple Link Layer Adaptaion](https://live.staticflickr.com/65535/54790096222_efc9ec61ec_b.jpg)

### LAN SQM/QOS
>[!TIP]
>Here You Can Set Speeds For Each LAN Interface Such As Wifi AP/ Switchports But Keep in Mind Download Link Speed Is Defined in LAN Marked As Upload In SQM Instance So Configure Like This. LAN Interfaces Does Not Require Link layer Adaptation as It Is Managed by Inbuilt WAN.

**Here I Have Added Bandwidth Limit - SQM For 5Ghz AP**

![LAN SQM](https://live.staticflickr.com/65535/54791182534_c8b700b543_b.jpg)

## Step 10 - USB As a Package Storage 

### Hardware Mods.
>[!IMPORTANT]
>To Mount USB S12 Pro Does Not Have Inbuilt 5V Supply for USB Port You Can Use AMS1117 5v Regulator Module For Supply Usb Port With +5v Line The Voltage Taps Are Found As Follows. 

**5V Regulator Voltage Taps**

![Regulaotor Taps](https://live.staticflickr.com/65535/54783947631_bc54d0e11e_z.jpg)


>[!CAUTION]
>Never Use Liner Regulator Like LM7805 For This As it Generate Signifficant Heat.And Require Adaquete Cooling And Power. Still Its Not Suitable. Also Never Tap Directly From +12V Line As It Lacks Voltage Stabilizers.

**After Wiring Regulaotor It Will Look Like This**

![Regulator Plugged](https://live.staticflickr.com/65535/54783947511_a269155147_z.jpg)

### USB Setup As Package Storage.(ex_root Config)
>[!IMPORTANT]
>Format Your USB Drive To FAT32/ExFAT And Then Plug into Roter Then Install These Packages. 

**For SSD USB Enclosure**
```
 opkg install kmod-usb-storage-uas  # Optional Package
```

**One Command Exroot Config - Key Required**

>[!CAUTION]
>Make Sure You Have Plugged In USB And Have Proper Internet Connection. If There Is Issue With Package Checks Abort Script And Then Try Again 

```
wget -O /tmp/exroot_config.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/exroot_config.sh" && chmod +x /tmp/exroot_config.sh && sh /tmp/exroot_config.sh && rm -f /tmp/exroot_config.sh
```

>[!NOTE]
>Now It Will Attached To System Storeage And You can See it on Luci Interface. Removing USB Will Not Cause Boot Hang The Router but your New Configs And Packages Are not Accessible After Removing USB.

![ExRoot USB](https://live.staticflickr.com/65535/54791040771_c398cb014f_c.jpg)

## Step 11 V2ray A Client - VPN On OpenWRT

### Passwall 01 AND Passwall 02
>[!IMPORTANT]
>Passwall Is Good At Pacakge Handling and Resource Management. **Passwall 01 is Recommended To Use In Router Like S12 Pro To limit Resource Usage (CPU)**<br>
To Install Passwall You Must First Make Sure to Remove Dnsmasq And Install Full Version of The Package **Ignore Confile Errors**<br>
However the Max Speeds Can Be Achived **limited by CPU > Around 20-30mbps on Fibre uplink.**


**One Command Install Require Auth Key**
```
wget -O /tmp/install-passwall.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Update_Scripts/install-passwall.sh" && chmod +x /tmp/install-passwall.sh && sh /tmp/install-passwall.sh && rm -f /tmp/install-passwall.sh
```

**Passwall Interface Will Look Like This**

![Passwall](https://live.staticflickr.com/65535/54793054769_c8e44c519e_c.jpg)


>[!IMPORTANT]
>Now Add your Delays And Configs Then Connect. Make Sure to Reconnect LAN/WLAN interfaces After Start.<br><br>To route All Traffic Through Proxy:  **TCP Ports** must be Set To **All** In **Other Settings** And in Main Page The Proxy must Set to: **Global Proxy.** Otherwise There maybe DNS Leaks. This Is The Setting For Global Proxy Routing.<br><br>
**For Exclusion List-->No Proxy** <br><br>
1.First Delete **Existing Shunt Rule** From Nodes And Make New Xray Shunt. Then Add New ACL Rule In **Access Control** I And Then Set TCP/UDP Nodes to Xray Shunt.<br>
2.Now Select Switch to GFW List And Make China Connection As **Direct Coonection** <br>
3.Now You Can Add Interface Source as **lan** and Exclude Desired MAC Addresses to Proxy.

>[!TIP]
>Just Like Above You Can route Any Device Through Any Node but Require Some CPU Power To Do So.(Change TCP/UDP Node)

**Now Test Using [Ip-Leak](https://ipleak.net/) / [Speedtest.net](https://www.speedtest.net/) For Location**

### V2Ray-A For Better UI/But Poor Resource Management 

**Download Required Package/Key**
```
wget https://downloads.sourceforge.net/project/v2raya/openwrt/v2raya.pub -O /etc/opkg/keys/94cc2a834fb0aa03
```

**Add Feeds To WRT (v2ray Feeds)-If You Have Already Installed Passwall Skip this Step**
```
echo "src/gz v2raya https://downloads.sourceforge.net/project/v2raya/openwrt/$(. /etc/openwrt_release && echo "$DISTRIB_ARCH")" | tee -a "/etc/opkg/customfeeds.conf"
```

**Reload Feeds**
```
opkg update
```
**Now Install V2rayA-Dependency Package**
```
opkg install v2raya
opkg install kmod-nft-tproxy
opkg install xray-core
```

**Luci App Install V2ray-A**
```
opkg install luci-app-v2raya
```

**Reboot For Optional Stability**

![Luci V2rayA](https://live.staticflickr.com/65535/54791457850_0e30b69b6f_b.jpg)

### V2ray A Dashboard
>[!NOTE]
>It Is Usally Disabled by Default And you May Enable And Open Web interface its Usually At Routerip:2017 And And From That interface you Can Configure All v2ray (Multisocket) Rules. Make Sure to Create Uname And Pass on First login.

**Now Import Settings like VLESS/VMESS Then Change Settings As Follows**

![V2rayA](https://live.staticflickr.com/65535/54791457750_cb2f3b7d81_b.jpg)

**Settings (Proxy Configs) For V2rayA**

![Proxy V2rayA](https://live.staticflickr.com/65535/54783098227_98c34fd613_z.jpg)

**Now Test Using [Ip-Leak](https://ipleak.net/) / [Speedtest.net](https://www.speedtest.net/) For Location**

## Step 12 - Luci Mobile Management Interface/CPU Plugin

>[!TIP]
>This Is The Cleanest Management UI That You Can Find Just Download From Play Store And Log In Using Router Credentials.

**Play Store Link: [Luci_Mobile](https://play.google.com/store/apps/details?id=com.cogwheel.LuCIMobile&pli=1)**


**Luci Mobile View**

![Luci Mobile](https://live.staticflickr.com/65535/54793147630_271f7c810d_c.jpg)

**CPU Plugin Package On Luci Status Page**

**Install using This**
```
wget --no-check-certificate -O /tmp/luci-app-cpu-status_0.6.1-r1_all.ipk https://github.com/gSpotx2f/packages-openwrt/raw/master/current/luci-app-cpu-status_0.6.1-r1_all.ipk
opkg install /tmp/luci-app-cpu-status_0.6.1-r1_all.ipk
rm /tmp/luci-app-cpu-status_0.6.1-r1_all.ipk
/etc/init.d/rpcd reload
```

>[!TIP]
>Now Sign out From Luci And Sign Back In You Can See The CPU Satatus Of Each CPU Core .

## Step 13 Samba4 Server At Shared Storeage  /Overlay.
>[!CAUTION]
>To Install Samba4 As Shared Storeage You Must first Have USB Setup As Above and Mount point must be /overlay for Samba We Weill Make Permissions And Create Directory for Optimized Usage. 

```
ls /overlay
mkdir /overlay/share
chmod 777 /overlay/share
ls -l /overlay/

```
>[!NOTE]
>Check for share Directory it must Have All The Permissions (drwxrwxrwx ) to Read Wand Write .Do Not Change Permissions If you Want Read only.

**Install Required Packages**
```
opkg update
opkg install samba4-server
opkg install luci-app-samba4
reboot
```

**Now Add Name And Path As Follows Path > /overlay/share**

![Samba 4 Add Path/Name](https://live.staticflickr.com/65535/54812433446_fa77937e6a_b.jpg)


**Reboot for Configure refresh**

**Add Password Access For Server**

```
vi /etc/passwd
```
**Add This line at The End With Names <newuser> to Replace with Your Own**

```
newuser:*:1000:65534:newuser:/var:/bin/false
```

**Add Passsword For New User <Newuser> replace With your username**
```
smbpasswd -a newuser
```
**Restart Samba4 Service**

```
service samba4 restart
```

>[!IMPORTANT]
>Share Dir Path **/overlay/share**

**Now Attach Details And path like This**

![Final Settings Samba4](https://live.staticflickr.com/65535/54812433451_74593fe041_b.jpg)

>[!TIP]
>Now You Can Access Folder Remotely with <br>\\\192.168.2.1\LANUSB (LANUSB can Be Differ)
<br>
Then Sign In With your Credentials At Windows/ Linux PC

## Step 14 Statistics Tab /Terminal Install.
>[!IMPORTANT]
>This App is Capable Of Monitoring CPU/RAM/Network Interfaces Install it Using Following Commands. Already Installed on My Image

```
opkg update
opkg install luci-app-statistics
opkg install luci-app-ttyd
```

**View Of Statistics APP**

![Statistics APP](https://live.staticflickr.com/65535/54812776760_b3797d7617_b.jpg)

## Acknolwlegements 

This project would not be possible without the hard work and dedication of the OpenWrt community. A special thank you goes to:

4IceG: For the incredible work on 3ginfo-lite, luci-app-modemband, and the Modem-extras repository. Your tools are the backbone of the modem monitoring features in this build.

R1BNC: For the extensive video tutorials, guides, and inspiration regarding 4G/5G router modifications and OpenWrt customization.
The OpenWrt Community: To all the developers, maintainers, and builders who keep this open-source ecosystem alive and thriving.

Project-DiluWRT is built on the shoulders of giants. Thank you!

## Your Support is Much Appriciated:

<p><a href="https://www.buymeacoffee.com/dilu122x"> <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="50" width="210" alt="dilu122x" /></a></p>