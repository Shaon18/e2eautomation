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
subMac="CC-ED-21-DF-94-50"
subName="smoke"
subId=""
subEmail=""
subSerial=" "




Root_bconType = 'XS2426GA'
Ext1_bconType = 'B2'
Ext2_bconType = 'B2'
Ext3_bconType = 'B2'

Root = {'ip':'192.168.1.254', \
                  'mac':'CC-ED-21-DF-94-50', \
				  'mac1':'CC-ED-21-DF-94-50', \
                   'router-id':'1389194528',\
                   'model':'XS-2426G-A', \
				   'model_L2':'XS-2426G-A', \
                   'ont_gui_username':'AdminGPON', \
                   'Type': 'AONT', \
                   'serial_num':'ALCLFBF9D02D', \
                   'gui_url':'http://www.webgui.nokiawifi.com', \
                   'gui_username':'AdminGPON', \
                   #old#'gui_password':'ALC#FGU', \
				   'gui_password':'KZrLjve83zrN!W8d', \
                   'gui_Normal_User':'userAdmin', \
				   'gui_Normal_User_pwd':'bCw8gdJEEH', \
                   'gui_type':'G240WE', \
                   'ssid_defa_name':'ALHN-D02D', \
                   'ssid_defa_password':'bCw8gdJEEH', \
                    'guest_ssid_name': 'ALHN-D02D_Guest', \
                    'guest_ssid_pass': '12345678', \
                    'ssid_user_defi_name':'E2E-Auto-G3-Setup1', \
                   'ssid_user_defi_password':'ABCD12345', \
                   'app_username':'userAdmin', \
                   'app_password':'bCw8gdJEEH', \
                   'opid':'ALCL', \
                   'unium_port':'8090', \
                   'country_id':'eu', \
                    'bconType' :'XS2426GA' ,\
                   'telnet_port':'23', \
                    'active_firmware':'3FE49385HJMJ38', \
				   'TopoDefName':'XS-2426G-A',\
                   'telnet_username':'AdminGPON', \
                   'telnet_password':'KZrLjve83zrN!W8d', \
                   'telnet_vtysh':'EOQ/l6tAzskeFZDdOe0BSTECrwT9xX3sbV+S6iRW0oCycw==', \
                   'product_code':'3FE48015', \
                   'defa_frn_name':'XS-2426G-A', \
					'defa_frn_name_gui':'Bridge', \
					'defa_frn_name1':'Kitchen', \
					'udefi_frn_name':'8389063240', \

                    'OUI':'089BB9',\
                    'Productclass':'Nokia Wifi Beacon 2',\
                    'customerid':'shaonxa'}

Ext1 =  {'ip':'192.168.1.67', \
                   'model':'Beacon 2', \
                   'model_L2':'NOKIA_BEACON_2', \
                   'temp_ip':'192.168.1.67', \
                   'gui_url1':'http://192.168.1.67', \
                   'mac':'38-A0-67-92-04-B1', \
                   'mac1':'38-A0-67-92-04-B1',\
                   'router-id':'2112844640',\
                   'serial_num':'ALCLB3F497B1', \
                   'wds_mac':'38:A0:67:FC:0F:11', \
                   'gui_url':'http://192.168.1.67', \
                   'gui_username':'superadmin', \
                   'gui_password':'FSZbZ27WD.M4', \
                   'gui_type':'G240WA', \
                   'ssid_defa_name':'NOKIA-CED0', \
                   'ssid_defa_password':'FSZbZ27WD.M4', \
                    'active_firmware':'3FE49334HJMJ38', \
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
					'defa_frn_name':'Beacon 2 (38-A0-67-92-04-B1)', \
                    'defa_frn_name_gui': 'APSN9F9A', \
                    'udefi_frn_name': 'Beacon 2 (38-A0-67-92-04-B1)', \
                    'OUI':'089BB9',\
                    'Productclass':'Nokia Wifi Beacon 2'}

Ext2 = {'ip':'192.168.1.68', \
                   'model':'Beacon 2', \
                   'model_L2':'NOKIA_BEACON_2', \
                   'temp_ip':'192.168.1.67', \
                   'gui_url1':'http://192.168.1.67', \
                   'mac':'38-A0-67-92-70-31', \
                   'mac1':'38-A0-67-92-70-31',\
                   'router-id':'2112844640',\
                   'serial_num':'ALCLB3F49E69', \
                   'wds_mac':'38:A0:67:FC:0F:11', \
                   'gui_url':'http://192.168.1.67', \
                   'gui_username':'superadmin', \
                   'gui_password':'FSZbZ27WD.M4', \
                   'gui_type':'G240WA', \
                   'ssid_defa_name':'NOKIA-CED0', \
                   'ssid_defa_password':'FSZbZ27WD.M4', \
                    'active_firmware':'3FE49334HJMJ38', \
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
					'defa_frn_name':'Beacon 2 (38-A0-67-92-70-31)', \
                    'defa_frn_name_gui': 'APSN9F9A', \
                    'udefi_frn_name': 'Beacon 2 (38-A0-67-92-70-31)', \
                    'OUI':'089BB9',\
                    'Productclass':'Nokia Wifi Beacon 2'}


Ext3 = {'ip':'192.168.1.69', \
                   'model':'Beacon 2', \
                   'model_L2':'NOKIA_BEACON_2', \
                   'temp_ip':'192.168.1.67', \
                   'gui_url1':'http://192.168.1.67', \
                   'mac':'DC-8D-8A-58-2F-C1', \
                   'mac1':'DC-8D-8A-58-2F-C1',\
                   'router-id':'2112844640',\
                   'serial_num':'ALCLEB288D30', \
                   'wds_mac':'38:A0:67:FC:0F:11', \
                   'gui_url':'http://192.168.1.67', \
                   'gui_username':'superadmin', \
                   'gui_password':'FSZbZ27WD.M4', \
                   'gui_type':'G240WA', \
                   'ssid_defa_name':'NOKIA-CED0', \
                   'ssid_defa_password':'FSZbZ27WD.M4', \
                    'active_firmware':'3FE49334HJMJ38', \
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
					'defa_frn_name':'Beacon 2 (DC-8D-8A-58-2F-C1)', \
                    'defa_frn_name_gui': 'APSN9F9A', \
                    'udefi_frn_name': 'Beacon 2 (DC-8D-8A-58-2F-C1)', \
                    'OUI':'089BB9',\
                    'Productclass':'Nokia Wifi Beacon 2'}


########## Change bconType to 'WJ' for WJ, 'B3' for B3.  ##########




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


ssh_login={'ipaddresss':'192.168.1.254',\
           'username':'AdminGPON',\

           'password':'KZrLjve83zrN!W8d',\
           'password2':'EOQ/l6tAzskeFZDdOe0BSTECrwT9xX3sbV+S6iRW0oCycw=='}
ssh_prompt="[root@AONT: AdminGPON]#"

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

Root_Client1 = {'MACAddress': 'D0-37-45-B7-B2-83', \
                'MACAddress_L': 'ac:57:75:49:4a:19', \
                'udid': 'CTLID19013101302', \
                'hostName': 'PF0WPQTK', \
                'ipAddres': '192.168.18.6',
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

Root_Client2 = {'MACAddress': '80-CE-B9-CB-D8-03', \
                'MACAddress_L': 'ac:57:75:49:4a:19', \
                'udid': 'CTLID19013101302', \
                'hostName': 'PT-Galaxy-A7', \
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