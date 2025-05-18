# It should contain format for the Setup details
# Make this as a reference and create input file based on the individual setup
# Any new variable or any changes in existing format update this file as well.
import os
currentdirectoryfolder=os.getcwd()
meshNodes=['Ext1', 'Ext2', 'Ext3']
detailsRoot={}
detailsExt1={}
detailsExt2={}
detailsExt3={}

RootClientsCount=""

DeviceStream="USP"
CLI_Prompt="superadmin#"
Execution = "noSmoke"#Smoke"
HomeTroubleshooting="True"

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
TENANT_NAME = 'nokiahwstg'; # If Multi Tenent is True, provide Tenant name. #NEW variable
ONTEthPort = "Ethernet 2" ;# take from 'netsh interface show interface'

boardModel = 'MTK' ; # MTK for B1 and other MTK boards, Qualcomm for B1/B3 and other Qualcomm boards

network_interface  = 'Ethernet 2' ;# take from 'netsh interface show interface'
proxyflag = 'true' ;# set to 'true' if running from LAB/TPC, 'false' if running from home

fsecureInstallVersionNew="3.5.99.196"
fsecureInstallVersionCurrent="4.0.1"

subMac="48-41-7B-18-1C-C1"
subName="smoke"
subId=""
subEmail=""
subSerial=""

########## Change bconType to 'WJ' for WJ, 'B3' for B3.  ##########
Root_bconType = 'B32'
Ext1_bconType = 'B32'
Ext2_bconType = 'B32'
Ext3_bconType = 'B32'

## ONT information
Root         = {'ip': '192.168.28.1', \
                'mac': '48:41:7B:18:1C:C1', \
                'temp_ip': '192.168.1.1', \
                'mac1': '48-41-7B-18-1C-C1', \
                'model': 'AAP321NK', \
                'model_L2':'AAP321NK', \
                'ModelName': 'AAP321NK',
                'router-id': '2112844608', \
                'serial_num': 'ANKAPACE00000043', \
                'gui_url': 'http://www.webgui.nokiawifi.com', \
                'gui_username': 'superadmin', \
                'gui_password': 'ANKAPACE00000043', \
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
                'telnet_password': 'ANKAPACE00000043', \
                'telnet_vtysh': 'EEyc/mr1Q30ye/ILgPqEl7MCRuDPjkbQskkATczyBNHGAA==', \
                'product_code': '3FE49996', \
                'ssid_defa_name_l2': 'NOKIA-D613', \
                'ssid_defa_password_l2': 'F9RfXyssVM', \
                'defa_frn_name': 'Router', \
                'ssid_udef_name_l2': 'L2_Bridge_E2E', \
                'TopoDefName': 'Root', \
                'defa_frn_name': 'G-1426G-A', \
                'defa_frn_name_gui': 'Bridge', \
                'defa_frn_name1': 'Kitchen', \
                'udefi_frn_name': 'AAP321NK (48-41-7B-18-1C-C1)', \
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

Ext1         = {'ip': '192.168.28.3', \
                'model': 'AAP321NK', \
                'model_L2': 'AAP321NK', \
                'temp_ip': '192.168.1.67', \
                'gui_url1': 'http://192.168.1.3', \
                'mac': '48:41:7B:18:1F:D1', \
                'mac1': '48-41-7B-18-1F-D1', \
                'router-id': '2112844640', \
                'serial_num': 'ANKAPACE00000092', \
                'wds_mac': '38:A0:67:FC:0F:11', \
                'gui_url': 'http://192.168.1.3', \
                'gui_username': 'superadmin', \
                'gui_password': 'ANKAPACE00000043', \
                'gui_type': 'G240WA', \
                'ssid_defa_name': 'NOKIA-D613', \
                'ssid_defa_password': 'FLwf5Y8UQG', \
                'opid': 'NKBB', \
                'unium_port': '8090', \
                'country_id': 'eu', \
                'telnet_port': '23', \
                'telnet_username': 'superadmin', \
                'telnet_password': 'ANKAPACE00000043', \
                'telnet_vtysh': 'EGn0oVQjgkRg7fQZIduNRrYDfJBXrtSDamk5G+eiAcPexA==', \
                'product_code': '3FE46864', \
                'TopoDefName': 'Nokia WiFi Beacon 3.1', \
                'defa_frn_name': 'AAP321NK (48-41-7B-18-1F-D1)', \
                'defa_frn_name1': 'APSND9C8', \
                'defa_frn_name_gui': 'APSND9C8', \
                'udefi_frn_name': 'AAP321NK (48-41-7B-18-1F-D1)'}

Ext2         = {'ip': '192.168.28.3', \
                'model': 'AAP321NK', \
                'model_L2': 'AAP321NK', \
                'temp_ip': '192.168.1.67', \
                'gui_url1': 'http://192.168.1.3', \
                'mac': '48:41:7B:18:2A:51', \
                'mac1': '48-41-7B-18-2A-51', \
                'router-id': '2112844640', \
                'serial_num': 'ANKAPACE00000260', \
                'wds_mac': '38:A0:67:FC:0F:11', \
                'gui_url': 'http://192.168.1.3', \
                'gui_username': 'superadmin', \
                'gui_password': 'ANKAPACE00000043', \
                'gui_type': 'G240WA', \
                'ssid_defa_name': 'NOKIA-D613', \
                'ssid_defa_password': 'FLwf5Y8UQG', \
                'opid': 'NKBB', \
                'unium_port': '8090', \
                'country_id': 'eu', \
                'telnet_port': '23', \
                'telnet_username': 'superadmin', \
                'telnet_password': 'ANKAPACE00000043', \
                'telnet_vtysh': 'EQEVFaEkIKOQyFs/2yIZwqKxAqk0rWHW9V6yY7m5Q5Fl0Ro=', \
                'product_code': '3FE46864', \
                'TopoDefName': 'Nokia WiFi Beacon 3.1', \
                'defa_frn_name': 'AAP321NK (48-41-7B-18-2A-51)', \
                'defa_frn_name1': 'APSND9C8', \
                'defa_frn_name_gui': 'APSND9C8', \
                'udefi_frn_name': 'AAP321NK (48-41-7B-18-2A-51)'}

Ext3         = {'ip': '192.168.28.3', \
                'model': 'AAP321NK', \
                'model_L2': 'AAP321NK', \
                'temp_ip': '192.168.1.67', \
                'gui_url1': 'http://192.168.1.3', \
                'mac': '48:41:7B:18:21:61', \
                'mac1': '48-41-7B-18-21-61', \
                'router-id': '2112844640', \
                'serial_num': 'ANKAPACE00000117', \
                'wds_mac': '38:A0:67:FC:0F:11', \
                'gui_url': 'http://192.168.1.3', \
                'gui_username': 'superadmin', \
                'gui_password': 'ANKAPACE00000043', \
                'gui_type': 'G240WA', \
                'ssid_defa_name': 'NOKIA-D613', \
                'ssid_defa_password': 'FLwf5Y8UQG', \
                'opid': 'NKBB', \
                'unium_port': '8090', \
                'country_id': 'eu', \
                'telnet_port': '23', \
                'telnet_username': 'superadmin', \
                'telnet_password': 'ANKAPACE00000043', \
                'telnet_vtysh': 'EBgJYvmrmhiyAlaVG6AFx4gDxQtHwEVpEfPhAsVpi5CGyw==', \
                'product_code': '3FE46864', \
                'TopoDefName': 'Nokia WiFi Beacon 3.1', \
                'defa_frn_name': 'AAP321NK (48-41-7B-18-21-61)', \
                'defa_frn_name1': 'APSND9C8', \
                'defa_frn_name_gui': 'APSND9C8', \
                'udefi_frn_name': 'AAP321NK (48-41-7B-18-21-61)'}

ont_sw_path = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\Builds'
Account         = {'FirstName':'48-41-7B-18-1C-C1', \
                   'LastName':'', \
                   'Email':'Unknown', \
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
                    'last_name':'ATC', \
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
ssh_prompt="root@AAP321NK:/configs/overlay/home/superadmin#"

master_url=""

Selector_path = 'C:\\Regression\\NWCC_Git_Code\\New_Framwork_Git_Code\\e2eautomation\\CortecaConsole\\Locators\\'

saveScreenShotPath = 'C:\\Regression\\NWCC_Git_Code\\New_Framwork_Git_Code\\\Log\\SMOKE\\'


Root_Client1 = {'MACAddress': 'D0-37-45-B7-B2-83', \
                'MACAddress_L': 'ac:57:75:49:4a:19', \
                'udid': 'CTLID19013101302', \
                'hostName': 'ladmin', \
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
