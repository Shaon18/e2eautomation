# It should contain format for the Setup details
# Make this as a reference and create input file based on the individual setup
# Any new variable or any changes in existing format update this file as well.
import os
currentdirectoryfolder=os.getcwd()
saveScreenShotPath=os.getcwd()
meshNodes=[]
detailsRoot={}
detailsExt1={}
detailsExt2={}
detailsExt3={}

RootClientsCount=""

DeviceStream="HA"
CLI_Prompt="[root@AONT: AdminGPON]#"
Execution = "noSmoke"#Smoke"

# Update the list with if Root and Ext are different models.  Firmware should be available in ont_sw_path
campaignManagerFirmware={
'Name':'3FE49025HJLL37',
'Description':'3FE49062HJLJ43_Beacon_6',
'HwModel': 'G-2425G-A',
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

subMac="40:E1:E4:2D:C3:81"
subName="smoke"
subId=""
subEmail=""
subSerial=""

Root		= {'ip':'192.168.1.254', \
					'mac':'6c:c6:3b:17:4d:50', \
					'mac1':'6C-C6-3B-17-4D-50', \
                    'mac2':'6CC63B174D50',
                    'mac3':'6c-c6-3b-17-4d-50',
                    'mac4':'6cc63b174d50',
					'router-id':'573785184', \
					'model':'G-2425-GA', \
                    'model_L2':'Nokia WiFi Beacon 1.1', \
					'serial_num':'ALCLB3A8D3EC', \
					'gui_url':'https://www.webgui.nokiawifi.com', \
					'gui_username':'AdminGPON', \
					'gui_password':' FDfibMNr724u+9cw', \
					'gui_Normal_User':'admin', \
                    'gui_Normal_User_pwd':'21345',\
					'gui_NormaUser_pwd':'Bcon4269', \
					'ont_gui_username':'superadmin', \
					'gui_type':'B2', \
					'ssid_defa_name':'ALHN-3B15', \
					'ssid_defa_password':'6751268414', \
					'ssid_user_defi_name':'E2E-Auto-B3-Setup1', \
					'ssid_user_defi_password':'ABCD12345', \
					'app_username':'admin', \
					'app_password':'Bcon4269', \
					'opid':'ALCL', \
					'unium_port':'8090', \
					'Type': 'AONT', \
					'country_id':'in', \
					'telnet_port':'22', \
					'telnet_username':'AdminGPON', \
					'telnet_password':'FDfibMNr724u+9cw', \
					'telnet_vtysh':'EQFieuSQI6oAp9tg3sHy4Q6XARhzRKJ5uZozwlwe4FTIYAQ=', \
					'product_code':'3FE49334H', \
				   'TopoDefName':'Nokia WiFi Beacon 1.1', \
					'defa_frn_name':'Beacon 2 (38-A0-67-92-6D-E1)', \
					'defa_frn_name_gui':'Bridge', \
					'defa_frn_name1':'Kitchen', \
					'udefi_frn_name':'RootAtc3', \
					'ssid_defa_name_l2':'NOKIA-6450-4', \
					'ssid_defa_password_l2':'7ca88254a3', \
					'ssid_udef_name_l2':'L2_Bridge_E2E', \
                    'OUI':'6CC63B',\
                    'Productclass':'G-2425G-A'}

Ext1 = {'ip': '192.168.18.7', \
               'temp_ip': '192.168.18.7', \
               'gui_url1': 'http://192.168.1.4', \
               'model': 'Beacon 1.1', \
               'mac': 'E0-1F-2B-B8-85-A1', \
               'mac1': 'E0-1F-2B-B8-85-A1', \
               'TopoDefName': 'Beacon 2 (38-A0-67-91-FF-61)', \
               'router-id': '3331911904', \
               'serial_num': 'ALCLFC383DD7', \
               'wds_mac': '6A:B1:62:36:06:8A', \
               'gui_url': 'http://192.168.18.4', \
               'gui_username': 'superadmin', \
               'gui_password': 'RzjMB9N!Tb', \
               'gui_type': 'HA-020W-B', \
               'ssid_defa_name': 'ALHN-4301', \
               'ssid_defa_password': 'ZJu2k2ddNp', \
               'opid': 'NKBB', \
               'unium_port': '8090', \
               'country_id': 'br', \
               'telnet_port': '23', \
               'telnet_username': 'superadmin', \
               'telnet_password': 'RzjMB9N!Tb', \
               'telnet_vtysh': 'EQLCi711Hb2mUbb6FbiVv17rAi6Oh7Ifkr40PfevTl/WXLM=', \
               'product_code': 'BCM6846', \
               'defa_frn_name': 'Beacon 1.1 (38-A0-67-91-FF-61)', \
               'defa_frn_name_gui': 'APSN9F9A', \
               'OUI':'089BB9',\
                'Productclass':'Beacon 1.1'}


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


ssh_login={'ipaddresss':'192.168.1.254',\
           'username':'AdminGPON',\
           'password':'ENsuH26-9n',\
           'password2':'ELzEGR6gJXnGXgFXdOJkiukBD1EhJGTwnS2/VbGGrBPotA=='}

ssh_prompt="[root@AONT: AdminGPON]#"
master_url=""
