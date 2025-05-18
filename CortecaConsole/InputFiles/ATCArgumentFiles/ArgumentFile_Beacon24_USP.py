L2_Whitelisting_Username="E4-DA-DF-D5-26-44"
L2_Whitelisting_Password="hztf7Hd8YT"
CLI_Prompt="root@Beacon 24:/configs/overlay/home/superadmin"
Execution = "Smoke"

ssh_prompt="root@Beacon 24:/configs/overlay/home/superadmin"

########## Change bconType to 'WJ' for WJ, 'B3' for B3.  ########## 
Root_bconType = 'B24'
Ext1_bconType = 'B24'
Ext2_bconType = 'B24'
#Ext3_bconType = 'B10'
ont_ip='192.168.1.254'
###################################################################

subMac="E4-DA-DF-D5-26-44"
subName="smoke"
subId=""
subEmail=""
subSerial=""

RootDeviceType = { "B1" : "Beacon 1",
				   "B3" : "Beacon 3",
				   "B11" : "Beacon 1.1",
				   "B2" : "Beacon 10",
				   "B6" : "Beacon 6",
				   "B10" : "Beacon 10",
                   "BG6" : "Beacon G6",
                   "BG62" : "Beacon G62",
                   "B24"  : "Beacon 24",
				   "HA140WB" : "HA-140W-B",
				   "5G31" : "FastMile 5G Gateway 3.1",
				   "5G32" : "FastMile 5G Gateway 3.2",
				   "5G3" : "FastMile 5G Gateway 3",
				   "G3" : "Gateway 3",
				   "G140WC" : "G-140W-C",
				   "G140WH" : "G-140W-H",
				   "G240WG" : "G-240W-G",
				   "G240WJ" : "G-240W-J",
				   "G0425GA" : "G-0425G-A",
				   "G1425GA" : "G-1425G-A",
				   "G2425GA" : "G-2425G-A",
				   "G2425GB" : "G-2425G-B",
				   "B10" : "G-2426G-A",
				   "G2426GB" : "G-2426G-B",
				   "XS2426GA" : "XS-2426G-A" 
				   }
				   
ExtDeviceType = { "B1" : "Beacon 1",
				   "B3" : "Beacon 3",
			       "B11" : "Beacon 1.1",
				   "B10" : "Beacon 10",
			       "B2" : "Beacon 10",
			       "B6" : "Beacon 6",
                   "B24" : "Beacon 24"}


############## Change 'yes' or 'no' based on node presence  ################ 
L2_Bridge = 'No' ;# Yes - L2 Bridge Isolation, No - RGW or AP_Bridge Mode cases
Migration = 'No' ;# Yes - OTA Migration, No - Non OTA Migration Cases
Root_presence = 'yes'
Ext1_presence = 'yes'
Ext2_presence = 'yes'
Ext3_presence = 'no'
Whitelisting_Usernmae = ['E4-DA-DF-D5-26-44','40-E1-E4-2D-C2-E1','40-E1-E4-2D-C2-C1' ] ##NEW variable
Whitelisting_Password = ['qRt5dpbhdZ','nH7kvPKa5f','Xepq5xHDJk'] #NEW variable

###ALCLB278FA2B,ALCLB278FA2D
# Mesh_Nodes = ['Root', 'Ext1', 'Ext2'] ;# Remove or add based on above yes/no
#Mesh_Nodes = ['Root', 'Ext1'] ;# Remove or add based on above yes/no 
#Mesh_Nodes = ['Root'] ;# Remove or add based on above yes/no
#############################################################################
if Root_bconType == 'B3' or Root_bconType == 'B1':
    Root_Type = 'Beacon'
    Ext1_Type = 'Beacon'
    Ext2_Type = 'Beacon'
    extender1_Type = 'Beacon'
    extender2_Type = 'Beacon'
elif Root_bconType == '5G' :
    Root_Type = '5G31'  
    Ext1_Type = 'Beacon'
    Ext2_Type = 'Beacon'
    extender1_Type = 'Beacon'
    extender2_Type = 'Beacon'
else :
    Root_Type = 'ONT'
    Ext1_Type = 'Beacon'
    Ext2_Type = 'Beacon'
    extender1_Type = 'Beacon'
    extender2_Type = 'Beacon'

IP_Address_type ='IPv4'

DefaultTenant = {'URL':'https://homeconsole1.stg.homewifi.nokia.com/', 
'uname':'demouserl2', 
'pswd':'demouserl2'}

 
#Values accepted Beacon (for dark webgui), Pureview for pureview webgui, and ONT for legacy webgui.
Root_Web_GUI_Type = 'Pureview'
Extender_Web_GUI_Type = 'Pureview'
 
#DeviceStream Mention HA or USP
DeviceStream = 'USP'
 

## Old Mobile App or Old CAP or NEW Mobile App or NEW CAP
CAP_Version = 'AIOC' ;# 1 - For CAP Before Sept 2019. 2 - For CAP from Oct 2019. L1 - For L1 Portal from Apr 2020.
MAPP_Version = '2' ;# 1 - For MAPP Before Sept 2019. 2 - For MAPP from Oct 2019. 
MULTI_TENANT = 'False' ;# Set to 'True' when running DeviceAssociation cases in Multi-Tenant enable platform
TENANT_NAME = 'nokiahwstg';  
   
## Build information - Change below variables for each image and HW [B3/G3]
ont_sw_path = 'C:\\Regression\\Builds\\LatestBuilds'
preConfigFile2 = 'BoengEnabled.txt'
file_name_B6 = '3FE49062HJLI76'
file_name_B6 = '3FE49062HJLI76'
file_name_B6 = '3FE49062HJLI76'
file_name_B6 = '3FE49062HJLI76'

hw_version = '3FE47856EAAA' ;# ritool dump | grep HardwareVersion
firmware_date = '06/15/2021 19:14' ; # cat /etc/buildinfo | grep BUILDDATE


ms_release = 'BBD_2101Q.144'
ms_release_old = 'BBD_2102Q.242'

folderName = '202' # To represent 2018, 2019 etc inside ONT flash folder [Collects ONT logs during script failuer]

videologpath_B6 = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\outputs\\videopath\\'
videologpath = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\outputs\\videopath\\'
downloads = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\outputs\\downloads'
mobile_app_path = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\outputs\\mapp'
GUI_Files_Path = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\WHW\\GUI_Files'
Python_Path = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\WHW\\Selectors\\Python37'
FTP_Path = 'C:\\FtpLogs'
AdBlock_Ext_Path = 'C:\\Users\\ladmin\\AppData\\Local\\Google\\Chrome\\User Data\\Default\\Extensions\\gighmmpiobklfepjocnamgkkbiglidom\\5.3.3_0.crx'

L1_Portal_path = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\WHW\\Selectors\\'
L1_ScreenShots = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\outputs\\SnapShots\\L1'
L2_ScreenShots = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\outputs\\SnapShots\\L2'
L1API_Files_Path = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\WHW\\5FON-L1\\L1Portal'
New_L2_Portal_path = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\WHW\\Selectors\\L2_New_Selectors.txt'
tshark_path 		= 'C:\\"Program Files"\\Wireshark'
network_interface  = 'Ethernet 2' ;# take from 'netsh interface show interface'
proxyflag = 'true' ;# set to 'true' if running from LAB/TPC, 'false' if running from home
ATC_L2_Profile = "EFO_L2_Profile"
comport = '23' ;# 22 for SSH, 23 for Telnet
cliport = '23' ;
## Mobile app version info
mobile_app = { 'store_vinfo':'3.210209.00', \
                'build_info':'3FE47257ACAF03', \
                'ver_info':'June_2021_209'}

## Route/Bridge Mode
BridgeModeConfig = 'no'
ONTEthPort = "Ethernet 5" ;# take from 'netsh interface show interface'
bandsteer_scale = 'yes'
CheckCore = 'no' ;# core presence to be checked
DebugLogs = 'no' ;# Debug logs to take in root and extenders
Root_WAN_VLANID = '981' ;# Change to 819 or as required
Root_LAN_ToLaptop= '0' ;# 0-LAN1, 1-LAN2, 2-LAN3. Port Connecting to framework laptop
AIS_Enabled = 'no'
Migration = 'no'
boardModel = 'Qualcomm' ; # MTK for B1 and other MTK boards, Qualcomm for B1/B3 and other Qualcomm boards
###########################################################################################################

Root_wifi_Clients = '2'
Ext2_wifi_Clients = '1'

defaultSpeedTestMode="TR143"
defaultServer="13.233.92.195"

# meshNodes=['Ext1', 'Ext2', 'Ext3']
meshNodes=['Ext1', 'Ext2']
## ONT information
Root	 = {'ip':'192.168.0.156',  \
                   'mac':'E4:DA:DF:D5:26:44', \
                   'temp_ip':'192.168.18.1', \
                   'mac1':'E4-DA-DF-D5-26-44',\
                   'model':'Beacon 24', \
                   'currentFirmware':'3TN00628IJMI07',\
                   'HWModel':"Nokia WiFi Beacon 24",\
                   'model_L2':'Nokia WiFi Beacon 24',\
                   'router-id':'88481479135488',\
                   'serial_num':'ALCLB2997E8D', \
                   'gui_url':'http://192.168.0.156', \
                   'gui_username':'superadmin', \
                   'gui_password':'Yeeuy28=kq', \
                   'gui_Normal_User':'admin', \
                   'gui_Normal_User_pwd':'hztf7Hd8YT', \
                   'gui_type':'B24', \
                    'bconType':'B24', \
                   'ssid_defa_name':'SINGTEL-2644', \
                   'ssid_defa_password':'qRt5dpbhdZ', \
                   'ssid_user_defi_name':'E2E-Auto-B3-Setup1', \
                   'ssid_user_defi_password':'ABCD12345', \
                   'app_username':'admin', \
                   'app_password':'hztf7Hd8YT', \
                   'opid':'NKBU', \
                   'unium_port':'18090', \
                   'Type': 'AONT', \
                   'country_id':'sg', \
                   'telnet_port':'23', \
                   'telnet_username':'superadmin', \
                   'telnet_password':'Yeeuy28=kq', \
                   'telnet_vtysh':'EQITD+e10n1cC5syzLGg9QgKAlWp5TaoTX2HIfKBnuJikZ0=', \
                   'product_code':'3FE49062', \
                   'ssid_defa_name_l2':'SINGTEL-2644', \
                   'ssid_defa_password_l2':'qRt5dpbhdZ', \
                   'ssid_udef_name_l2':'L2_Bridge_E2E', \
                   'guest_ssid_name':'SINGTEL-2644_Guest' , \
                    'guest_ssid_pass':'Qwerty123@',\
                    'TopoDefName':'Root', \
					'defa_frn_name':'BEACON 6 HA-0336G-A (80-AB-4D-FE-EC-80)', \
					'defa_frn_name':'Study', \
					'defa_frn_name_gui':'Bridge', \
					'defa_frn_name1':'Kitchen', \
					'udefi_frn_name':'Root', \
					'ssid_defa_name_l2':'NOKIA-6450-4', \
					'ssid_defa_password_l2':'12345678', \
					'ssid_udef_name_l2':'L2_Bridge_E2E', \
					'L2_LanPort':'2', \
					'L2_SsidPort24':'4', \
					'L2_SsidPort5':'8', \
					'L2_LanPort_1':'3', \
					'L2_SsidPort24_1':'3', \
					'L2_SsidPort5_1':'7', \
					'L2_vlan':'100', \
					'L2_SubNet':'192.168.99.',\
                   'L2_vlan':'100', \
                   'L2_LanPort':'2', \
                   'L2_LanPort_1':'3', \
                   'L2_SsidPort24':'4', \
                   'L2_SsidPort5':'8', \
                   'L2_SubNet':'192.168.99.',}

				   
Ext1        = {'ip':'192.168.0.202', \
                   'model':'Nokia WiFi Beacon 24', \
                   'model_L2':'Nokia WiFi Beacon 24', \
                   'temp_ip':'192.168.18.5', \
                   'gui_url1':'http://192.168.0.202', \
                   'mac':'E4:DA:DF:D5:25:A4', \
                   'mac1':'E4-DA-DF-D5-25-A4', \
                   'router-id':'159899793727544',\
                   'serial_num':'ALCLB2997E83', \
                   'wds_mac':'38:A0:67:FC:0F:11', \
                   'gui_url':'http://192.168.18.5', \
                   'gui_username':'superadmin', \
                   'gui_password':'Yeeuy28=kq', \
                   'gui_type':'Beacon 6', \
                   'ssid_defa_name':'SINGTEL-2644', \
                   'ssid_defa_password':'qRt5dpbhdZ', \
                    'bconType':'B24', \
                   'opid':'BSTL', \
                   'unium_port':'18090', \
                   'country_id':'sg', \
                   'telnet_port':'23', \
                   'telnet_username':'superadmin', \
                   'telnet_password':'Yeeuy28=kq', \
                   'telnet_vtysh':'EQKlXEA2L4YiwXybqtYUIQ7eAhciE1v2TzjwVEMqTM/jW9U=', \
                   'product_code':'3FE49062', \
                   'TopoDefName':'Kitchen', \
					'defa_frn_name':'BEACON 6 HA-0336G-A (DC-8D-8A-FF-BD-73)', \
					'defa_frn_name1':'APSND9C8', \
					'defa_frn_name_gui':'APSND9C8', \
                   'udefi_frn_name':'Kitchen',\
                   'defa_frn_name1':'APSND9C8'}
				   
Ext2       = {'ip':'192.168.0.238', \
                   'temp_ip':'192.168.0.238', \
                   'gui_url1':'http://192.168.0.238', \
                   'model':'BEACON 6 HA-0336G-A', \
					'model_L2':'Nokia WiFi Beacon 24', \
                   'mac':'E4:DA:DF:D5:27:64', \
                   'mac1':'E4-DA-DF-D5-27-64', \
                   'router-id':'54192058638392', \
                   'serial_num':'ALCLB2997E9F', \
                   'wds_mac':'fc:8f:7d:ef:73:78', \
                   'gui_url':'http://192.168.18.4', \
                   'gui_username':'superadmin', \
                   'gui_password':'Yeeuy28=kq',
                    'bconType':'B24', \
                   'gui_type':'Beacon 6', \
                   'ssid_defa_name':'SINGTEL-2644', \
                   'ssid_defa_password':'qRt5dpbhdZ', \
                   'gui_type':'Beacon 6', \
                   'opid':'BSTL', \
                   'unium_port':'18090', \
                   'country_id':'sg', \
                   'telnet_port':'23', \
                   'telnet_username':'superadmin', \
                   'telnet_password':'Yeeuy28=kq', \
                   'telnet_vtysh':'EQInqtllE/PHWNwSu8HU8YKGAYro8siGMSU3/Q9FHgoXL8Q=', \
                   'product_code':'3FE49062', \
				   'TopoDefName':'Dining Room', \
					'defa_frn_name':'Dining Room', \
					'defa_frn_name':'Dining Room', \
					'defa_frn_name1':'APSND616', \
					'defa_frn_name_gui':'APSND616', \
                   'udefi_frn_name':'Dining Room'}


                   


# WDS info
Root_wl0_mac = '00-11-22-33-23-5D'
Root_wl04_mac = '72-11-22-33-23-58'
Root_wl1_mac = '00-11-22-33-23-59'
Root_wl14_mac = '6A-11-22-33-23-5C'

Ext1_wl0_mac = 'F0-68-65-13-FF-BD'
Ext1_wl04_mac = '72-68-65-13-FF-B8'
Ext1_wl1_mac = 'F0-68-65-13-FF-B9'
Ext1_wl14_mac = '6A-68-65-13-FF-BC'

Ext2_wl0_mac = '88-B3-62-FE-77-AF'
Ext2_wl04_mac = '62-B3-62-FE-77-AA'
Ext2_wl1_mac = '88-B3-62-FE-77-AB'
Ext2_wl14_mac = '72-B3-62-FE-77-AE'


# WLANConfiguration_Verification - Radio/ssid settings
## cfgcli -G InternetGatewayDevice.LANDevice.1.WLANConfiguration.1. | grep Name
## cfgcli -G InternetGatewayDevice.LANDevice.1.WLANConfiguration.1. | grep PossibleChannels
## cfgcli -G InternetGatewayDevice.LANDevice.1.WLANConfiguration.1. | grep OperatingFrequencyBand
radio_24_chList = '1,2,3,4,5,6,7,8,9,10,11;1,2,3,4,5,6,7,8,9,10,11'
ssid1_Name = 'ath1' ;# ra0, wl1
ssid2_Name = 'ath11' ;# ra0, wl1
ssid3_Name = 'ath12' ;# ra0, wl1
ssid4_Name = 'ath13' ;# ra0, wl1
radio_5_chList = '36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128,132,136,140,149,153,157,161,165;36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128,132,136,149,153,157,161;36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128,149,153,157,161'
ssid5_Name = 'ath0' ;# ra1, wl0
ssid6_Name = 'ath01' ;# ra1, wl0
ssid7_Name = 'ath02' ;# ra1, wl0
ssid8_Name = 'ath03' ;# ra1, wl0

				   
## Switch Information - Root and Extenders are connected to the below switch
# Port Info - Port1 - Laptop, Port2 - Root, Port3 - Ext1, Port4 - Ext2
switch          = {'presence':'yes', \
                    'url':'http://192.168.18.200', \
                    'ip':'192.168.18.200', \
                    'mask':'192.168.1.1', \
                    'url1':'http://192.168.1.200', \
                    'ip1':'192.168.1.200', \
                    'mask1':'192.168.1.1', \
                    'password':'password'}

## Attenuator
attenuator      = {'presence':'yes', \
                    'ip':'135.249.61.228', \
                    'Root_Ext1':'1', \
                    'Root_Ext2':'5', \
                    'Ext1_Ext2':'8'}

## PDU - Power cutter 
PDU             = {'presence':'yes', \
                    'ip':'135.249.61.251', \
                    'Root':'3', \
                    'Ext1':'0', \
                    'Ext2':'1', \
                    'Interf':'2', \
                    'Uname':'pi', \
                    'Pass':'raspberry'}


## MRV - L1 Port mapping HUB 
MRV             = {'presence':'no', \
                    'ip':'135.249.61.235', \
                    'Uname':'admin', \
                    'Pass':'admin', \
                    'port1':'1.1.1', \
                    'port2':'1.1.2', \
                    'port3':'1.1.3', \
                    'port4':'1.1.4', \
                    'port5':'1.1.5', \
                    'port6':'1.1.6', \
                    'port7':'1.1.7', \
                    'port8':'1.1.8', \
                    'port9':'1.1.9', \
                    'port10':'1.1.10', \
                    'port11':'1.1.11', \
                    'port12':'1.1.12', \
                    'port13':'1.1.13', \
                    'port14':'1.1.14'}

## DHCP Server Details
dhcp 			= {'ip':'135.249.193.254', \
                    'ip1':'192.168.50.115', \
					'user':'ladmin', \
					'superuser':'root', \
					'password':'T&Dfndpc#123'}

## DNS Details
dns 			= {'wan_static_ip':'192.168.1.2', \
                    'wan_static_mac':'255.255.255.0', \
					'wan_static_gateway':'192.168.1.1', \
					'wan_static_pridns':'192.168.1.1', \
					'wan_static_secdns':'192.168.1.1', \
					'wan_static_terdns':'8.8.8.8'}

## VLC server Details
vlc 			= {'vlc_mgt_ip':'135.249.61.108', \
                    'vlc_server_ip':'192.168.99.2', \
                    'vlc_stream_ip':'230.1.1.1', \
					'vlc_stream_port':'5004'}
					
					
## A240ZA - Interference setup
second_setup	= {'ssid':'NOKIA-6405-11ac', \
					'pswd':'2153801782', \
					'ip':'192.168.4.1', \
					'pass':'2153801782', \
					'vtysh':'3aH7xmEKsjyw', \
					'ssid_grep':'NOKIA-6', \
					'laptop_server':'192.168.4.3', \
					'laptop_uname':'ladmin', \
					'laptop_pswd':'T&Dfndpc#123'}

## iPerf info
iperf       = {'Server':'/cygdrive/c/Users/ladmin/Desktop/iperf-2.0.9-win64', \
                    'Server1':'/cygdrive/c/Users/ladmin/Desktop/', \
                    'Client':'C:\\Users\\vignesh\\Desktop'}
                    		


Account         = {'FirstName':'ATC_SMOKE_B6', \
                   'LastName':'setup', \
                   'Email':'atcsmoke@gmail.com', \
                   'Password':'Nokia@123', \
                   'Key_URL':'https://homeconsole1.stg.homewifi.nokia.com/tenant3', \
                   'userName':'tenant3keycloak', \
                   'password':'tenant3keycloak', \
                   'Mac_add':Root['mac1'], \
                   'KEYCLOAK_URL': 'https://auth.stg.homewifi.nokia.com/sso/admin/tenant3/console', \
                   'KEYCLOAK_REALM': 'tenant3', \
                   'KEYCLOAK_CLIENT_ID': 'portal_nokiahwstg', \
                   'Hie_URL':'https://wifi.pt.nokia.com/v1/bdc/data'}
                   
CAP         = {'URL':'https://homeconsole1.stg.homewifi.nokia.com/tenant3', \
                   'remoteMobileAccess':'https://l1api.stg.homewifi.nokia.com', \
				   'ApiURL':'https://l1api.stg.homewifi.nokia.com', \
                   'L2Server':'https://xca-back.stg.homewifi.nokia.com', \
                   'L1Server':'https://verne.stg.homewifi.nokia.com', \
                   'BoengServer':'https://wifi5.trial.nokia.com', \
                   'ConfigMgr':'https://kwqyeifkpb.execute-api.ap-southeast-1.amazonaws.com/configtest/', \
                   'ConfigMgrKey':'slEksSx4015s9j6K3rvN78QeCGiq4q187AAbZmED', \
                   'UAMServer':'https://portal.wse.trial.nokia.com/505/', \
                   'OTAServer':'https://swupd.wifi.nokia.com', \
                   'OTAPollTime':'0 2 * * *', \
				   'ServerPort':'443', \
                   'OTAActiveTime':'03:00:00', \
                   'uname':'tenant3user', \
                   'pswd':'tenant3user', \
                   'assocUame':'l1assoc', \
				   'assocPswd':'l1assoc'}
                   
'''	   
# CAP
CAP         = {'URL':'https://homeconsole1.stg.homewifi.nokia.com/home', \
                   'remoteMobileAccess':'https://l1api.stg.homewifi.nokia.com', \
				   'ApiURL':'https://l1api.stg.homewifi.nokia.com', \
                   'L2Server':'https://xca-back.stg.homewifi.nokia.com', \
                   'L1Server':'https://verne.stg.homewifi.nokia.com', \
                   'BoengServer':'https://wifi5.trial.nokia.com', \
                   'ConfigMgr':'https://kwqyeifkpb.execute-api.ap-southeast-1.amazonaws.com/configtest/', \
                   'ConfigMgrKey':'slEksSx4015s9j6K3rvN78QeCGiq4q187AAbZmED', \
                   'UAMServer':'https://portal.wse.trial.nokia.com/505/', \
                   'OTAServer':'https://swupd.wifi.nokia.com', \
                   'OTAPollTime':'0 2 * * *', \
				   'ServerPort':'443', \
                   'OTAActiveTime':'03:00:00', \
                   'uname':'tenant3user', \
                   'pswd':'tenant3user', \
                   'assocUame':'l1assoc', \
				   'assocPswd':'l1assoc'}
'''
'''
Account         = {'FirstName':'ATC_B6_NKBU', \
                   'LastName':'setup', \
                   'Email':'atc14@gmail.com', \
                   'Password':'Nokia@123', \
                   'Key_URL':'https://auth.stg.homewifi.nokia.com/sso/admin/nokiahwstg/console/#/realms/nokiahwstg/users', \
                   'userName':'ptkeycloakstg', \
                   'password':'ptkeycloakstg', \
                   'Mac_add':Root_ONT_24['mac1'], \
                   'KEYCLOAK_URL': 'https://auth.stg.homewifi.nokia.com/sso/admin/nokiahwstg/console/%27', \
                   'KEYCLOAK_REALM': 'nokiahwstg', \
                   'KEYCLOAK_CLIENT_ID': 'portal_nokiahwstg', \
                   'Hie_URL':'https://wifi.pt.nokia.com/v1/bdc/data'}
	   
# CAP
CAP         = {'URL':'https://homeconsole.stg.homewifi.nokia.com/', \
                   'remoteMobileAccess':'https://l1api.stg.homewifi.nokia.com', \
				   'ApiURL':'https://l1api.stg.homewifi.nokia.com', \
                   'L2Server':'https://xca-back.stg.homewifi.nokia.com', \
                   'L1Server':'https://verne.stg.homewifi.nokia.com', \
                   'BoengServer':'https://wifi5.trial.nokia.com', \
                   'ConfigMgr':'https://kwqyeifkpb.execute-api.ap-southeast-1.amazonaws.com/configtest/', \
                   'ConfigMgrKey':'slEksSx4015s9j6K3rvN78QeCGiq4q187AAbZmED', \
                   'UAMServer':'https://portal.wse.trial.nokia.com/505/', \
                   'OTAServer':'https://swupd.wifi.nokia.com', \
                   'OTAPollTime':'0 2 * * *', \
				   'ServerPort':'443', \
                   'OTAActiveTime':'03:00:00', \
                   'uname':'demouserl1', \
                   'pswd':'demouserl1', \
                   'assocUame':'l1assoc', \
				   'assocPswd':'l1assoc'}
       
'''

'''
##Kdev1
Account         = {'FirstName':'ATC_B6_NKBU', \
                   'LastName':'Team', \
                   'Email':'atc14@gmail.com', \
                   'Password':'Nokia@123', \
                   'Key_URL':'https://auth.kdev1.homewifi.nokia.com/sso/admin/nokiahwkdev1/console/#/realms/nokiahwkdev1/users', \
                   'userName':'nonadmin', \
                   'password':'nonAdmin2!', \
                   'Mac_add':Root_ONT_24['mac1'], \
                   'KEYCLOAK_URL': 'https://auth.kdev1.homewifi.nokia.com/sso/admin/nokiahwkdev1/console', \
                   'KEYCLOAK_REALM': 'Nokiahwkdev1', \
                   'KEYCLOAK_CLIENT_ID': 'Portal_nokiahwkdev1', \
                   'Hie_URL':'https://wifi.pt.nokia.com/v1/bdc/data'}
   
   
# CAP
CAP         = {'URL':'https://homeportal.kdev1.homewifi.nokia.com/', \
                   'ApiURL':'https://l1api.kdev1.homewifi.nokia.com', \
                   'remoteMobileAccess':'https://l1api.kdev1.homewifi.nokia.com', \
                   'L2Server':'https://xca-back.kdev1.homewifi.nokia.com', \
                   'L1Server':'https://verne.kdev1.homewifi.nokia.com', \
                   'ServerPort':'443', \
                   'BoengServer':'https://wifi5.trial.nokia.com', \
                   'ConfigMgr':'https://kwqyeifkpb.execute-api.ap-southeast-1.amazonaws.com/configtest/', \
                   'ConfigMgrKey':'slEksSx4015s9j6K3rvN78QeCGiq4q187AAbZmED', \
                   'UAMServer':'https://portal.wse.trial.nokia.com/505/', \
                   'OTAServer':'https://swupd.wifi.nokia.com', \
                   'OTAPollTime':'0 2 * * *', \
                   'OTAActiveTime':'03:00:00', \
                   'uname':'demouser', \
				   'pswd':'Demouser@12', \
                   'assocUame':'l1assoc', \
				   'assocPswd':'l1assoc!'}	
'''

					
# CDP information  
cdp             = {'ip':'cdp11.trial.nokia.com/ui', \
                    'port':'8080', \
                    'sub_id':Root['mac1'], \
                    'CDP_URL':'https://cdp11.trial.nokia.com/cwmpWeb/CPEMgt', \
                    'CDP_baseURL':'https://cdp11.trial.nokia.com/ui/#/', \
                    'CDP_AddActionURL':'https://cdp11.trial.nokia.com/mdm-console/app/addAction.action', \
                    'CDP_BackupURL':'https://cdp11.trial.nokia.com/cwmpWeb/backup/', \
                    'CDP_RestoreURL':'https://cdp11.trial.nokia.com/cwmpWeb/backup/restore', \
                    's_username':'admin', \
                    's_password':'admin', \
                    'c_username':'superadmin', \
                    'c_password':'superadmin'}

L2_Portal             = {'url':'https://networkportal.kdev1.homewifi.nokia.com', \
                         'uname':'admin@xcellair.com', \
                         'pwd':'S3cr3TXc3ll@iRAk0unT', \
                         'L2Server':CAP['L2Server'], \
                         'L2Port':CAP['ServerPort']} 
            
L2_Portal_New         = {'url':'https://networkconsole.stg.homewifi.nokia.com/network-console/apps', \
                         'uname':'demouserl2', \
                         'pwd':'demouserl2', \
                         'L2Server':CAP['L2Server'], \
                         'L2Port':CAP['ServerPort']}                            
'''
L2_Portal_New         = {'url':'https://angularportal.kdev1.homewifi.nokia.com/network-console/apps', \
                         'uname':'angularuser', \
                         'pwd':'angularUser@1', \
                         'L2Server':CAP['L2Server'], \
                         'L2Port':CAP['ServerPort']}	
'''                          
## Clients Information
browser = 'gc'
package = 'com.nokia.wifi'



if L2_Bridge == 'Yes' :
    # L2 clients count
    Root_Clients = '2'
    Ext1_Clients = '1'
    Ext2_Clients = '0'
    
    
else :
	# L3 clients count
    Root_Clients = '2'
    Ext1_Clients = '1'
    Ext2_Clients = '0'

Root_wifi_Clients = '1'
Ext1_wifi_Clients = '1'
Ext2_wifi_Clients = '0'


Root_Clients = '2'
Ext1_Clients = '1'
Ext2_Clients = '0'


### Dict Info needs to be updated based on client being used ####
#	MAC 		- Device Mac									#
# 	udid 		- Device Serial Number							#
# 	fName 		- Device friendly name							#
#	platform 	- Android, IoS, etc.							#
#	pfversion 	- OS version									#
#	device 		- Device model name								#
#	phone 		- Manifacturer Info, Nokia, Samsung etc.		#
#	clientType 	- Mobile, Tab, Laptop, Camera etc. 				#
#################################################################




## Root_client1 - is always the Mobile client, used for Onboarding/accessing Nokia App

Root_client1 = { 'MACAddress':'C8:58:95:A4:7B:08', \
                    'MACAddress_L':'c8:58:95:a4:7b:08', \
                    'udid':'ZD2225DW59', \
                    'HostName':'lenovoc8-58-95-a4-7b-08', \
                    'platform':'Android', \
                    'pfversion':'11', \
                    'ModelName':'N/A', \
                    'phone':'SamsungJ7', \
                    'Manufacturer':'Lenovo', \
                    'connectionType':'wifi-signal', \
                    'fp_DeviceType':'Smart Phone', \
                    'fp_SupportedStandard':'802.11ac', \
                    'fp_SupportedBands':'5*', \
                    'fp_TxRate':'6 Mbps', \
                    'fp_RxRate':'433 Mbps', \
                    'fp_InterferenceImpact':'None', \
                    'fp_CriticalDevice':'Noncritical', \
                    'clientType':'Mobile'}

## Root_client2 - is always the Laptop, used for running all the scripts, where framework is installed
Root_client2 = { 'MACAddress':'00:26:55:DB:82:09', \
					'MACAddress_L':'00:26:55:db:82:09', \
					'udid':'NB', \
					'HostName1':'PT-ATC-SMOKE', \
					'HostName':'computer', \
					'platform':'Windows', \
					'pfversion':'9', \
					'ModelName1':'Windows', \
					'ModelName':'Computer', \
					'phone':'HP Laptop', \
					'Manufacturer':'HP', \
					'connectionType':'Ethernet', \
					'fp_DeviceType':'Laptop', \
					'fp_SupportedStandard':'N/A for Ethernet', \
					'fp_SupportedBands':'N/A for Ethernet', \
					'fp_TxRate':'1.0 Gbps', \
					'fp_RxRate':'1.0 Gbps', \
					'fp_InterferenceImpact':'NA for Ethernet', \
					'fp_CriticalDevice':'Noncritical', \
					'clientType':'Desktop'}
Root_client3 = { 'MACAddress':'5C:ED:F4:AF:00:B4', \
                    'MACAddress_L':'5c:ed:f4:af:00:b4', \
                    'udid':'RZ8T90L9LNK', \
                    'HostName':'Galaxy-M32', \
                    'platform':'Android', \
                    'pfversion':'11', \
                    'ModelName':'galaxy', \
                    'phone':'SamsungJ7', \
                    'Manufacturer':'samsung electronics', \
                    'connectionType':'wifi-signal', \
                    'fp_DeviceType':'Smart Phone', \
                    'fp_SupportedStandard':'802.11n', \
                    'fp_SupportedBands':'2.4*', \
                    'fp_TxRate':'6 Mbps', \
                    'fp_RxRate':'433 Mbps', \
                    'fp_InterferenceImpact':'None', \
                    'fp_CriticalDevice':'Noncritical', \
                    'clientType':'Mobile'}
Ext1_client1 = { 'MACAddress':'6C:DD:BC:8D:C4:D3', \
                    'MACAddress_L':'6c:dd:bc:8d:c4:d3', \
                    'udid':'RF8N81C0QSZ', \
                    'HostName':'Galaxy-S10-Lite', \
                    'platform':'Android', \
                    'pfversion':'12', \
                    'ModelName':'Galaxy', \
                    'phone':'SamsungJ7', \
                    'Manufacturer':'samsung electronics', \
                    'connectionType':'wifi-signal', \
                    'fp_DeviceType':'Smart Phone', \
                    'fp_SupportedStandard':'802.11ac', \
                    'fp_SupportedBands':'5*', \
                    'fp_TxRate':'6 Mbps', \
                    'fp_RxRate':'260 Mbps', \
                    'fp_InterferenceImpact':'None', \
                    'fp_CriticalDevice':'Noncritical', \
                    'clientType':'Mobile'}

Ext1_client2 = { 'MACAddress':'B8:27:EB:19:D1:19', \
                 'MACAddress_L':'b8:27:eb:19:d1:19', \
                 'udid':'NB', \
				 'HostName1':'raspberrypi', \
				 'HostName':'raspberrypi', \
				 'platform':'Windows', \
				 'pfversion':'9', \
				 'ModelName1':'Raspberry Pi', \
				 'ModelName':'Raspberry Pi', \
				 'phone':'HP Laptop', \
				 'Manufacturer':'Raspberry Pi', \
				 'connectionType':'Ethernet', \
				 'fp_DeviceType':'Laptop', \
				 'fp_SupportedStandard':'N/A for Ethernet', \
				 'fp_SupportedBands':'N/A for Ethernet', \
				 'fp_TxRate':'1.0 Gbps', \
				 'fp_RxRate':'1.0 Gbps', \
				 'fp_InterferenceImpact':'NA for Ethernet', \
				 'fp_CriticalDevice':'Noncritical', \
				 'clientType':'desktop'}
                 
Ext1_client3 = { 'MACAddress':'6C:DD:BC:8D:C4:D3', \
                    'MACAddress_L':'6c:dd:bc:8d:c4:d3', \
                    'udid':'RF8N81C0QSZ', \
                    'HostName':'Samsung6C-DD-BC-8D-C4-D3', \
                    'platform':'Android', \
                    'pfversion':'12', \
                    'ModelName':'Galaxy S10 Lite', \
                    'phone':'SamsungJ7', \
                    'Manufacturer':'Samsung', \
                    'connectionType':'wifi-signal', \
                    'fp_DeviceType':'Smart Phone', \
                    'fp_SupportedStandard':'802.11ac', \
                    'fp_SupportedBands':'5*', \
                    'fp_TxRate':'866 mbps', \
                    'fp_RxRate':'260 Mbps', \
                    'fp_InterferenceImpact':'None', \
                    'fp_CriticalDevice':'Noncritical', \
                    'clientType':'Mobile'}

                    
Ext2_client1 = { 'MACAddress':'4C:6A:F6:BD:08:FE', \
                    'MACAddress_L':'4c:6a:f6:bd:08:fe', \
                    'udid':'PD21BDD464032439', \
                    'HostName':'hmd global oy4c-6a-f6-bd-08-fe', \
                    'fName1':'Galaxy-A12', \
                    'fName2':'Galaxy-A12', \
                    'platform':'Android', \
                    'pfversion':'11', \
                    'ModelName':'mobile', \
                    'phone':'Nokia', \
                    'Manufacturer':'HMD Global Oy', \
                    'connectionType':'wifi-signal', \
                    'fp_DeviceType':'Smart Phone', \
                    'fp_SupportedStandard':'802.11n', \
                    'fp_SupportedBands':'2.4*', \
                    'fp_TxRate':'6 mbps', \
                    'fp_RxRate':'86 Mbps', \
                    'fp_InterferenceImpact':'None', \
                    'fp_CriticalDevice':'Noncritical', \
                    'clientType':'Mobile'}

'''
Ext3_client1 = { 'MACAddress':'88:A3:03:D6:EA:CA', \
                    'MACAddress_L':'88:a3:03:d6:ea:ca', \
                    'udid':'R9ZN60T7JYH', \
                    'HostName':'Galaxy-M11 ', \
                    'platform':'Android', \
                    'pfversion':'11', \
                    'ModelName':'mobile', \
                    'phone':'samsung', \
                    'Manufacturer':'Samsung', \
                    'connectionType':'wifi-signal', \
                    'fp_DeviceType':'Phone', \
                    'fp_SupportedStandard':'802.11n', \
                    'fp_SupportedBands':'2.4*', \
                    'fp_TxRate':'1 Mbps', \
                    'fp_RxRate':'72 Mbps', \
                    'fp_InterferenceImpact':'None', \
                    'fp_CriticalDevice':'Noncritical', \
                    'clientType':'Mobile'}
''' 
Ext2_client1 = { 'MACAddress':'96:7E:82:28:64:33', \
                    'MACAddress_L':'96:7e:82:28:64:33', \
                    'udid':'R9ZN60T7JYH', \
                    'HostName':'Galaxy-M11', \
                    'platform':'Android', \
                    'pfversion':'11', \
                    'ModelName':'Galaxy', \
                    'phone':'samsung', \
                    'Manufacturer':'samsung electronics', \
                    'connectionType':'wifi-signal', \
                    'fp_DeviceType':'Phone', \
                    'fp_SupportedStandard':'802.11n', \
                    'fp_SupportedBands':'2.4*', \
                    'fp_TxRate':'1 Mbps', \
                    'fp_RxRate':'72 Mbps', \
                    'fp_InterferenceImpact':'None', \
                    'fp_CriticalDevice':'Noncritical', \
                    'clientType':'Mobile'}
                    
                  

#####################################################                   
#####  EFO Switch Port Parameters  ####                 
#####################################################
## Ethernet connections information
Root_Ethernet = {'toSwitch' : 'eth1.0', \
                    'toExt1' : 'eth2.0', \
                    'toExt2' : 'eth3.0', \
                    'bbWan' : 'xx', \
                    'bbLan' : 'xx'}
                    
Ext1_Ethernet = {'toSwitch' : 'eth2.0', \
                    'toClient' : 'eth3.0', \
                    'toRoot' : 'eth1.0', \
                    'bbWan' : 'veip0', \
                    'toExt2' : 'eth2.0' }
                    
Ext2_Ethernet = {'toSwitch' : 'eth2.0', \
                    'toClient' : 'eth3.0', \
                    'toRoot' : 'eth1.0', \
                    'bbWan' : 'veip0', \
                    'toExt1' : 'eth2.0'  }



## L1 API Get Call

API_Logging = 'No'
mapp_api_url = 'http://192.168.18.1'
mode = 'local'
#'''
User_Credentials = {'email':'tenant3user@nokia.com', \
				    'name':'E2EAutomation', \
                    'first_name':'ETEAuto', \
                    'last_name':'ATC', \
                    'mac':Root['mac1'], \
                    'X-ServiceType':'KC', \
                    'clientId':'nokiaMobileApp', \
				    'clientSecret':'nokiaMobileAppSecret', \
                    'Content-Type':'application/json', \
                    'password':'tenant3user', \
                    'user_uuid':'undefined', \
                    'access_token':'undefined', \
                    'response_code':'200', \
                    'response_message':'OK' }
'''

User_Credentials = {'email':'tenant3user@nokia.com', \
				    'name':'E2EAutomation', \
                    'first_name':'ETEAuto', \
                    'last_name':'ATC', \
                    'mac':Root_ONT_24['mac1'], \
                    'X-ServiceType':'KC', \
                    'clientId':'nokiaMobileApp', \
				    'clientSecret':'nokiaMobileAppSecret', \
                    'Content-Type':'application/json', \
                    'password':'tenant3user', \
                    'user_uuid':'undefined', \
                    'access_token':'undefined', \
                    'response_code':'200', \
                    'response_message':'OK' }						
'''
NewUser_Credentials1 = {'email':'atcsmokesetupb6@nokia.com', \
				    'name':'ATC_SMOKE_Beacon6', \
                    'first_name':'ETEAuto', \
                    'last_name':'ATC', \
                    'mac':Root['mac1'], \
                    'X-ServiceType':'KC', \
                    'clientId':'nokiaMobileApp', \
				    'clientSecret':'nokiaMobileAppSecret', \
                    'Content-Type':'application/json', \
                    'password':'Nokia@123', \
                    'user_uuid':'undefined', \
                    'access_token':'undefined', \
                    'response_code':'200', \
                    'response_message':'OK' }

NewUser_Credentials2 = {'email':'nonexistinguserid@nokia.com', \
					'name':'E2EAutomation', \
					'first_name':'ETEAuto', \
					'last_name':'team', \
					'mac':Root['mac1'], \
					'X-ServiceType':'KC', \
					'clientId':'nokiaMobileApp', \
					'clientSecret':'nokiaMobileAppSecret', \
					'Content-Type':'application/json', \
					'password':'demouserl1', \
					'user_uuid':'undefined', \
					'access_token':'undefined', \
					'response_code':'404', \
					'response_message':'User account not found' }			

kibanadetails = {'url':'https://kibana.dev2.homewifi.nokia.com/', \
				'baseurl':'https://kibana.dev2.homewifi.nokia.com/app/discover#/', \
				'firstuser':'kibanaro', \
				'firstpassword':'4s2LfP3Ey4jg4Czv', \
                'KibannaPlatform':'stg'}	#stg or kdev1				

		
									
		
		

#####################################################                   
#####  L2 - Network Portal verification params  ####                 
#####################################################

L2_BackHaul = {'Root': 'Wired', 'Ext1': '5 GHz', 'Ext2': '5 GHz'}
L2_Verification_Vars_Root = {'Area group': 'Vellore RRM', 'RRM profile': 'Vellore RRM', 'Model group': 'B10'}  
L2_Verification_Vars_Ext = {'Area group': 'Vellore RRM', 'RRM profile': 'Vellore RRM', 'Model group': ''} 

defaultspeedtestmodel = 'TR143' # Accepted Values: TR143 or Ookla

##############################################################
####### Starhub/Stofa API                             ########
##############################################################

## For B2: 5ghz= "rai" 2.4ghz="ra"
## For B2: 5ghz= "wl0" 2.4ghz="wl1"
## For B2 easymesh: 5ghz= "wl0.1" 2.4ghz="wl1.1" 
RadioInterface5 = "wifi0"
RadioInterface24 = "wifi1"
## For B2: 5ghz= "rai0.v0" 2.4ghz="ra0.v0"
## For B2: 5ghz= "wl0" 2.4ghz="wl1"
## For B2 easymesh: 5ghz= "wl0.1.v0" 2.4ghz="wl1.1.v0" 
VapsInterface5 = "ssid1"
VapsInterface24 = "ssid0"
## For B2: 5ghz= "rai0" 2.4ghz="ra0"
## For B2: 5ghz= "wl0" 2.4ghz="wl1"
## For B2 easymesh: 5ghz= "wl0.1" 2.4ghz="wl1.1" 
RadioName5 = "wifi0"
RadioName24 = "wifi1"


unwanted_spaces='ssid1"wifi0"ssid0'



DefaultTenant = {'URL':'https://homeconsole1.stg.homewifi.nokia.com/', 
'uname':'demouserl2', 
'pswd':'demouserl2'}


campaignManagerFirmwareDict={
'Name':'3TN00628IJMI05_Beacon_24',
'Description':'3TN00628IJMI05_Beacon_24',
'GroupOfModel':[{'HwModel':'Nokia WiFi Beacon 24',
'Version':'3TN00628IJMI05',
'Firmware':'3TN00628IJMI05',
'FirmwarePath':'C:\\NewAutomation\\e2eautomation\\CortecaConsole\\Build\\3TN00892HJLK97',
'CurrentFirmware':'3TN00628IJMI00',
}]
}
