# It should contain format for the Setup details
# Make this as a reference and create input file based on the individual setup
# Any new variable or any changes in existing format update this file as well.
import os
currentdirectoryfolder=os.getcwd()
saveScreenShotPath=os.getcwd()
meshNodes=['Ext1', 'Ext2','Ext3']
detailsRoot={}
detailsExt1={}
detailsExt2={}
detailsExt3={}


########## Change bconType to 'WJ' for WJ, 'B3' for B3.  ##########
Root_bconType = 'G1426GA'
Ext1_bconType = 'B31'
Ext2_bconType = 'B31'
Ext3_bconType = 'B31'

RootClientsCount=""

DeviceStream="HA"
CLI_Prompt="root@AONT:/configs/overlay/home/AdminGPON#"
Execution = "noSmoke"#Smoke"

# Update the list with if Root and Ext are different models.  Firmware should be available in ont_sw_path
campaignManagerFirmware={
'Name':'3TN00383JJLL13',
'Description':'3FE49062HJLJ43_Beacon_6',
'HwModel': 'G-1426G-A',
'Version':'2402.243',
'NewFirmware':'3FE49062HJLJ43',
'CurrentFirmware':'3FE49025HJLL41'}


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


Root		= {'ip':'192.168.1.254', \
					'mac':'60:bd:2c:ee:0d:90', \
					'mac1':'60-BD-2C-EE-0D-90', \
                    'mac2':'60BD2CEE0D90',
                    'mac3':'6c-bd-2c-ee-0d-90',
                    'mac4':'60bd2cee0d90',
					'router-id':'573785184', \
					'model':'G-1426G-A', \
                    'model_L2':'G-1426G-A', \
					'serial_num':'ALCLB3A8D3EC', \
					'gui_url':'https://www.webgui.nokiawifi.com', \
					'gui_username':'AdminGPON', \
					'gui_password':'fTLCW7_CSt_4Xshj', \
					'gui_Normal_User':'userAdmin', \
                    'gui_Normal_User_pwd':'gfJEEffj5!5t',\
					'gui_NormaUser_pwd':'Bcon4269', \
					'ont_gui_username':'AdminGPON', \
					'gui_type':'B6', \
					'ssid_defa_name':'ALHN-3B15', \
					'ssid_defa_password':'6751268414', \
					'ssid_user_defi_name':'E2E-Auto-B3-Setup1', \
					'ssid_user_defi_password':'ABCD12345', \
					'app_username':'userAdmin', \
					'app_password':'gfJEEffj5!5t', \
					'opid':'ALCL', \
					'unium_port':'8090', \
					'Type': 'AONT', \
					'country_id':'in', \
					'telnet_port':'22', \
					'telnet_username':'AdminGPON', \
					'telnet_password':'fTLCW7_CSt_4Xshj', \
					'telnet_vtysh':'EQKWBsLn3fRjNLN/Ui+91kInAhYMIwlfkazkRikIQ73y3b0=', \
					'product_code':'3FE49334H', \
				    'TopoDefName':'Nokia WiFi Beacon 1.1', \
					'defa_frn_name':'Beacon 2 (60-BD-2C-EE-0D-90)', \
					'defa_frn_name_gui':'Bridge', \
					'defa_frn_name1':'Kitchen', \
					'udefi_frn_name':'G-1426G-A', \
					'ssid_defa_name_l2':'NOKIA-6450-4', \
					'ssid_defa_password_l2':'7ca88254a3', \
					'ssid_udef_name_l2':'L2_Bridge_E2E', \
                    'OUI':'6CC63B',\
                    'Productclass':'G-2425G-A'}

Ext1 = {'ip': '192.168.1.67', \
                'model': 'Beacon 3.1', \
                'model_L2': 'NOKIA_BEACON_3.1', \
                'temp_ip': '192.168.1.67', \
                'gui_url1': 'http://192.168.1.67', \
                'mac': 'DC:8D:8A:FF:D5:93', \
                'mac1': 'DC-8D-8A-FF-D5-93', \
                'router-id': '2112844640', \
                'serial_num': 'ALCLEB413FC8', \
                'wds_mac': '38:A0:67:FC:0F:11', \
                'gui_url': 'http://192.168.1.67', \
                'gui_username': 'AdminGPON', \
                'gui_password': 'fTLCW7_CSt_4Xshj', \
                'gui_type': 'G240WA', \
                'ssid_defa_name': 'ALHN-9810', \
                'ssid_defa_password': 'aPnjg7c!Eh', \
                'opid': 'NOKL', \
                'unium_port': '8090', \
                'country_id': 'us', \
                'telnet_port': '23', \
                'telnet_username': 'AdminGPON', \
                'telnet_password': 'fTLCW7_CSt_4Xshj', \
                'telnet_vtysh': 'EQNM8WfJYY7zKsU22D1mzv/DA6VC0fzwFte53mGoxbfnRgA=', \
                'product_code': '3FE49334', \
                'TopoDefName': 'Nokia WiFi Beacon 3.1', \
                'defa_frn_name': 'Beacon 3.1 (DC-8D-8A-FF-D5-93)', \
                'defa_frn_name1': 'APSND9C8', \
                'defa_frn_name_gui': 'APSND9C8', \
                'udefi_frn_name': 'Kitchen'}

Ext2 = {'ip': '192.168.1.68', \
                'model': 'Beacon 3.1', \
                'model_L2': 'NOKIA_BEACON_3.1', \
                'temp_ip': '192.168.1.68', \
                'gui_url1': 'http://192.168.1.68', \
                'mac': 'DC:8D:8A:FF:D8:B3', \
                'mac1': 'DC-8D-8A-FF-D8-B3', \
                'router-id': '2112844640', \
                'serial_num': 'ALCLEB41400A', \
                'wds_mac': 'DC:8D:8A:FF:D8:B3', \
                'gui_url': 'http://192.168.1.68', \
                'gui_username': 'AdminGPON', \
                'gui_password': 'fTLCW7_CSt_4Xshj', \
                'gui_type': 'G240WA', \
                'ssid_defa_name': 'ALHN-9810', \
                'ssid_defa_password': 'aPnjg7c!Eh', \
                'opid': 'NOKL', \
                'unium_port': '8090', \
                'country_id': 'us', \
                'telnet_port': '23', \
                'telnet_username': 'AdminGPON', \
                'telnet_password': 'fTLCW7_CSt_4Xshj', \
                'telnet_vtysh': 'EO/BtD3lE8ocDfxgIRqJcVwDa8OfGa4VZ98eoMDcOoCVgA==', \
                'product_code': '3FE49334', \
                'TopoDefName': 'Nokia WiFi Beacon 3.1', \
                'defa_frn_name': 'Beacon 3.1 (DC-8D-8A-FF-D8-B3)', \
                'defa_frn_name1': 'APSND9C8', \
                'defa_frn_name_gui': 'APSND9C8', \
                'udefi_frn_name': 'Study'}

Ext3 = {'ip': '192.168.1.66', \
               'temp_ip': '192.168.1.66', \
               'gui_url1': 'http://192.168.1.66', \
               'model': 'Beacon 2', \
               'model_L2': 'NOKIA_BEACON_2', \
               'mac': 'DC:8D:8A:57:D5:41', \
               'mac1': 'DC-8D-8A-57-D5-41', \
               'router-id': '2112844656', \
               'serial_num': 'ALCLEB288788', \
               'wds_mac': 'dc:8d:8a:57:d5:41', \
               'gui_url': 'http://192.168.1.66', \
               'gui_username': 'AdminGPON', \
               'gui_password': 'FSZbZ27WD.M4',
               'gui_type': 'B2', \
               'ssid_defa_name': 'NOKIA-CED0', \
               'ssid_defa_password': '2832428301', \
               'gui_type': 'G240WA', \
               'opid': 'NKBB', \
               'unium_port': '8090', \
               'country_id': 'eu', \
               'telnet_port': '23', \
               'telnet_username': 'AdminGPON', \
               'telnet_password': 'fTLCW7_CSt_4Xshj', \
               'telnet_vtysh': 'EKEkFJGLMKN3PWd+fdlRbtsCvi2UblonAPNjyWNx00jRXw==', \
               'product_code': '3FE49334HJ', \
               'TopoDefName': 'Nokia WiFi Beacon 2', \
               'defa_frn_name': 'Beacon 2 (AC-8F-A9-AA-21-31)', \
               'defa_frn_name1': 'APSND5F5', \
               'defa_frn_name_gui': 'APSND5F5', \
               'udefi_frn_name': 'Ext3-Beacon2'}




ont_sw_path = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\Builds'
Account         = {'FirstName':'ATC15_GA_HA', \
                   'LastName':'', \
                   'Email':'atc15_ha_2502@gmail.com', \
                   'Password':'Qwertty123@', \
                   'Key_URL':'https://auth.stg.homewifi.nokia.com/sso/admin/tenant3/console/#/tenant3/users', \
                   'userName':'tenant3keycloak', \
                   'password':'tenant3keycloak', \
                   'Mac_add':'', \
                   'KEYCLOAK_URL': 'https://auth.stg.homewifi.nokia.com/sso/admin/tenant3/console/', \
                   'KEYCLOAK_REALM': 'tenant3', \
                   'KEYCLOAK_CLIENT_ID': 'portal_nokiahwstg'}

User_Credentials = {'email':'atc15_ha_2502@gmail.com', \
				    'name':'ATC15_GA_HA', \
                    'first_name':'ETEAuto', \
                    'last_name':'ATC', \
                    'mac':'E0-1F-2B-B8-8F-11', \
                    'X-ServiceType':'KC', \
                    'clientId':'nokiaMobileApp', \
				    'clientSecret':'nokiaMobileAppSecret', \
                    'Content-Type':'application/json', \
                    'password':'Nokia@123', \
                    'user_uuid':'undefined', \
                    'access_token':'undefined', \
                    'response_code':'200', \
                    'response_message':'OK' }


NewUser_Credentials1 = {'email': 'atc15_ha_2502@gmail.com', \
                    'name': 'ATC15_GA_HA', \
                    'first_name': 'Sri', \
                    'last_name': 'team', \
                    'mac': Root['mac1'], \
                    'X-ServiceType': 'KC', \
                    'clientId': 'nokiaMobileApp', \
                    'clientSecret': 'nokiaMobileAppSecret', \
                    'Content-Type': 'application/json', \
                    'password': 'Nokia@123', \
                    'user_uuid': 'tenant3_3817273983', \
                    'access_token': 'undefined', \
                    'response_code': '200', \
                    'response_message': 'OK'}
L2_BackHaul = {'Root': 'Wired', 'Ext1': '5 GHz'}
L2_Verification_Vars_Root = {'Area group': 'vellore RRM', 'RRM profile': 'vellore RRM', 'Model group': 'Beacom3_Group'}
L2_Verification_Vars_Ext = {'Area group': 'TVH Agnito Park', 'RRM profile': 'ECR EU', 'Model group': 'Beacon 2'} #NEW variable


ssh_login={'ipaddresss':'192.168.1.254',\
           'username':'AdminGPON',\
           'password':'ENsuH26-9n',\
           'password2':'ELzEGR6gJXnGXgFXdOJkiukBD1EhJGTwnS2/VbGGrBPotA=='}

ssh_prompt="root@AONT:/configs/overlay/home/AdminGPON#"
master_url=""


Root_Clients = '2'
Ext1_Clients = '0'
Ext2_Clients = '0'
Ext3_Clients = '0'

Root_Client1 = {'MACAddress': '70-B3-D5-8B-E3-F6',
                'ipAddres': '192.168.1.64',
                'connectionType': 'ethernet',
                'connectedTo': Root['TopoDefName'],
                'portNumber': '2',
                'hostName': '4CE0471YFT',
                'udid' : 'NA',
                'ssid': 'NA'
                }

Root_Client2 = {'MACAddress': '86-AC-58-4F-45-70',
                'ipAddres': '192.168.1.64',
                'connectionType': 'wifi',
                'connectedTo': Root['TopoDefName'],
                'ssid': Root['ssid_user_defi_name'],
                'udid' : '93L4C20709000610',
                'hostName': 'Galaxy-A12',
                'portNumber': 'NA'
                }

subMac=Root['mac1']
subName=Account['FirstName']
subId=NewUser_Credentials1['user_uuid']
subEmail=Account['Email']
subSerial=  Root['serial_num']
