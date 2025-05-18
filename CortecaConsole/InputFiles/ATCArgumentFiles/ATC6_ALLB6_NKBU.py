# It should contain format for the Setup details
# Make this as a reference and create input file based on the individual setup
# Any new variable or any changes in existing format update this file as well.
import os
currentdirectoryfolder=os.getcwd()
saveScreenShotPath=os.getcwd()



meshNodes=[]
meshNodes=['Ext1', 'Ext2']
detailsRoot={}
detailsExt1={}
detailsExt2={}
detailsExt3={}

RootClientsCount=""

DeviceStream="USP"
CLI_Prompt="superadmin#"
Execution = "noSmoke" #Smoke or noSmoke

# Update the list with if Root and Ext are different models.  Firmware should be available in ont_sw_path
campaignManagerFirmware=[{
'Name':'3FE49062HJLJ43_Beacon_6',
'Description':'3FE49062HJLJ43_Beacon_6',
'HwModel':'BEACON 6 HA-0336G-A',
'Version':'2402.243',
'NewFirmware':'3FE49062HJLJ43',
'CurrentFirmware':'3FE49062HJLJ43'}
]


#Client Details
Root_Clients = '3'
Ext1_Clients = '0'
Ext2_Clients = '0'
Ext3_Clients = '0'

Root_wifi_Clients = '2'
Ext1_wifi_Clients = '0'
Ext2_wifi_Clients = '0'
Ext3_wifi_Clients = '0'



clientsthatareshown=[]




defaultSpeedTestMode="TR143"
defaultServer="13.233.92.195"
# Update the list with if Root and Ext are different models.  Firmware should be available in ont_sw_path
campaignManagerFirmware=[{
'Name':'3FE49062HJLJ43_Beacon_6',
'Description':'3FE49062HJLJ43_Beacon_6',
'HwModel':'BEACON 6 HA-0336G-A',
'Version':'2402.243',
'NewFirmware':'3FE49062HJLJ43',
'CurrentFirmware':'3FE49062HJLJ43'}
]

# Values accepted Beacon (for dark webgui), Pureview for pureview webgui, and ONT for legacy webgui.
Root_Web_GUI_Type = 'Pureview'
Extender_Web_GUI_Type = 'Pureview'

MULTI_TENANT = 'True' ;# Set to 'True' when running DeviceAssociation cases in Multi-Tenant enable platform
TENANT_NAME = 'tenant3'; # If Multi Tenent is True, provide Tenant name. #NEW variable
ONTEthPort = "Ethernet 2" ;# take from 'netsh interface show interface'

boardModel = 'Qualcomm' ; # MTK for B1 and other MTK boards, Qualcomm for B1/B3 and other Qualcomm boards

network_interface  = 'Ethernet 2' ;# take from 'netsh interface show interface'
proxyflag = 'true' ;# set to 'true' if running from LAB/TPC, 'false' if running from home

fsecureInstallVersionNew="3.5.99.196"
fsecureInstallVersionCurrent="4.0.1"

clientmac="D0-37-45-B7-B2-83"
subMac="40-E1-E4-2D-C3-81"
subName="smoke"
subId=""
subEmail=""
subSerial=""

Root_bconType = 'B2'
Ext1_bconType = 'B2'
Ext2_bconType = 'B2'
Ext3_bconType = 'B2'

Root		= {'ip':'192.168.18.1', \
					'mac':'38-A0-67-92-6D-E1', \
					'mac1':'40-E1-E4-2D-C3-81', \
					'router-id':'573785184', \
					'model':'Beacon 2', \
                    'model_L2':'NOKIA_BEACON_6', \
					'serial_num':'ALCLB3F49E44', \
					'gui_url':'https://www.webgui.nokiawifi.com', \
					'gui_username':'superadmin', \
					'gui_password':'VEL56gP97V', \
					'gui_Normal_User':'admin', \
                    'gui_Normal_User_pwd':'21345',\
					'gui_NormaUser_pwd':'Bcon4269', \
					'ont_gui_username':'superadmin', \
					'gui_type':'B2', \
                    'bconType':'B2', \
					'ssid_defa_name':'NOKIA-C381', \
					'ssid_defa_password':'enu9h8HH3S', \
                    'guest_ssid_name':'NOKIA-6DE1_Guest' , \
                    'guest_ssid_pass':'12345678' , \
					'ssid_user_defi_name':'E2E-Auto-B3-Setup1', \
					'ssid_user_defi_password':'ABCD12345', \
					'app_username':'admin', \
					'app_password':'Bcon4269', \
					'opid':'ALCL', \
					'unium_port':'8090', \
                    'active_firmware':'3FE49334HJLL78', \
					'Type': 'AONT', \
					'country_id':'eu', \
					'telnet_port':'22', \
					'telnet_username':'superadmin', \
					'telnet_password':'VEL56gP97V', \
					'telnet_vtysh':'EFnhioPIBUZB5V948At3fJsBOb2b6pMnnqk5m7Fr45W57w==', \
					'product_code':'001122', \
				    'TopoDefName':'Nokia WiFi Beacon 2', \
					'defa_frn_name':'Beacon 2 (38-A0-67-92-6D-E1)', \
					'defa_frn_name_gui':'Bridge', \
					'defa_frn_name1':'Kitchen', \
					'udefi_frn_name':'Nokia WiFi Beacon 2', \
					'ssid_defa_name_l2':'NOKIA-6450-4', \
					'ssid_defa_password_l2':'7ca88254a3', \
					'ssid_udef_name_l2':'L2_Bridge_E2E', \
                    'OUI':'089BB9',\
                    'Productclass':'XS-2426G-B'}

Ext1 = {'ip': '192.168.1.67', \
               'temp_ip': '192.168.1.67', \
               'gui_url1': 'http://192.168.1.67', \
               'model': 'Beacon 2', \
               'mac': '38-A0-67-91-FF-61', \
                'model_L2':'Nokia_Beacon_2', \
               'mac1': '38-A0-67-A7-AA-A1', \
               'TopoDefName': 'Beacon 2 (38-A0-67-91-FF-61)', \
               'router-id': '3331911904', \
               'serial_num': 'ALCLB3F4975C', \
               'wds_mac': '38-A0-67-92-04-B1', \
               'gui_url': 'http://192.168.1.67', \
               'gui_username': 'AdminGPON', \
               'gui_password': 'Anjsaf722bhV!9fK', \
               'gui_type': 'Nokia Wifi Beacon 2', \
               'ssid_defa_name': 'NOKIA-6DE1', \
               'ssid_defa_password': 'x6HUC3YXpC', \
                'guest_ssid_name':'NOKIA-6DE1_Guest' , \
                'guest_ssid_pass':'12345678' , \
               'bconType': 'B2', \
                'opid': 'NKBB', \
               'unium_port': '8090', \
               'active_firmware':'3FE49334HJLL78', \
               'country_id': 'eu', \
               'telnet_port': '23', \
               'telnet_username': 'AdminGPON', \
               'telnet_password': 'Anjsaf722bhV!9fK', \
               'telnet_vtysh': 'EOCU3sTyVGCJRdWvFhPYbN8IgcgGmSMZdf+nN4Khdq0L', \
               'product_code': 'BCM6846', \
               'defa_frn_name': 'Beacon 2 (38-A0-67-92-04-B1)', \
               'defa_frn_name_gui': 'APSN9F9A', \
                'udefi_frn_name': 'Beacon 2 (38-A0-67-91-FF-61)', \
               'OUI':'089BB9',\
                'Productclass':'Nokia Wifi Beacon 2'}

Ext2 = {'ip': '192.168.1.68', \
               'temp_ip': '192.168.1.68', \
               'gui_url1': 'http://192.168.1.68', \
               'model': 'Beacon 2', \
                'model_L2':'Nokia_Beacon_2', \
               'mac': '38-A0-67-92-02-21', \
               'mac1': '38-A0-67-A7-AB-D1', \
               'TopoDefName': 'Beacon 2 (38-A0-67-92-02-21)', \
               'router-id': '3331911904', \
               'serial_num': 'ALCLB3F49788', \
               'wds_mac': '38-A0-67-92-70-31', \
               'gui_url': 'http://192.168.1.68', \
               'gui_username': 'AdminGPON', \
               'gui_password': 'Anjsaf722bhV!9fK', \
               'bconType': 'B2', \
               'gui_type': 'Nokia Wifi Beacon 2', \
               'ssid_defa_name': 'NOKIA-6DE1', \
               'ssid_defa_password': 'x6HUC3YXpC', \
               'guest_ssid_name':'NOKIA-6DE1_Guest' , \
               'guest_ssid_pass':'12345678' , \
               'active_firmware':'3FE49334HJLL78', \
               'opid': 'NKBB', \
               'unium_port': '8090', \
               'country_id': 'eu', \
               'telnet_port': '23', \
               'telnet_username': 'AdminGPON', \
               'telnet_password': 'Anjsaf722bhV!9fK', \
               'telnet_vtysh': 'EEQvwwkEeIi48XK+9T/k8CgCvn3TqFoV9wHcCTeXCVGq3g==', \
               'product_code': 'BCM6846', \
               'defa_frn_name': 'Beacon 2 (38-A0-67-92-70-31)', \
               'defa_frn_name_gui': 'APSN9F9A', \
                'udefi_frn_name': 'Beacon 2 (38-A0-67-92-02-21)', \
               'OUI':'089BB9',\
                'Productclass':'Nokia Wifi Beacon 2'}


Ext3 = {'ip': '192.168.1.69', \
               'temp_ip': '192.168.1.69', \
               'gui_url1': 'http://192.168.1.69', \
               'model': 'Beacon 2', \
               'mac': '08-9B-B9-C6-5C-51', \
                'model_L2':'Nokia_Beacon_2', \
               'mac1': '08-9B-B9-C6-5C-51', \
               'TopoDefName': 'Beacon 2 (08-9B-B9-C6-5C-51)', \
               'router-id': '3331911904', \
               'serial_num': 'ALCLEB28A644', \
               'wds_mac': 'DC-8D-8A-58-2F-C1', \
               'gui_url': 'http://192.168.1.69', \
               'bconType': 'B2', \
               'gui_username': 'AdminGPON', \
               'gui_password': 'Anjsaf722bhV!9fK', \
               'gui_type': 'Nokia Wifi Beacon 2', \
               'ssid_defa_name': 'NOKIA-6DE1', \
               'ssid_defa_password': 'x6HUC3YXpC', \
                'guest_ssid_name':'NOKIA-6DE1_Guest' , \
                'guest_ssid_pass':'12345678' , \
               'active_firmware':'3FE49334HJLL78', \
               'opid': 'NKBB', \
               'unium_port': '8090', \
               'country_id': 'eu', \
               'telnet_port': '23', \
               'telnet_username': 'AdminGPON', \
               'telnet_password': 'Anjsaf722bhV!9fK', \
               'telnet_vtysh': 'EQKV39QgWzWjHsJw/C+J2/0xAYsGqojO1Al1RINoJ0JLkBc=', \
               'product_code': 'BCM6846', \
               'defa_frn_name': 'Beacon 2 (DC-8D-8A-58-2F-C1)', \
                'udefi_frn_name': 'Beacon 2 (08-9B-B9-C6-5C-51)', \
               'defa_frn_name_gui': 'APSN9F9A', \
               'OUI':'089BB9',\
                'Productclass':'Nokia Wifi Beacon 2'}


########## Change bconType to 'WJ' for WJ, 'B3' for B3.  ##########
Root_bconType = 'B31'
Ext1_bconType = 'B2'
Ext2_bconType = 'B31'
Ext3_bconType = 'B31'



ont_sw_path = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\Builds'
Account         = {'FirstName':'ATC_XS', \
                   'LastName':'', \
                   'Email':'anjujayankbackup@gmail.com', \
                   'Password':'Qwertty123@', \
                   'Key_URL':'https://auth.stg.homewifi.nokia.com/sso/admin/tenant3/console/#/tenant3/users', \
                   'userName':'tenant3keycloak', \
                   'password':'tenant3keycloak', \
                   'Mac_add':'', \
                   'KEYCLOAK_URL': 'https://auth.stg.homewifi.nokia.com/sso/admin/tenant3/console/', \
                   'KEYCLOAK_REALM': 'tenant3', \
                   'KEYCLOAK_CLIENT_ID': 'portal_nokiahwstg'}

User_Credentials = {'email':'tenant3user@nokia.com', \
				    'name':'E2EAutomation', \
                    'first_name':'ETEAuto', \
                    'last_name':'', \
                    'mac':'E0-1F-2B-B8-8F-11', \
                    'X-ServiceType':'KC', \
                    'clientId':'nokiaMobileApp', \
				    'clientSecret':'nokiaMobileAppSecret', \
                    'Content-Type':'application/json', \
                    'password':'tenant3user', \
                    'user_uuid':'undefined', \
                    'access_token':'undefined', \
                    'response_code':'200', \
                    'response_message':'OK' }


NewUser_Credentials1 = {'email': 'rohithmessi2000@gmail.com', \
                    'name': 'E2EAutomation', \
                    'first_name': 'Sri', \
                    'last_name': 'team', \
                    'mac': Root['mac'], \
                    'mac': Root['mac1'], \
                    'X-ServiceType': 'KC', \
                    'clientId': 'nokiaMobileApp', \
                    'clientSecret': 'nokiaMobileAppSecret', \
                    'Content-Type': 'application/json', \
                    'password': 'Nokia@123', \
                    'user_uuid': 'nokiahwstg_karthik5', \
                    'access_token': 'undefined', \
                    'response_code': '200', \
                    'response_message': 'OK'}
L2_BackHaul = {'Root': 'Wired', 'Ext1': '5 GHz'}
L2_Verification_Vars_Root = {'Area group': 'vellore RRM', 'RRM profile': 'vellore RRM', 'Model group': 'Beacom3_Group'}
L2_Verification_Vars_Ext = {'Area group': 'TVH Agnito Park', 'RRM profile': 'ECR EU', 'Model group': 'Beacon 2'} #NEW variable


ssh_login={'ipaddresss':'192.168.18.1',\
           'username':'superadmin',\
           'password':'Pf2bSS75X=z3',\
           'password2':'EQIbthadBaAoYOYoMeApbLmVAzryZAawVTQxKmv9tS1MPp8='}

master_url={'password':'RzjMB9N!Tb',\
           'password2':'EAT9OvxUYS+yXblzGrTp9wgDwodIlX/16HHgbp+Rv/0/Iw=='}
ssh_prompt="root@Beacon 6:/configs/overlay/home/superadmin#"



Selector_path = 'C:\\Regression\\NWCC_Git_Code\\New_Framwork_Git_Code\\e2eautomation\\CortecaConsole\\Locators\\'

saveScreenShotPath = 'C:\\Regression\\NWCC_Git_Code\\New_Framwork_Git_Code\\\Log\\SMOKE\\'


saveScreenShotPath="C:\\NewAutomation\\e2eautomation\\CortecaConsole\\Output\\Screenshots"
ont_sw_path=""

# New variable:
'''
campaignManagerFirmwareDict={
'Name':'3FE49062HJLJ96_Beacon_6',
'Description':'3FE49062HJLJ96_Beacon_6',
'GroupOfModel':[{'HwModel':'BEACON 6 HA-0336G-A',
'Version':'3FE49062HJLK96',
'Firmware':'3FE49062HJLK96',
'FirmwarePath':'C:\\NewAutomation\\e2eautomation\\CortecaConsole\\Build\\3FE49062HJLK96',
'CurrentFirmware':'3FE49062HJLK95',
}]
}
'''
campaignManagerFirmwareDict={
'Name':'3FE49062HJLL78_b6',
'Description':'3FE49062HJLL78_b6',
'GroupOfModel':[{'HwModel':'BEACON 6 HA-0336G-A',
'Version':'3FE49062HJLL78',
'Firmware':'3FE49062HJLL78',
'FirmwarePath':'C:\\Users\\ladmin\\Downloads\\3FE49062HJLL78_B6',
'CurrentFirmware':'3FE49062HJLL78',
}]
}

#version details: https://confluence-app.ext.net.nokia.com/display/HC/Container+Apps+-+Stable+Versions

##campaignAppliction
# campaignManagerApplication=[{
# 'Application':'F-Secure Sense',
# 'appUuid':'fb882f7e-b50b-526b-8f4a-5c0be5039ed0',
# 'Name':'fsecureRulecreation',
# 'HwModel':['BEACON 6 HA-0336G-A'],
# 'FirmwareVersions':['3FE49062HJLL92'],
# 'HwMacs':["40-E1-E4-2D-C3-81"],
# 'OtherHwModel':['Nokia WiFi Beacon G6'], #should be different model than given in HwModel list and also should support given AppVersion
# 'OtherFirmware':['3FE49996HJLJ99'], #should be firmware support model than given in OtherHwModel
# 'AppVersion':'4.4.2',
# 'UpdateVersion':''
# },
# {
# 'Application':'Nokia Fingerprint',
# 'appUuid':'2cbf535a-7965-5260-a98a-02ce2977723c',
# 'Name':'fingerPrintRulecreation',
# 'HwModel':['BEACON 6 HA-0336G-A'],
# 'FirmwareVersions':['3FE49062HJLL92'],
# 'HwMacs':["40-E1-E4-2D-C3-81"],
# 'OtherHwModel':['Nokia WiFi Beacon G6'], #should be different model than given in HwModel list and also should support given AppVersion
# 'OtherFirmware':['3FE49996HJLJ99'], #should be firmware support model than given in OtherHwModel
# 'AppVersion':'4.0.1',
# 'UpdateVersion':''
# }
# ]

campaignManagerApplication=[{
'Application':'F-Secure Sense',
'appUuid':'fb882f7e-b50b-526b-8f4a-5c0be5039ed0',
'Name':'fsecureRulecreation',
'HwModel':['BEACON 6 HA-0336G-A'],
'FirmwareVersions':['3FE49062HJLL92'],
'HwMacs':["40-E1-E4-2D-C3-81"],
'OtherHwModel':['Nokia WiFi Beacon G6'], #should be different model than given in HwModel list and also should support given AppVersion
'OtherFirmware':['3FE49996HJLJ99'], #should be firmware support model than given in OtherHwModel
'AppVersion':'4.4.2',
'UpdateVersion':''
}]

HomeTroubleshooting=True
FPInstallVersionCurrent="4.0.1"
FsecureInstallVersionCurrent="4.0.1"

Root_Client1 = {'MACAddress': '50-3E-AA-7F-B4-14',
                'MACAddress_L': '50:3e:aa:7f:b4:14',
				'type': 'Desktop',
				'connectionType': 'ethernet',
				'udid': 'NA',
				'hostName': 'DESKTOP-B9LLCMJ',
				'manufacture': 'Lenovo',
				'model': 'ThinkPad T470',
				'mobility': 'STATIC',
				'ssid': 'N/A for Ethernet',
				'WiFi Standard':'N/A for Ethernet',
				'WiFi Band':'N/A for Ethernet',
                'multiLinkOperation': 'No',
                'singnalStrength': 'N/A for Ethernet',
				'txRate': '1.0 Gbps',
                'rxRate': '1.0 Gbps',
				'portNumber': '3',
                'ipAddres': '192.168.18.2',
                'ipV6Addres1': 'No IP address allocated',
                'ipV6Addres2': 'No IP address allocated',
                'connectedTo': Root['udefi_frn_name'],
                'internetAccess': 'Enabled'
                }

Root_Client2 = {'MACAddress': 'A4-C6-9A-A2-53-1F',
                'MACAddress_L': 'a4:c6:9a:a2:53:1',
				'type': 'Phone',
				'connectionType': 'wifi',
				'uuid': 'RZ8T305YGHV',
				'hostName': 'Galaxy',
				'manufacture': 'Samsung Electronics',
				'model': 'Galaxy',
				'mobility': 'Mobile',
				'ssid': Root['ssid_defa_name'],
				'WiFi Standard':'',
				'WiFi Band':'',
                'multiLinkOperation': 'No',
                'singnalStrength': 'High (-7 dBm)',
				'txRate': '0.1 Gbps',
                'rxRate': '0.1 Gbps',
				'portNumber': 'N/A for wireless',
                'ipAddres': '192.168.18.6',
                'ipV6Addres1': 'fe80::21cc:95d7:ecd9:af6f',
                'ipV6Addres2': 'No IP address allocated',
                'connectedTo': Root['udefi_frn_name'],
                'internetAccess': 'Enabled',
                'handsetModel':'SamsungM325',
                'platform':'Android',
                'version':'12'
                }
#

Root_Client3 = {'MACAddress': '80-CE-B9-CB-D8-03', \
                'MACAddress_L': 'ac:57:75:49:4a:19', \
                'udid': 'CTLID19013101302', \
                'hostName': 'Galaxy-M31', \
                'ipAddres': '192.168.18.2',
                'ipV6Addres1': 'fe80::21cc:95d7:ecd9:af6f',
                'ipV6Addres2': 'No IP address allocated',
                'type': 'Phone', \
                'manufacture': 'Samsung', \
                'connectionType': 'wifi', \
                'model': 'Unknown', \
                'mobility': 'Unknown', \
                'connectedTo': Root['TopoDefName'], \
                'ssid': Root['ssid_defa_name'], \
                'portNumber': 'N/A for wireless', \
                'internetAccess': 'Enabled', \
                'multiLinkOperation': 'No', \
                'singnalStrength': 'High (-7 dBm)', \
                'fp_DeviceType': 'Smart Phone', \
                'fp_SupportedStandard': '802.11ac', \
                'fp_SupportedBands': '5L*', \
                'fp_TxRate': 'Unknown', \
                'fp_RxRate': 'Unknown', \
                'clientType': 'Mobile'}

# Campaign config file
# 'WrongMac': -> MAC of a different Model AP which not in the current Setup.
campaignManagerConfigFileDict={
'Name':'CampaignConfigB6Group',
'Description':'NewConfigPush_Beacon_6',
'Version':'1',
'HwModel':'BEACON 6 HA-0336G-A',
'CSVDeviceFilePath':'C:\\Users\\ladmin\\Downloads\\campaign.csv',
'Firmware':'3FE49062HJLL92',
'softwareUpgradeImagePath':'C:\\Regression\\NWCC_Git_Code\\NewFrameworkCodeLatest\\e2eautomation\\CortecaConsole\\Build\\3FE49062HJLL92_B6',
'WrongMac':'08-9B-B9-C6-5C-51'
}

