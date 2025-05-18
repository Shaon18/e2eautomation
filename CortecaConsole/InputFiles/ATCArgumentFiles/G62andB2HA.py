# It should contain format for the Setup details
# Make this as a reference and create input file based on the individual setup
# Any new variable or any changes in existing format update this file as well.
import os
currentdirectoryfolder=os.getcwd()
saveScreenShotPath=os.getcwd()
meshNodes=['Ext1']
detailsRoot={}
detailsExt1={}
detailsExt2={}
detailsExt3={}

RootClientsCount="2"
#Client Details
Root_Clients = '2'
Ext1_Clients = '0'
Ext2_Clients = '0'
Ext3_Clients = '0'

Root_wifi_Clients = '1'
Ext1_wifi_Clients = '0'
Ext2_wifi_Clients = '0'
Ext3_wifi_Clients = '0'
DeviceStream="HA"
CLI_Prompt="superadmin#"
Execution = "noSmoke" #Smoke or noSmoke
clientsthatareshown=[]
# Update the list with if Root and Ext are different models.  Firmware should be available in ont_sw_path
campaignManagerFirmware={
'Name':'3FE49062HJLJ43_Beacon_6',
'Description':'3FE49062HJLJ43_Beacon_6',
'HwModel':'Beacon 6',
'Version':'2402.243',
'NewFirmware':'3FE49062HJLJ43',
'CurrentFirmware':'3FE49062HJLJ43'}


# Values accepted Beacon (for dark webgui), Pureview for pureview webgui, and ONT for legacy webgui.
Root_Web_GUI_Type = 'Pureview'
Extender_Web_GUI_Type = 'Pureview'

MULTI_TENANT = 'True' ;# Set to 'True' when running DeviceAssociation cases in Multi-Tenant enable platform
TENANT_NAME = 'tenant3'; # If Multi Tenent is True, provide Tenant name. #NEW variable
ONTEthPort = "Ethernet 2" ;# take from 'netsh interface show interface'

boardModel = 'OpenWRTB' ; # MTK for B1 and other MTK boards, Qualcomm for B1/B3 and other Qualcomm boards

network_interface  = 'Ethernet 2' ;# take from 'netsh interface show interface'
proxyflag = 'true' ;# set to 'true' if running from LAB/TPC, 'false' if running from home

fsecureInstallVersionNew="3.5.99.196"
fsecureInstallVersionCurrent="4.0.1"

subMac="28-74-F5-E4-CE-D0"
subName="smoke"
subId=""
subEmail=""
subSerial=""

########## Change bconType to 'WJ' for WJ, 'B3' for B3.  ##########
Root_bconType = 'BG62'
Ext1_bconType = 'B2'
Ext2_bconType = 'B2'
Ext3_bconType = 'B2'


## ONT information
Root         = {'ip': '192.168.1.1', \
                'mac': '28-74-F5-E4-CE-D0', \
                'temp_ip': '192.168.1.1', \
                'mac1': '28-74-F5-E4-CE-D0', \
                'model': 'Beacon G6.2', \
                'model_L2': 'NOKIA_BEACON_G6_2', \
                'router-id': '2112844608', \
                'serial_num': 'ALCLEB3A572D', \
                'gui_url': 'https://www.webgui.nokiawifi.com', \
                'gui_username': 'superadmin', \
                'gui_password': 'FSZbZ27WD.M4', \
                'gui_Normal_User': 'admin', \
                'gui_Normal_User_pwd': '2832428301', \
                'gui_type': 'G-1426G-A', \
                'ssid_defa_name': 'NOKIA-CED0', \
                'ssid_defa_changed_name': 'NOKIA-CED0_Changed', \
                'ssid_defa_password': 'qRt5dpbhdZ', \
                'ssid_user_defi_name': 'E2E-Auto-B3-Setup1', \
                'ssid_user_defi_password': 'ABCD12345', \
                'app_username': 'userAdmin', \
                'app_password': 'F9RfXyssVM', \
                'opid': 'NXLK', \
                'unium_port': '18090', \
                'Type': 'Beacon', \
                'country_id': 'eu', \
                'telnet_port': '23', \
                'telnet_username': 'superadmin', \
                'telnet_password': 'FSZbZ27WD.M4', \
                'telnet_vtysh': 'EQFxeOYjC8dnDM2iJO86z79oAQgm9LY5fs64KUkW282baJw=', \
                'product_code': '3FE49996', \
                'ssid_defa_name_l2': 'NOKIA-C1E1', \
                'ssid_defa_password_l2': 'qRt5dpbhdZ', \
                'defa_frn_name': 'Router', \
                'ssid_udef_name_l2': 'L2_Bridge_E2E', \
                'TopoDefName': 'Nokia WiFi Beacon G6.2', \
                'defa_frn_name_gui': 'Bridge', \
                'defa_frn_name1': 'Kitchen', \
                'udefi_frn_name': 'Nokia WiFi Beacon G6.2', \
                'OUI':'F89B6E',
                'Productclass':' Beacon G6.2',
                'bconType':'BG62',
                'guest_ssid_name':'NOKIA-CED0_Guest',
                'guest_ssid_changed_name':'NOKIA-CED0_Guest_Changed',
                'guest_ssid_pass':'12345678',
                'active_firmware':'3FE49996HJMJ61',
                'customerid':'4298945427'}

Ext1 =  {'ip':'192.168.1.67', \
                   'model':'Beacon 2', \
                   'model_L2':'NOKIA_BEACON_2', \
                   'temp_ip':'192.168.1.67', \
                   'gui_url1':'http://192.168.1.67', \
                   'mac':'38-A0-67-FC-0F-11', \
                   'mac1':'38-A0-67-FC-0F-11',\
                   'router-id':'2112844640',\
                   'serial_num':'ALCLB277D9C8', \
                   'wds_mac':'38:A0:67:FC:0F:11', \
                   'gui_url':'http://192.168.1.67', \
                   'gui_username':'superadmin', \
                   'gui_password':'FSZbZ27WD.M4', \
                   'gui_type':'G240WA', \
                   'ssid_defa_name':'NOKIA-CED0', \
                   'ssid_defa_password':'FSZbZ27WD.M4', \
                    'active_firmware':'3FE49334HJMJ41', \
                   'opid':'NKBB', \
                   'unium_port':'8090', \
                   'country_id':'us', \
                   'telnet_port':'23', \
                    'bconType' :'B2',\
                   'telnet_username':'superadmin', \
                   'telnet_password':'FSZbZ27WD.M4', \
                   'telnet_vtysh':'EQK7ucvuVaNSpZAWyexKpbiSxzoh9NUHmoHrFnZLeFo6Vg==', \
                   'product_code':'3FE49334', \
                   'TopoDefName':'Nokia WiFi Beacon 2', \
					'defa_frn_name':'Beacon 2 (38-A0-67-FC-0F-11)', \
                    'defa_frn_name_gui': 'APSN9F9A', \
                    'udefi_frn_name': 'Beacon 2 (38-A0-67-FC-0F-11)', \
                    'OUI':'089BB9',\
                    'Productclass':'Nokia Wifi Beacon 2'}

Ext2 = {'ip':'192.168.1.65', \
                   'temp_ip':'192.168.1.65', \
                   'gui_url1':'http://192.168.1.65', \
                   'model':'Beacon 2', \
					'model_L2':'NOKIA_BEACON_2', \
                   'mac':'38-A0-67-FB-D3-F1', \
                   'mac1':'38-A0-67-FB-D3-F1', \
                   'router-id':'2112844656', \
                   'serial_num':'ALCLB277D616', \
                   'wds_mac':'fc:8f:7d:ef:73:78', \
                   'gui_url':'http://192.168.1.65', \
                   'gui_username':'superadmin', \
                   'gui_password':'FSZbZ27WD.M4',
                    'active_firmware':'3FE49334HJMJ41', \
                   'gui_type':'G240WA', \
                   'ssid_defa_name':'NOKIA-CED0', \
                   'ssid_defa_password':'FSZbZ27WD.M4', \
                   'gui_type':'G240WA', \
                   'opid':'NKBB', \
                   'unium_port':'8090', \
                    'bconType' :'B2',\
                   'country_id':'us', \
                   'telnet_port':'23', \
                   'telnet_username':'superadmin', \
                   'telnet_password':'FSZbZ27WD.M4', \
                   'telnet_vtysh':'EQKARHfcuJ/MLzGVvhiloT66AiPSew5KBxy/NDvxnq16NGY=', \
                   'product_code':'3FE49334', \
				   'TopoDefName':'Nokia WiFi Beacon 2', \
					'defa_frn_name':'Beacon 2 (38-A0-67-FB-D3-F1)', \
                    'defa_frn_name_gui':'APSN97B1', \
                   'defa_frn_name1':'APSN97B1', \
                    'udefi_frn_name': 'Beacon 2 (38-A0-67-FB-D3-F1)', \
                    'OUI':'089BB9',\
                     'Productclass':'Nokia Wifi Beacon 2'}


Ext3 = {'ip':'192.168.1.66', \
                   'temp_ip':'192.168.1.66', \
                   'gui_url1':'http://192.168.1.66', \
                   'model':'Beacon 2',\
					'model_L2':'NOKIA_BEACON_2', \
                   'mac':'38-A0-67-FB-D1-E1', \
                   'mac1':'38-A0-67-FB-D1-E1', \
                   'router-id':'2112844656', \
                   'serial_num':'ALCLB277D5F5', \
                   'wds_mac':'fc:8f:7d:ef:73:78', \
                   'gui_url':'http://192.168.1.66', \
                   'gui_username':'superadmin', \
                   'gui_password':'FSZbZ27WD.M4',
                   'gui_type':'G240WA', \
                   'ssid_defa_name':'NOKIA-CED0', \
                    'bconType' :'B2',\
                   'ssid_defa_password':'FSZbZ27WD.M4', \
                    'active_firmware':'3FE49334HJMJ41', \
                   'gui_type':'G240WA', \
                   'opid':'NKBB', \
                   'unium_port':'8090', \
                   'country_id':'us', \
                   'telnet_port':'23', \
                   'telnet_username':'superadmin', \
                   'telnet_password':'FSZbZ27WD.M4', \
                   'telnet_vtysh':'EJE34AiY3d/hkbF7UPGP/0cCm0WgRbr/EEpFeBdqOwyTzg==', \
                   'product_code':'3FE49334', \
				   'TopoDefName':'Nokia WiFi Beacon 2', \
					'defa_frn_name':'Beacon 2 (38-A0-67-FB-D1-E1)', \
                    'udefi_frn_name': 'Beacon 2 (38-A0-67-FB-D1-E1)', \
                    'defa_frn_name_gui': 'APSN9F9A', \
                    'OUI':'089BB9',\
                    'Productclass':'Nokia Wifi Beacon 2'}



ont_sw_path = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\Builds'
Account         = {'FirstName':'ATC_B6', \
                   'LastName':'', \
                   'Email':'anju.jayan@nokia.com', \
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


NewUser_Credentials1 = {'email':'anjujayank@gmail.com', \
				    'name':'atc_B6_usp', \
                    'first_name':'ETEAuto', \
                    'last_name':'ATC', \
                    'mac':'40-E1-E4-2D-C1-E1', \
                    'X-ServiceType':'KC', \
                    'clientId':'nokiaMobileApp', \
				    'clientSecret':'nokiaMobileAppSecret', \
                    'Content-Type':'application/json', \
                    'password':'tenant3user', \
                    'user_uuid':'undefined', \
                    'access_token':'undefined', \
                    'response_code':'200', \
                    'response_message':'OK',  \
                    'customerID':'tenant3_6730220431',  \
                    'Timezone':'GMT-05:00'}
L2_BackHaul = {'Root': 'Wired', 'Ext1': '5 GHz'}
L2_Verification_Vars_Root = {'Area group': 'vellore RRM', 'RRM profile': 'vellore RRM', 'Model group': 'Beacom3_Group'}
L2_Verification_Vars_Ext = {'Area group': 'TVH Agnito Park', 'RRM profile': 'ECR EU', 'Model group': 'Beacon 2'} #NEW variable


ssh_login={'ipaddresss':'192.168.1.1',\
           'username':'superadmin',\
           'password':'FSZbZ27WD.M4',\
           'password2':'EQFxeOYjC8dnDM2iJO86z79oAQgm9LY5fs64KUkW282baJw='}
ssh_prompt="root@Cortina:/configs/overlay/home/superadmin#"

master_url=""

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
'Name':'CDS',
'Description':'NewConfigPush_CDS',
'Version':'1',
'HwModel':'BEACON 6 HA-0336G-A',
'NewConfigFilePath':'C:\\Users\\ladmin\\Downloads\\CFPNKBU001',
'DefaultConfigFilePath':'',
'Firmware':'3TN00841HJMJ47'
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


Root_Client1 = {'MACAddress': 'D0-37-45-2C-D9-D1', \
                'MACAddress_L': 'ac:57:75:49:4a:19', \
                'udid': 'CTLID19013101302', \
                'hostName': '1N120601H1', \
                'ipAddres': '192.168.1.64',
                'ipV6Addres1': 'fe80::21cc:95d7:ecd9:af6f',
                'ipV6Addres2': 'No IP address allocated',
                'type': 'Desktop', \
                'manufacture': 'TP-Link', \
                'connectionType': 'ethernet', \
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

Root_Client2 = {'MACAddress': '86-68-99-64-B0-76', \
                'MACAddress_L': 'ac:57:75:49:4a:19', \
                'udid': 'CTLID19013101302', \
                'hostName': 'Galaxy-M11', \
                'ipAddres': '192.168.1.68',
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