# It should contain format for the Setup details
# Make this as a reference and create input file based on the individual setup
# Any new variable or any changes in existing format update this file as well.
import os
currentdirectoryfolder=os.getcwd()
saveScreenShotPath=os.getcwd()


meshNodes=['Ext1','Ext2','Ext3']
# RootClientsCount=""

DeviceStream="USP"
CLI_Prompt="superadmin#"
Execution = "noSmoke" #Smoke or noSmoke
BridgeModeConfig = 'yes'

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
Root_Clients = '1'
Ext1_Clients = '2'
Ext2_Clients = '0'
Ext3_Clients = '0'

Root_wifi_Clients = '0'
Ext1_wifi_Clients = '1'
Ext2_wifi_Clients = '0'
Ext3_wifi_Clients = '0'



# clientsthatareshown=[]


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

fsecureInstallVersionNew="4.0.1"
fsecureInstallVersionCurrent="4.0.1"

Root_bconType = 'B19'
Ext1_bconType = 'B19'

Root		= {'ip':'192.168.254.254',
               'mac':'48:41:7b:67:04:a0',
               'mac1':'48-41-7B-67-04-A0',
               'model':'Beacon 19',
               'model_L2':'Nokia WiFi Beacon 19',
               'serial_num':'ALCLEB48B2BC',
               'gui_url':'https://www.webgui.nokiawifi.com',
               'gui_username':'superadmin',
               'gui_password':'R9jEamAxgN',
               'gui_Normal_User':'admin',
               'gui_Normal_User_pwd':'NZWYf7QMYD',
               'ssid_defa_name':'KINETIC_7_6704a0',
               'ssid_defa_password':'NZWYf7QMYD',
               'guest_ssid_name':'KINETIC_LM_6704a0' ,
               'guest_ssid_pass':'12345678' ,
               'telnet_username':'superadmin',
               'telnet_password':'NZWYf7QMYD',
               'telnet_vtysh':'EQJYI5r8IYw1c8lNYvCfHRLTRjEjaCej2+pPR9qzn+HR4Q==',
               'OUI':'AC9CE4',
               'Productclass':'Beacon 19',
               'udefi_frn_name':'Nokia WiFi Beacon 19 (48-41-7B-67-04-A0)',
               'TopoDefName':'Nokia WiFi Beacon 19'
               # 'router-id':'573785184',
               # 'gui_NormaUser_pwd':'SxArTbX2Ec',
               # 'ont_gui_username':'superadmin',
               # 'gui_type':'B6',
               # 'bconType':'B6',
               # 'ssid_user_defi_name':'E2E-Auto-B3-Setup1',
               # 'ssid_user_defi_password':'ABCD12345',
               # 'app_username':'admin',
               # 'app_password':'SxArTbX2Ec',
               # 'opid':'NKBU',
               # 'unium_port':'8090',
               # 'active_firmware':'3FE49062HJLL92',
               # 'Type': 'AONT',
               # 'country_id':'us',
               # 'telnet_port':'22',
               # 'product_code':'001122',
               # 'defa_frn_name':'BEACON 6 HA-0336G-A',
               # 'defa_frn_name_gui':'Bridge',
               # 'defa_frn_name1':'Kitchen',
               # 'ssid_defa_name_l2':'NOKIA-6450-4',
               # 'ssid_defa_password_l2':'7ca88254a3',
               # 'ssid_udef_name_l2':'L2_Bridge_E2E',
               }

Ext1		= {'ip':'192.168.18.1',
               'mac':'14:55:B9:73:CD:20',
               'mac1':'14-55-B9-73-CD-20',
               'router-id':'573785184',
               'model':'Beacon 6',
               'model_L2':'NOKIA_BEACON_6',
               'serial_num':'ALCLEB4B92DF',
               'gui_url':'https://www.webgui.nokiawifi.com',
               'gui_username':'superadmin',
               'gui_password':'gSzpyHAG2G',
               'gui_Normal_User':'admin',
               'gui_Normal_User_pwd':'pN2qWPBAdN',
               'gui_NormaUser_pwd':'pN2qWPBAdN',
               'ont_gui_username':'superadmin',
               'gui_type':'B6',
               'bconType':'B6',
               'ssid_defa_name':'NOKIA-CD20',
               'ssid_defa_password':'pN2qWPBAdN',
               'guest_ssid_name':'NOKIA-CD20_Guest' ,
               'guest_ssid_pass':'12345678' ,
               'ssid_user_defi_name':'E2E-Auto-B3-Setup1',
               'ssid_user_defi_password':'ABCD12345',
               'app_username':'admin',
               'app_password':'pN2qWPBAdN',
               'opid':'NKBU',
               'unium_port':'8090',
               'active_firmware':'3FE49062HJLL92',
               'Type': 'AONT',
               'country_id':'us',
               'telnet_port':'22',
               'telnet_username':'superadmin',
               'telnet_password':'gSzpyHAG2G',
               'telnet_vtysh':'EKpRKRMxsWKsmvLzQjSU0tgD+NNHtCsToYQdNl+j8VXH0A==',
               'product_code':'001122',
               'TopoDefName':'Nokia WiFi Beacon 6',
               'defa_frn_name':'Beacon 6 (14-55-B9-73-CD-20)',
               'defa_frn_name_gui':'Bridge',
               'defa_frn_name1':'Kitchen',
               'udefi_frn_name':'Nokia WiFi Beacon 6',
               'ssid_defa_name_l2':'NOKIA-6450-4',
               'ssid_defa_password_l2':'7ca88254a3',
               'ssid_udef_name_l2':'L2_Bridge_E2E',
               'OUI':'F89B6E',
               'Productclass':'XS-2426G-B'}

Ext1 = {'ip':'192.168.254.4',
               'mac':'48:41:7B:67:06:30',
               'mac1':'48-41-7B-67-06-30',
               'model':'Beacon 19',
               'model_L2':'Nokia WiFi Beacon 19',
               'serial_num':'ALCLEB48B2D5',
               'gui_url':'https://192.168.254.4',
               'gui_username':'superadmin',
               'gui_password':'R9jEamAxgN',
               'gui_Normal_User':'admin',
               'gui_Normal_User_pwd':'NZWYf7QMYD',
               'ssid_defa_name':'KINETIC_7_6704a0',
               'ssid_defa_password':'NZWYf7QMYD',
               'guest_ssid_name':'KINETIC_LM_6704a0' ,
               'guest_ssid_pass':'12345678' ,
               'telnet_username':'superadmin',
               'telnet_password':'NZWYf7QMYD',
               'telnet_vtysh':'EQP5CzhP1DPUR3eCNudQqHgawpFurN2lcanvw4fMk5rGDQ==',
               'OUI':'AC9CE4',
               'Productclass':'Beacon 19',
               'udefi_frn_name':'Nokia WiFi Beacon 19 (48-41-7B-67-06-30)',
               'TopoDefName':'Nokia WiFi Beacon 19'
               # 'router-id':'573785184',
               # 'gui_NormaUser_pwd':'SxArTbX2Ec',
               # 'ont_gui_username':'superadmin',
               # 'gui_type':'B6',
               # 'bconType':'B6',
               # 'ssid_user_defi_name':'E2E-Auto-B3-Setup1',
               # 'ssid_user_defi_password':'ABCD12345',
               # 'app_username':'admin',
               # 'app_password':'SxArTbX2Ec',
               # 'opid':'NKBU',
               # 'unium_port':'8090',
               # 'active_firmware':'3FE49062HJLL92',
               # 'Type': 'AONT',
               # 'country_id':'us',
               # 'telnet_port':'22',
               # 'product_code':'001122',
               # 'defa_frn_name':'BEACON 6 HA-0336G-A',
               # 'defa_frn_name_gui':'Bridge',
               # 'defa_frn_name1':'Kitchen',
               # 'ssid_defa_name_l2':'NOKIA-6450-4',
               # 'ssid_defa_password_l2':'7ca88254a3',
               # 'ssid_udef_name_l2':'L2_Bridge_E2E',
               }

Ext2 = {'ip':'192.168.254.5',
               'mac':'48:41:7B:67:09:40',
               'mac1':'48-41-7B-67-09-40',
               'model':'Beacon 19',
               'model_L2':'Nokia WiFi Beacon 19',
               'serial_num':'ALCLEB48B306',
               'gui_url':'https://192.168.254.5',
               'gui_username':'superadmin',
               'gui_password':'R9jEamAxgN',
               'gui_Normal_User':'admin',
               'gui_Normal_User_pwd':'NZWYf7QMYD',
               'ssid_defa_name':'KINETIC_7_6704a0',
               'ssid_defa_password':'NZWYf7QMYD',
               'guest_ssid_name':'KINETIC_LM_6704a0' ,
               'guest_ssid_pass':'12345678' ,
               'telnet_username':'superadmin',
               'telnet_password':'NZWYf7QMYD',
               'telnet_vtysh':'EQEELEyjf/7iBd5Jhr68qKpoAkZGrTm/h1RMzEpB/WuEJ5E=',
               'OUI':'AC9CE4',
               'Productclass':'Beacon 19',
               'udefi_frn_name':'Nokia WiFi Beacon 19 (48-41-7B-67-09-40)',
               'TopoDefName':'Nokia WiFi Beacon 19'
               # 'router-id':'573785184',
               # 'gui_NormaUser_pwd':'SxArTbX2Ec',
               # 'ont_gui_username':'superadmin',
               # 'gui_type':'B6',
               # 'bconType':'B6',
               # 'ssid_user_defi_name':'E2E-Auto-B3-Setup1',
               # 'ssid_user_defi_password':'ABCD12345',
               # 'app_username':'admin',
               # 'app_password':'SxArTbX2Ec',
               # 'opid':'NKBU',
               # 'unium_port':'8090',
               # 'active_firmware':'3FE49062HJLL92',
               # 'Type': 'AONT',
               # 'country_id':'us',
               # 'telnet_port':'22',
               # 'product_code':'001122',
               # 'defa_frn_name':'BEACON 6 HA-0336G-A',
               # 'defa_frn_name_gui':'Bridge',
               # 'defa_frn_name1':'Kitchen',
               # 'ssid_defa_name_l2':'NOKIA-6450-4',
               # 'ssid_defa_password_l2':'7ca88254a3',
               # 'ssid_udef_name_l2':'L2_Bridge_E2E',
               }
Ext3 = {'ip':'192.168.254.4',
               'mac':'48:41:7B:67:09:70',
               'mac1':'48-41-7B-67-09-70',
               'model':'Beacon 19',
               'model_L2':'Nokia WiFi Beacon 19',
               'serial_num':'ALCLEB48B309',
               'gui_url':'https://192.168.254.4',
               'gui_username':'superadmin',
               'gui_password':'R9jEamAxgN',
               'gui_Normal_User':'admin',
               'gui_Normal_User_pwd':'NZWYf7QMYD',
               'ssid_defa_name':'KINETIC_7_6704a0',
               'ssid_defa_password':'NZWYf7QMYD',
               'guest_ssid_name':'KINETIC_LM_6704a0' ,
               'guest_ssid_pass':'12345678' ,
               'telnet_username':'superadmin',
               'telnet_password':'NZWYf7QMYD',
               'telnet_vtysh':'EQI3d2SO1o7j9iMyquoVPXqkA4nYyVQpB9YowZAZt5mpa+4=',
               'OUI':'AC9CE4',
               'Productclass':'Beacon 19',
               'udefi_frn_name':'Nokia WiFi Beacon 19 (48-41-7B-67-09-70)',
               'TopoDefName':'Nokia WiFi Beacon 19'
               # 'router-id':'573785184',
               # 'gui_NormaUser_pwd':'SxArTbX2Ec',
               # 'ont_gui_username':'superadmin',
               # 'gui_type':'B6',
               # 'bconType':'B6',
               # 'ssid_user_defi_name':'E2E-Auto-B3-Setup1',
               # 'ssid_user_defi_password':'ABCD12345',
               # 'app_username':'admin',
               # 'app_password':'SxArTbX2Ec',
               # 'opid':'NKBU',
               # 'unium_port':'8090',
               # 'active_firmware':'3FE49062HJLL92',
               # 'Type': 'AONT',
               # 'country_id':'us',
               # 'telnet_port':'22',
               # 'product_code':'001122',
               # 'defa_frn_name':'BEACON 6 HA-0336G-A',
               # 'defa_frn_name_gui':'Bridge',
               # 'defa_frn_name1':'Kitchen',
               # 'ssid_defa_name_l2':'NOKIA-6450-4',
               # 'ssid_defa_password_l2':'7ca88254a3',
               # 'ssid_udef_name_l2':'L2_Bridge_E2E',
               }


Root_Client1 = {'MACAddress': '70-B3-D5-8B-E3-AA',
                'MACAddress_L': '70:B3:D5:8B:E3:AA',
				'type': 'Other',
				'connectionType': 'ethernet',
				'udid': 'NA',
				'hostName': 'SGH752S12B',
				'manufacture': 'Connoiseur Electronics Private',
				'model': 'N/A',
				'mobility': 'Unknown',
				'ssid': 'N/A for Ethernet',
				'WiFi Standard':'N/A for Ethernet',
				'WiFi Band':'N/A for Ethernet',
                'multiLinkOperation': 'No',
                'singnalStrength': 'N/A for Ethernet',
				'txRate': '1.0 Gbps',
                'rxRate': '1.0 Gbps',
				'portNumber': '2',
                'ipAddres': '192.168.254.1',
                'ipV6Addres1': 'No IP address allocated',
                'ipV6Addres2': 'No IP address allocated',
                'connectedTo': Root['udefi_frn_name'],
                'internetAccess': 'Enabled'
                }

Ext1_Client1 = {'MACAddress': '4C-D3-AF-53-5E-71',
                'MACAddress_L': '4c:d3:af:53:5e:71',
				'type': 'Phone',
				'connectionType': 'wifi',
				'udid': '319655YA1292700207',
				'hostName': 'Mobile',
				'manufacture': 'Nokia',
				'model': 'Mobile',
				'mobility': 'Mobile',
				'ssid': 'KINETIC_7_6704a0',
				'WiFi Standard':'802.11ac',
				'WiFi Band':'5*',
                'multiLinkOperation': 'No',
                'singnalStrength': 'High (-23 dBm)',
				'txRate': '325 Mbps',
                'rxRate': '6 Mbps',
				'portNumber': 'N/A for wireless',
                'ipAddres': '192.168.254.8',
                'ipV6Addres1': 'fe80::ec13:7b94:b766:a7d3',
                'ipV6Addres2': 'No IP address allocated',
                'connectedTo': Ext1['udefi_frn_name'],
                'internetAccess': 'Enabled'
                }
Ext1_Client2={'MACAddress': '98-25-4A-5B-F8-BD',
                'MACAddress_L': '98:25:4a:5b:f8:bd',
				'type': 'Desktop',
				'connectionType': 'ethernet',
				'udid': 'NA',
				'hostName': 'ladmin',
				'manufacture': 'TP-Link',
				'model': 'Computer',
				'mobility': 'STATIC',
				'ssid': 'N/A for Ethernet',
				'WiFi Standard':'N/A for Ethernet',
				'WiFi Band':'N/A for Ethernet',
                'multiLinkOperation': 'No',
                'singnalStrength': 'N/A for Ethernet',
				'txRate': '1.0 Gbps',
                'rxRate': '1.0 Gbps',
				'portNumber': '3',
                'ipAddres': '192.168.254.6',
                'ipV6Addres1': 'No IP address allocated',
                'ipV6Addres2': 'No IP address allocated',
                'connectedTo': Ext1['udefi_frn_name'],
                'internetAccess': 'Enabled'
                }
########## Change bconType to 'WJ' for WJ, 'B3' for B3.  ##########
Root_bconType = 'B19'
Ext1_bconType = 'B19'

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
ssh_prompt="root@Beacon 6"



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

campaignManagerApplication=[ {
'Application':'Nokia Fingerprint',
'appUuid':'2cbf535a-7965-5260-a98a-02ce2977723c',
'Name':'fingerPrintRulecreation',
'HwModel':['BEACON 6 HA-0336G-A'],
'FirmwareVersions':['3FE49062HJLL92'],
'HwMacs':["14-55-B9-73-CD-20"],
'OtherHwModel':['Nokia WiFi Beacon G6'], #should be different model than given in HwModel list and also should support given AppVersion
'OtherFirmware':['3FE49996HJLJ99'], #should be firmware support model than given in OtherHwModel
'AppVersion':'4.0.1',
'UpdateVersion':'0.0.1'
}]

HomeTroubleshooting=True
FPInstallVersionCurrent="4.0.1"
FsecureInstallVersionCurrent="4.0.1"

# Campaign config file
# 'WrongMac': -> MAC of a different Model AP which not in the current Setup.
campaignManagerConfigFileDict={
'Name':'CampaignConfigB19Group',
'Description':'NewConfigPush_Beacon_19',
'Version':'1',
'HwModel':'Nokia WiFi Beacon 19',
'CSVDeviceFilePath':'C:\\Users\\ladmin\\Desktop\Anju\\2502campaign.csv',
'Firmware':'3FE49062HJLL92',
'softwareUpgradeImagePath':'C:\\Regression\\NWCC_Git_Code\\NewFrameworkCodeLatest\\e2eautomation\\CortecaConsole\\Build\\3FE49062HJLL92_B6',
'WrongMac':'08-9B-B9-C6-5C-51'
}

# clientmac="D0-37-45-B7-B2-83"
master_url=""
subMac=Root['mac1']
subName=Account['FirstName']
subId=NewUser_Credentials1['user_uuid']
subEmail=Account['Email']
subSerial=  Root['serial_num']