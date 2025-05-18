# It should contain format for the Setup details
# Make this as a reference and create input file based on the individual setup
# Any new variable or any changes in existing format update this file as well.
import os
currentdirectoryfolder=os.getcwd()
saveScreenShotPath=os.getcwd()



meshNodes=[]
meshNodes=['Ext1', 'Ext2', 'Ext3']
detailsRoot={}
detailsExt1={}
detailsExt2={}
detailsExt3={}

RootClientsCount=""

DeviceStream="HA"
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
Root_Clients = '2'
Ext1_Clients = '0'
Ext2_Clients = '0'
Ext3_Clients = '0'

Root_wifi_Clients = '2'
Ext1_wifi_Clients = '0'
Ext2_wifi_Clients = '0'
Ext3_wifi_Clients = '0'



clientsthatareshown=[]





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

boardModel = 'MTK' ; # MTK for B1 and other MTK boards, Qualcomm for B1/B3 and other Qualcomm boards

network_interface  = 'Ethernet 2' ;# take from 'netsh interface show interface'
proxyflag = 'true' ;# set to 'true' if running from LAB/TPC, 'false' if running from home

fsecureInstallVersionNew="3.5.99.196"
fsecureInstallVersionCurrent="4.0.1"

clientmac="D0-37-45-B7-B2-83"
subMac="88-B3-62-FE-79-32"
subName="smoke"
subId=""
subEmail=""
subSerial=" "




Root		= {'ip':'192.168.18.1', \
					'mac':'88-B3-62-FE-79-32', \
					'mac1':'88-B3-62-FE-79-32', \
					'router-id':'573781136', \
					'model':'Beacon 1', \
					'model_L2':'NOKIA_BEACON_1', \
					'serial_num':'ALCLFA667698', \
					'gui_url':'http://www.webgui.nokiawifi.com', \
					'gui_username':'superadmin', \
					'gui_password':'BhWbu93FZ=fp', \
					'gui_Normal_User':'admin', \
					'ont_gui_username':'BhWbu93FZ=fp', \
					'gui_type':'B1', \
					'ssid_defa_name':'NOKIA-7932', \
                    'guest_ssid_name':'NOKIA-7932_Guest' , \
                    'guest_ssid_pass':'12345678' , \
					'ssid_defa_password':'6r5fR52LXA', \
					'ssid_user_defi_name':'E2ENew', \
					'ssid_user_defi_password':'ABCD12345', \
					'app_username':'admin', \
					'app_password':'superadmin', \
					'opid':'ARCL', \
					'unium_port':'8090', \
                    'active_firmware': '3FE49750HJKI41', \
                     'Type': 'AONT', \
                     'bconType':'G240WG', \
					'country_id':'us', \
					'telnet_port':'23', \
					'telnet_username':'superadmin', \
					'telnet_password':'BhWbu93FZ=fp', \
					'telnet_vtysh':'EQLaeqiQL4cwVwHoC38jGt2XAQCDyh8UMszGtdPo569VsEc=', \
					'product_code':'3FE46864', \
				   'TopoDefName':'Beacon 1 (88-B3-62-FE-79-32)', \
					'defa_frn_name':'Beacon 1 (88-B3-62-FE-79-32)', \
					'defa_frn_name1':'Beacon 1 (88-B3-62-FE-79-32)', \
					'udefi_frn_name':'Beacon 1 (88-B3-62-FE-79-32)', \
					'ssid_defa_name_l2':'NOKIA-7932_Guest', \
					'ssid_defa_password_l2':'BhWbu93FZ=fp', \
					'ssid_udef_name_l2':'L2_Bridge_E2E', \
                    'OUI':'089BB9',\
                    'Productclass':'Nokia Wifi Beacon 2',\
                    'customerid':'6437790072'}

Ext1 =  {'ip':'192.168.1.64', \
                   'temp_ip':'192.168.1.64', \
                   'gui_url1':'http://192.168.1.64', \
                   'model':'Beacon 1', \
					'model_L2':'NOKIA_BEACON_1', \
                   'mac':'0C-7C-28-14-C5-59', \
					'mac1':'0C-7C-28-14-C5-59', \
                   'router-id':'1389194528', \
                   'serial_num':'ALCLB394CF63', \
                   'wds_mac':'00:11:22:33:29:90', \
                   'gui_url':'http://192.168.18.64', \
                   'gui_username':'writeuser', \
                   'gui_password':'Cl4r0gp0n',
                   'gui_type':'G240WA', \
                   'ssid_defa_name':'ALHN-0A82', \
                   'ssid_defa_password':'4069597002', \
                   'active_firmware': '3FE49750HJKI41', \
                   'gui_type':'G240WA', \
                   'opid':'NKNA', \
                   'unium_port':'8090', \
                   'country_id':'us', \
                   'telnet_port':'23', \
                    'bconType':'B1', \
                   'telnet_username':'writeuser', \
                   'telnet_password':'Cl4r0gp0n', \
                   'telnet_vtysh':'EQFfI0HSpvqDxaOZdB7XYaI4A9Eh8KYQimYn5racUs53s+o=', \
                   'product_code':'BCM6846', \
				   'TopoDefName':'Nokia WiFi Beacon 1', \
				   'defa_frn_name1':'Beacon 1 (0C-7C-28-14-C5-59)', \
					'defa_frn_name':'Beacon 1 (0C-7C-28-14-C5-59)', \
					'defa_frn_name_gui':'APSN4162', \
                   'udefi_frn_name':'Beacon 1 (0C-7C-28-14-C5-59)'}

Ext2 = {'ip':'192.168.1.64', \
                   'temp_ip':'192.168.1.64', \
                   'gui_url1':'http://192.168.1.64', \
                   'model':'Beacon 1', \
					'model_L2':'NOKIA_BEACON_1', \
                   'mac':'0C-7C-28-14-BF-A9', \
					'mac1':'0C-7C-28-14-BF-A9', \
                   'router-id':'1389194528', \
                   'serial_num':'ALCLB394CF08', \
                   'wds_mac':'00:11:22:33:29:90', \
                   'gui_url':'http://192.168.18.64', \
                   'gui_username':'writeuser', \
                   'gui_password':'Cl4r0gp0n',
                   'gui_type':'G240WA', \
                   'ssid_defa_name':'ALHN-0A82', \
                   'ssid_defa_password':'4069597002', \
                   'gui_type':'G240WA', \
                   'opid':'NKNA', \
                    'bconType':'B1', \
                   'unium_port':'8090', \
                    'active_firmware':'3FE49750HJKI41', \
                   'country_id':'us', \
                   'telnet_port':'23', \
                   'telnet_username':'writeuser', \
                   'telnet_password':'Cl4r0gp0n', \
                   'telnet_vtysh':'EQFfI0HSpvqDxaOZdB7XYaI4A9Eh8KYQimYn5racUs53s+o=', \
                   'product_code':'BCM6846', \
				   'TopoDefName':'Nokia WiFi Beacon 1', \
				   'defa_frn_name1':'Beacon 1 (0C-7C-28-14-BF-A9)', \
					'defa_frn_name':'Beacon 1 (0C-7C-28-14-BF-A9)', \
					'defa_frn_name_gui':'APSN4162', \
                   'udefi_frn_name':'Beacon 1 (0C-7C-28-14-BF-A9)'}


Ext3 = {'ip':'192.168.1.64', \
                   'temp_ip':'192.168.1.64', \
                   'gui_url1':'http://192.168.1.64', \
                   'model':'Beacon 1', \
					'model_L2':'NOKIA_BEACON_1', \
                   'mac':'0C-7C-28-14-C3-29', \
					'mac1':'0C-7C-28-14-C3-29', \
                   'router-id':'1389194528', \
                   'serial_num':'ALCLB394CF40', \
                   'wds_mac':'00:11:22:33:29:90', \
                   'gui_url':'http://192.168.18.64', \
                   'gui_username':'writeuser', \
                   'gui_password':'Cl4r0gp0n',
                   'gui_type':'G240WA', \
                    'bconType':'B1', \
                   'ssid_defa_name':'ALHN-0A82', \
                   'ssid_defa_password':'4069597002', \
                   'gui_type':'G240WA', \
                   'opid':'NKNA', \
                   'unium_port':'8090', \
                    'active_firmware': '3FE49750HJKI41', \
                     'country_id':'us', \
                   'telnet_port':'23', \
                   'telnet_username':'writeuser', \
                   'telnet_password':'Cl4r0gp0n', \
                   'telnet_vtysh':'EQFfI0HSpvqDxaOZdB7XYaI4A9Eh8KYQimYn5racUs53s+o=', \
                   'product_code':'BCM6846', \
				   'TopoDefName':'Nokia WiFi Beacon 1', \
				   'defa_frn_name1':'Beacon 1 (0C-7C-28-14-C3-29)', \
					'defa_frn_name':'Beacon 1 (0C-7C-28-14-C3-29)', \
					'defa_frn_name_gui':'APSN4162', \
                   'udefi_frn_name':'Beacon 1 (0C-7C-28-14-C3-29)'}


########## Change bconType to 'WJ' for WJ, 'B3' for B3.  ##########
Root_bconType = 'B1'
Ext1_bconType = 'B1'
Ext2_bconType = 'B1'
Ext3_bconType = 'B1'



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

           'password':'BhWbu93FZ=fp',\
           'password2':'EQECwhfWaPAdNLJU5e1veWxDA9ERxMr8yjz7y+VwGX0d0p8='}
ssh_prompt="[root@AONT: superadmin]#"

master_url={'password':'RzjMB9N!Tb',\
           'password2':'EAT9OvxUYS+yXblzGrTp9wgDwodIlX/16HHgbp+Rv/0/Iw=='}




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
'Name':'3TN00892HJLK97_b32',
'Description':'3TN00892HJLK97_b32',
'GroupOfModel':[{'HwModel':'Nokia WiFi Beacon 3.1',
'Version':'3TN00892HJLK97',
'Firmware':'3TN00892HJLK97',
'FirmwarePath':'C:\\NewAutomation\\e2eautomation\\CortecaConsole\\Build\\3TN00892HJLK97',
'CurrentFirmware':'3TN00626HJLK80',
}]
}



campaignManagerConfigFileDict={
'Name':'NewConfigPush',
'Description':'NewConfigPush_Beacon_6',
'Version':'1',
'HwModel':'BEACON 6 HA-0336G-A',
'NewConfigFilePath':'C:\\Users\\ladmin\\Desktop\\Anju\\2402\\CFPNKBU001',
'DefaultConfigFilePath':'',
'Firmware':'3FE49062HJLJ53'
}

#version details: https://confluence-app.ext.net.nokia.com/display/HC/Container+Apps+-+Stable+Versions

#campaignAppliction
campaignManagerApplication=[{
'Application':'F-Secure Sense',
'appUuid':'395c2ecc-2da8-5c67-a807-8b70f0e55511',
'Name':'fsecureRulecreation',
'HwModel':['BEACON 6 HA-0336G-A'],
'FirmwareVersions':['3FE49062HJLK41'],
'HwMacs':["40-E1-E4-2D-C3-81"],
'OtherHwModel':['Nokia WiFi Beacon G6'], #should be different model than given in HwModel list and also should support given AppVersion
'OtherFirmware':['3FE49996HJLJ99'], #should be firmware support model than given in OtherHwModel
'AppVersion':'4.0.1'
},
{
'Application':'Nokia Fingerprint',
'appUuid':'0639c016-563e-5e4b-8c41-8193bed5cc94',
'Name':'fingerPrintRulecreation',
'HwModel':['BEACON 6 HA-0336G-A'],
'FirmwareVersions':['3FE49062HJLK41'],
'HwMacs':["40-E1-E4-2D-C3-81"],
'OtherHwModel':['Nokia WiFi Beacon G6'], #should be different model than given in HwModel list and also should support given AppVersion
'OtherFirmware':['3FE49996HJLJ99'], #should be firmware support model than given in OtherHwModel
'AppVersion':'v2.18'
}
]

HomeTroubleshooting=True
FPInstallVersionCurrent="4.0.1"
FsecureInstallVersionCurrent="4.0.1"

Root_Client1 = {'MACAddress': '64-A2-F9-00-70-25', \
                'MACAddress_L': 'ac:57:75:49:4a:19', \
                'udid': 'OnePlus_6', \
                'hostName': 'OnePlus_6', \
                'ipAddres': '192.168.1.64',
                'ipV6Addres1': 'fe80::21cc:95d7:ecd9:af6f',
                'ipV6Addres2': 'No IP address allocated',
                'type': 'Desktop', \
                'manufacture': 'TP-Link', \
                'connectionType': 'wifi', \
                'model': 'Unknown', \
                'mobility': 'Unknown', \
                'connectedTo': Root['TopoDefName'], \
                'ssid': Root['ssid_defa_name'], \
                'portNumber': 'N/A for wireless', \
                'internetAccess': 'Enabled', \
                'multiLinkOperation': 'No', \
                'singnalStrength': 'High (-7 dBm)', \
                'fp_DeviceType': 'Computer', \
                'fp_SupportedStandard': '802.11ac', \
                'fp_SupportedBands': '5L*', \
                'fp_TxRate': '0.1 Gbps', \
                'fp_RxRate': '0.1 Gbps', \
                'clientType': 'Desktop'}

Root_Client2 = {'MACAddress': '70-B3-D5-8B-E4-47', \
                'MACAddress_L': 'ac:57:75:49:4a:19', \
                'udid': 'CTLID19013101302', \
                'hostName': 'DESKTOP-H9PV5GM', \
                'ipAddres': '192.168.1.69',
                'ipV6Addres1': 'fe80::21cc:95d7:ecd9:af6f',
                'ipV6Addres2': 'No IP address allocated',
                'type': 'Phone', \
                'manufacture': 'Samsung', \
                'connectionType': 'Ethernet', \
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