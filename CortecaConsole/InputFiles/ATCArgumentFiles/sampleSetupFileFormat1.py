# It should contain format for the Setup details
# Make this as a reference and create input file based on the individual setup
# Any new variable or any changes in existing format update this file as well.
import os
currentdirectoryfolder=os.getcwd()
saveScreenShotPath=os.getcwd()

# clientdeviceslist=['D0-37-45-B7-B2-83','80-CE-B9-CB-D8-03','94-65-2D-07-9D-E9','94-65-2D-07-9D-E9']
# root_name="Nokia WiFi Beacon 2"
meshNodes=[]
meshNodes=['Ext1', 'Ext2', 'Ext3']
detailsRoot={}
detailsExt1={}
detailsExt2={}
detailsExt3={}

RootClientsCount=""

DeviceStream="USP"
CLI_Prompt="superadmin#"
Execution = "Smoke" #Smoke or noSmoke

# Update the list with if Root and Ext are different models.  Firmware should be available in ont_sw_path
campaignManagerFirmware=[{
'Name':'3FE49062HJLJ43_Beacon_6',
'Description':'3FE49062HJLJ43_Beacon_6',
'HwModel':'BEACON 6 HA-0336G-A',
'Version':'2402.243',
'NewFirmware':'3FE49062HJLJ43',
'CurrentFirmware':'3FE49062HJLJ43'}
]


connectedwificlientsname=['PT-Galaxy-A7']
connectedethclientsname=[]
clientsthatareshown=[]

Current_list_of_working_ext=['Ext1','Ext3']


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

boardModel = 'MTK' ; # MTK for B1 and other MTK boards, Qualcomm for B1/B3 and other Qualcomm boards

network_interface  = 'Ethernet 2' ;# take from 'netsh interface show interface'
proxyflag = 'true' ;# set to 'true' if running from LAB/TPC, 'false' if running from home

fsecureInstallVersionNew="3.5.99.196"
fsecureInstallVersionCurrent="4.0.1"

clientmac="D0-37-45-B7-B2-83"
subMac="38-A0-67-92-6D-E1"
subName="smoke"
subId=""
subEmail=""
subSerial=""

########## Change bconType to 'WJ' for WJ, 'B3' for B3.  ##########
Root_bconType = 'B31'
Ext1_bconType = 'B2'
Ext2_bconType = 'B31'
Ext3_bconType = 'B31'

## ONT information
Root         = {'ip': '192.168.18.1', \
                'mac': '40:E1:E4:2D:C3:81', \
                'temp_ip': '192.168.1.1', \
                'mac1': '40-E1-E4-2D-C3-81', \
                'model': 'Beacon 3.1', \
                'model_L2':'Nokia WiFi Beacon 3.1', \
                'ModelName': 'Nokia WiFi Beacon 3.1',
                'router-id': '2112844608', \
                'serial_num': 'ALCLEB413FE0', \
                'gui_url': 'http://www.webgui.nokiawifi.com', \
                'gui_username': 'superadmin', \
                'gui_password': 'FLwf5Y8UQG', \
                'gui_Normal_User': 'userAdmin', \
                'gui_Normal_User_pwd': 'F9RfXyssVM', \
                'gui_type': 'G-1426G-A', \
                'ssid_defa_name': 'NOKIA-D613', \
                'ssid_defa_password': 'F9RfXyssVM', \
                'ssid_user_defi_name': 'E2E-Auto-B3-Setup1', \
                'ssid_user_defi_password': 'ABCD12345', \
                'app_username': 'userAdmin', \
                'app_password': 'F9RfXyssVM', \
                'opid': 'NKBU', \
                'unium_port': '18090', \
                'Type': 'AONT', \
                'country_id': 'us', \
                'telnet_port': '23', \
                'telnet_username': 'superadmin', \
                'telnet_password': 'VEL56gP97V', \
                'telnet_vtysh': 'EFnhioPIBUZB5V948At3fJsBOb2b6pMnnqk5m7Fr45W57w==', \
                'product_code': '3FE49996', \
                'ssid_defa_name_l2': 'NOKIA-D613', \
                'ssid_defa_password_l2': 'F9RfXyssVM', \
                'defa_frn_name': 'Router', \
                'ssid_udef_name_l2': 'L2_Bridge_E2E', \
                'TopoDefName': 'Root', \
                'defa_frn_name': 'G-1426G-A', \
                'defa_frn_name_gui': 'Bridge', \
                'defa_frn_name1': 'Kitchen', \
                'udefi_frn_name': 'Nokia WiFi Beacon 3.1 (DC-8D-8A-FF-D6-13)', \
                'ssid_defa_name_l2': 'NOKIA-6450-4', \
                'ssid_defa_password_l2': '12345678', \
                'ssid_udef_name_l2': 'L2_Bridge_E2E', \
                'L2_LanPort': '2', \
                'L2_SsidPort24': '4', \
                'L2_SsidPort5': '8', \
                'L2_LanPort_1': '3', \
                'L2_SsidPort24_1': '3', \
                'L2_SsidPort5_1': '7', \
                'L2_vlan': '100', \
                'L2_SubNet': '192.168.99.', \
                'L2_vlan': '100', \
                'L2_LanPort': '2', \
                'L2_LanPort_1': '3', \
                'L2_SsidPort24': '4', \
                'L2_SsidPort5': '8', \
                'L2_SubNet': '192.168.99.', }

Ext1         = {'ip': '192.168.1.3', \
                'model': 'Beacon 3.1', \
                'model_L2': 'NOKIA_BEACON_2', \
                'temp_ip': '192.168.1.67', \
                'gui_url1': 'http://192.168.1.3', \
                'mac': '38:A0:67:FC:0F:11', \
                'mac1': '38-A0-67-FC-0F-11', \
                'router-id': '2112844640', \
                'serial_num': 'ALCLEB414006', \
                'wds_mac': '38:A0:67:FC:0F:11', \
                'gui_url': 'http://192.168.1.3', \
                'gui_username': 'superadmin', \
                'gui_password': 'FLwf5Y8UQG', \
                'gui_type': 'G240WA', \
                'ssid_defa_name': 'NOKIA-D613', \
                'ssid_defa_password': 'FLwf5Y8UQG', \
                'opid': 'NKBB', \
                'unium_port': '8090', \
                'country_id': 'eu', \
                'telnet_port': '23', \
                'telnet_username': 'superadmin', \
                'telnet_password': 'FLwf5Y8UQG', \
                'telnet_vtysh': 'EQOqpjDd5muz/ng+33nIv7ZS/5rJvc4uoalq5x28OExe6g==', \
                'product_code': '3FE46864', \
                'TopoDefName': 'Nokia WiFi Beacon 3.1', \
                'defa_frn_name': 'Beacon 2 (38-A0-67-FC-0F-11)', \
                'defa_frn_name1': 'APSND9C8', \
                'defa_frn_name_gui': 'APSND9C8', \
                'udefi_frn_name': 'Ext1'}

Ext2         = {'ip': '192.168.1.3', \
                'model': 'Beacon 3.1', \
                'model_L2': 'Nokia WiFi Beacon 3.1', \
                'temp_ip': '192.168.1.67', \
                'gui_url1': 'http://192.168.1.3', \
                'mac': '38:A0:67:FC:0F:11', \
                'mac1': '38-A0-67-FC-0F-11', \
                'router-id': '2112844640', \
                'serial_num': 'ALCLEB414006', \
                'wds_mac': '38:A0:67:FC:0F:11', \
                'gui_url': 'http://192.168.1.3', \
                'gui_username': 'superadmin', \
                'gui_password': 'FLwf5Y8UQG', \
                'gui_type': 'G240WA', \
                'ssid_defa_name': 'NOKIA-D613', \
                'ssid_defa_password': 'FLwf5Y8UQG', \
                'opid': 'NKBB', \
                'unium_port': '8090', \
                'country_id': 'eu', \
                'telnet_port': '23', \
                'telnet_username': 'superadmin', \
                'telnet_password': 'FLwf5Y8UQG', \
                'telnet_vtysh': 'EQOqpjDd5muz/ng+33nIv7ZS/5rJvc4uoalq5x28OExe6g==', \
                'product_code': '3FE46864', \
                'TopoDefName': 'Nokia WiFi Beacon 3.1', \
                'defa_frn_name': 'Beacon 2 (38-A0-67-FC-0F-11)', \
                'defa_frn_name1': 'APSND9C8', \
                'defa_frn_name_gui': 'APSND9C8', \
                'udefi_frn_name': 'Ext2'}

Ext3         = {'ip': '192.168.1.3', \
                'model': 'Beacon 3.1', \
                'model_L2': 'Nokia WiFi Beacon 3.1', \
                'temp_ip': '192.168.1.67', \
                'gui_url1': 'http://192.168.1.3', \
                'mac': '38:A0:67:FC:0F:11', \
                'mac1': '38-A0-67-FC-0F-11', \
                'router-id': '2112844640', \
                'serial_num': 'ALCLEB414006', \
                'wds_mac': '38:A0:67:FC:0F:11', \
                'gui_url': 'http://192.168.1.3', \
                'gui_username': 'superadmin', \
                'gui_password': 'FLwf5Y8UQG', \
                'gui_type': 'G240WA', \
                'ssid_defa_name': 'NOKIA-D613', \
                'ssid_defa_password': 'FLwf5Y8UQG', \
                'opid': 'NKBB', \
                'unium_port': '8090', \
                'country_id': 'eu', \
                'telnet_port': '23', \
                'telnet_username': 'superadmin', \
                'telnet_password': 'FLwf5Y8UQG', \
                'telnet_vtysh': 'EQOqpjDd5muz/ng+33nIv7ZS/5rJvc4uoalq5x28OExe6g==', \
                'product_code': '3FE46864', \
                'TopoDefName': 'Nokia WiFi Beacon 3.1', \
                'defa_frn_name': 'Beacon 2 (38-A0-67-FC-0F-11)', \
                'defa_frn_name1': 'APSND9C8', \
                'defa_frn_name_gui': 'APSND9C8', \
                'udefi_frn_name': 'Ext3'}

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
           'password':'RzjMB9N!Tb',\
           'password2':'EAT9OvxUYS+yXblzGrTp9wgDwodIlX/16HHgbp+Rv/0/Iw=='}
ssh_prompt="root@Beacon 6:/configs/overlay/home/superadmin#"

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
