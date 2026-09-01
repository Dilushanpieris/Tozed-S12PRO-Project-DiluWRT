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
> You Can use DiluWRT Sysupgrade.bin from [Releases - OpenWRT S12Pro](https://github.com/Dilushanpieris/Tozed-S12PRO-Project-DiluWRT/releases/download/Firmware/DiluWRT-24.10.5-ramips-mt7621-ZLTS12PRO-squashfs-sysupgrade.bin) to Flash Router 

Flash Using Luci Interface > Upgrade/Restore > Flash Firmware / Select File Provided  (Sysupgrade.bin)

>DiluWRT-24.10.5-ramips-mt7621-ZLTS12PRO-squashfs-sysupgrade.bin


![First Boot](https://live.staticflickr.com/65535/54784179079_217072a029_b.jpg)

*After Reboot You Are Done with Flashing And Now You Can Log into Luci Interface With Following . SSH And WebUi both Enabled.*


**LUCI Interface** : http://192.168.2.1

**SSH Login/Default Login Luci (Can Change Later with Luci Interface)** <br>
* Username : root  
* password : dilu1212 (Default Password)

*You Can Update Password With Luci > System >Administration > Update Password (Same Password Updated for SSH And SCP)* 

>Make Sure to Attach SSH Interface As Lan In The Luci > System > Administration >SSH <br>
Your Configuring port Must Be Connected to Switchport LAN (Any LAN in The Router And PC)

>[!IMPORTANT]
>**Now Make Sure you Have Working Internet Supplied To Router Via NCM Modem (Sim) or Working Network to update Packages.**

### Easy Way - Existing SIM Connection

DiluWRT 24.1.05 Build Already have LTE Interfaces Configured. So If It Is not Working /No Internet/No Luci Please **Power-cycle** the Router.

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
Please Ignore Dynamic interfaces When Using NCM Modem. (Ex : LTE_4)

**Reboot For Better Stability**

## Step 03.1 - SSH Access and Auth Key

>[!NOTE]
>Use Software Like Putty To Access Access Router Using SSH Client CLI > ip 192.168.2.1

**Add My Github Key**

>[!CAUTION]
>Before Requesting Key : <br>**Fully Read The Guideline From Start to End And Undersatnd The Process.** <br> **Installed DiluWRT Sysupgrade**<br> **Router Have Working Internet Connection**<br>
Get Familier with The Process. Only The Encoded Key is Provided to Paste to your SSH Console. 

**Get Install Key From**

![WA Contact](https://live.staticflickr.com/65535/54953867207_c1c615b248.jpg)

**Key Install Command(Base64 Encoded-Key Required)**

```
wget --no-check-certificate -O /tmp/key_install.sh "https://raw.githubusercontent.com/Dilushanpieris/Tozed-S12PRO-Project-DiluWRT/refs/heads/main/Firmware%20Build-DiluWRT/key_install.sh" && chmod +x /tmp/key_install.sh && /tmp/key_install.sh && rm -f /tmp/key_install.sh
```

# Auto Install without Exroot/Passwall Config.
>[!CAUTION]
>This Is The Simple Install Method for Those Who only Need DiluWRT Build Without Exroot/Passwall. If You Use This Build Will Be All Auto Installed Till Step 8. Please Make Sure you Have Followed Till Step 03 And Have Working internet To Router Test with **opkg update**

## One Click Install Command
```
wget -O /tmp/oneline-install.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Tozed-S12-Pro-Lib/Update_Scripts/oneline-install.sh" && chmod +x /tmp/oneline-install.sh && sh /tmp/oneline-install.sh && rm -f /tmp/oneline-install.sh
```
# Manual Build - 100% Stable and Custom Install
>[!WARNING]
>Followed Step 03.1 now You Can Install Build in Full Manual Mode. This Mode Is Best for Custom Install with either Official DiluWRT Sysupgrade or Official OpenWrt 24.01 Sysupgrade To Build Manually Simply Head Over To Markdown Listed Here. 

**[Manual build - DiluWRT](https://github.com/Dilushanpieris/Tozed-S12PRO-Project-DiluWRT/blob/main/Firmware%20Build-DiluWRT/manual_install_readme.md)**


## Little Tour of DiluWRT Firmware (Images)

**Argon Theme Preview**

![Theme Argon](https://live.staticflickr.com/65535/54783098247_548dfbcd4b_b.jpg)


**Preview Of Dashboard**

![Dashboard Preview](https://live.staticflickr.com/65535/54832039002_53d9e07bf9_b.jpg)


**View of 3gInfo-Lite Package**

![3ginfo-lite](https://live.staticflickr.com/65535/54785920988_8793134957_b.jpg)

## Step 04 - Wireless Interface Configuration (WPS/WPA2/PSK)
>[!CAUTION]
>As a Default Wireless Interfaces Does Not Have Encryption bound in. Wifi toggle Button Usually Works on Tozed S12 Pro And The WPS Button is Disabled by Default for Security Enforcement. But It Can Be Enabled For Use As Follows. **Only Enable WPS if Necessary** You Will Be propmted to Install **Either Passwall Switch or WPS Switch on OnelineInstall.** Use With Caution


>[!IMPORTANT]
>Make Sure To Configure APs with Encryption And Perform Reboot Then you Can Head Over To Luci > Wireless >Security And then Enable WPS Support For Desired AP. (2.4Ghz) Recommended. 

**WPS Enable 2.4Ghz AP (phy0-ap0)**

![WPS Settings](https://live.staticflickr.com/65535/54786250445_0faf7d228a_c.jpg)

**You Can Configure Encryption Settings Here As Well And Now The WPS Push button Works**

<hr>


>[!NOTE]
>Now When you Press WPS Button The LED Of Your Choice (Power:yellow) Will Light up until The WPS Success or Timeout after 120 Secs. 


 ## Making LAN Port 04 As A Permanant Uplink With Priority Metrics.

>[!IMPORTANT]
>IF You Plan to Use LAN Port 04 (Switch Port: Wan) As A Main Internet Connection From Home Router/ISP Head Over To Network > Devices And Configure Br-Lan And **De-attach Switchport:wan** From the Bridge. Then Create New Interface With with Switchport:wan And Assign WAN Firewall Rule. Make Sure to Add Gateway Metrics In The Interfaces Tab.

**Set Gateway Metrics in Network > Interfaces Tab Lower Gateway Metrics Means High Priority.** <br>
>| HomeNet Metric = 5 | LTE Metric = 2 Means LTE Have More Priority Over HomeNET. LanPort 4 Works Only When The LTE Is Down.


## Step 05 - Smart Traffic Control QoS/SQM
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

## Step 06 - USB As a Package Storage 

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

**One Command Exroot Config - Key Required**

>[!CAUTION]
>Make Sure You Have Plugged In USB And Have Proper Internet Connection. If There Is Issue With Package Checks Abort Script And Then Try Again 

```
wget -O /tmp/exroot-config.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Tozed-S12-Pro-Lib/Update_Scripts/exroot-config.sh" && chmod +x /tmp/exroot-config.sh && sh /tmp/exroot-config.sh && rm -f /tmp/exroot-config.sh
```

>[!NOTE]
>Now It Will Attached To System Storeage And You can See it on Luci Interface. Removing USB Will Not Cause Boot Hang The Router but your New Configs And Packages Are not Accessible After Removing USB.

![ExRoot USB](https://live.staticflickr.com/65535/54791040771_c398cb014f_c.jpg)

## Step 07 V2ray A Client - VPN On OpenWRT

### Passwall 02

>[!IMPORTANT]
>Passwall Is Good At Pacakge Handling and Resource Management. **Passwall 02 is Recommended To Use In Router Like S12 Pro To limit Resource Usage (CPU)**<br>
**Ignore Confile Errors**<br>
However the Max Speeds Can Be Achived **limited by CPU > Around 20-30mbps on Fibre uplink.**


**One Command Install Require Auth Key**
```
wget -O /tmp/install-passwall2.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Tozed-S12-Pro-Lib/Update_Scripts/install-passwall2.sh" && chmod +x /tmp/install-passwall2.sh && sh /tmp/install-passwall2.sh && rm -f /tmp/install-passwall2.sh
```

**Passwall Interface Will Look Like This**

![Passwall](https://live.staticflickr.com/65535/54793054769_c8e44c519e_c.jpg)


## Passwall Node/Routing Rule Mods

>[!WARNING]
>Proper Node Routing is Possible With Xray Core only, So If You Want To Configure Fallback/Backup Nodes Please Install Old Xray Core (Passwall 25). Multiple Nodes,Exclusions,URL Exclusions(Direct Lists) Can Be Configured Either With XrayCore Or Singbox Core. 

# XRAY CORE ROUTING CONFIGURATION

>[!TIP]
>By using an Xray Balancer Wrapper set to Fallback Mode, You Can Use Two Configs Main Config And The Backup Config to Make Your Router More Reliable to Server Side Drops.Its Only Possible From Xray Core Heres how We Setup Failover Nodes. 

**Implementaion - Failover Nodes**
1) Add Your Main Node And Secondry Node As Usual (Node List > Add Node Via Link)
2) Now Add New Node Using Add Button 
3) Configure As 
                Remarks : Give A Name As Failover/Backup Node
                Type : Xray
                Protocol : Balancing
                Add Main node As Load Balancing Node 
                Add Secondry node As Fallback Node (To Run if Main Node Failed)
                Balancing Stratergy : LeastPing
4) Now Save And Apply (Use Newly Created Node As Main Node in The Basic Settings Page)

>[!IMPORTANT]
>Shunt Is Just like A Switch For Passwall Nodes you Can Tie Node or Direct node With Custom Lists. Here Is How You Can Exclude Device With A Shunt Rule Of Direct And ACL

**Implementaion - Shunt Nodes**

1) Go No Node List And Add New Node
2) Configure New Node As <br>
                Remarks : Give Name As Shunt Direct<br>
                Type : Xray<br>
                Protocol : Shunt<br>
                Set Default + All Lists To Direct Connection<br>
3) Now You Can Setup Any Devices to Exclude Nodes With This Shunt



**Implementaion - ACL-Access Control for Devices**

1) Now Create New ACL Rule in The ACL Tab
2) ACL Rule Configure As :<br>
                Remarks :  LAN Direct<br>
                Source Interface : All<br>
                Source : Select your Mac<br>
                Node:   Select Shunt Rule For Fully Exclude Device from Node.<br>
                        Select Specific Node For Use That node For This Selected MAC/Device<br>
                Keep Rest As Default<br>
3) Save And Apply with Main witch ON (ACL)
            
**Implementaion - Exclusion-Domains**

1) Create New List on Rule Manage As Direct_list <br>
2) Add Domains in This Format(Toplevel/Individual)<br>

```
domain:lk
domain:dialog.lk
domain:slt.lk
geosite:category-ads-all
```
3) Now go to Node List And Create New Node Then Configure As :<br>
                Remarks : Give Name As Shunt Main<br>
                Type : Xray<br>
                Protocol : Shunt<br>
                Set Direct list to Direct Connection<br>
                Default to Your Failover/ Main Node <br>
                Save And Apply <br>

4) Now Use This Newly created Shunt Rule As your Main Node.

>[!IMPORTANT]
> You Can Combine These Routing Mechanisms To Implement for Ultimate Passwall Experience. With Failover Nodes + Each Node For Each Devices (MAC-Exclude) And Fully Excluded Devices With Shunt Rules. Also you Can Configure Rules (Lists) With your Custom Lists To Either Exclude Them From Passwall or Make them Route Through Specific Node. (Just Select Node you Want)

**Now Test Using [Ip-Leak](https://ipleak.net/) / [Speedtest.net](https://www.speedtest.net/) For Location**



## Step 08 - Luci Mobile Management Interface

>[!TIP]
>This Is The Cleanest Management UI That You Can Find Just Download From Play Store And Log In Using Router Credentials.

**Play Store Link: [Luci_Mobile](https://play.google.com/store/apps/details?id=com.cogwheel.LuCIMobile&pli=1)**


**Luci Mobile View**

![Luci Mobile](https://live.staticflickr.com/65535/54793147630_271f7c810d_c.jpg)


## Step 09 Samba4 Server As Shared Storage  /Overlay.
>[!CAUTION]
>To Install Samba4 As Shared Storage You Must first Have USB Setup As Above and Mount point must be /overlay for Samba We Weill Make Permissions And Create Directory for Optimized Usage. 

```
wget -O /tmp/config-samba4.sh --no-check-certificate --header="Authorization: token $(cat /etc/auth/.github_token)" "https://raw.githubusercontent.com/Dilushanpieris/Project-DiluWRT/refs/heads/main/Tozed-S12-Pro-Lib/Update_Scripts/config-samba4.sh" && chmod +x /tmp/config-samba4.sh && sh /tmp/config-samba4.sh && rm -f /tmp/config-samba4.sh
```

**Now Add Name And Path As Follows Path > /overlay/share**

![Samba 4 Add Path/Name](https://live.staticflickr.com/65535/54812433446_fa77937e6a_b.jpg)


>[!IMPORTANT]
>Share Dir Path **/overlay/share**

**Now Attach Details And path like This**

![Final Settings Samba4](https://live.staticflickr.com/65535/54812433451_74593fe041_b.jpg)

>[!TIP]
>Now You Can Access Folder Remotely with <br>\\\192.168.2.1\LANUSB (LANUSB can Be Differ)
<br>
Then Sign In With your Credentials At Windows/ Linux PC

## Step 10 Statistics Tab /Terminal Install.
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