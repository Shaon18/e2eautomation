# It should contain format for the Setup details
# Make this as a reference and create input file based on the individual setup
# Any new variable or any changes in existing format update this file as well.
import os
currentdirectoryfolder=os.getcwd()
saveScreenShotPath=os.getcwd()

DeviceStream="USP"
CLI_Prompt="superadmin#"
Execution = "noSmoke" #Smoke or noSmoke
meshNodes=[]

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
saveScreenShotPath = "C:\\Regression\\New_Framwork_Git_Code\\Log\\SMOKE\\snapshot"

MULTI_TENANT = 'True'  # Set to 'True' when running DeviceAssociation cases in Multi-Tenant enable platform
TENANT_NAME = 'tenant3'  # If Multi Tenent is True, provide Tenant name. #NEW variable
ONTEthPort = "Ethernet 2"  # take from 'netsh interface show interface'

boardModel = 'MTK' ; # MTK for B1 and other MTK boards, Qualcomm for B1/B3 and other Qualcomm boards

network_interface  = 'Ethernet 2' ;# take from 'netsh interface show interface'
proxyflag = 'true' ;# set to 'true' if running from LAB/TPC, 'false' if running from home

fsecureInstallVersionNew="3.5.99.196"
fsecureInstallVersionCurrent="4.0.1"

network_interface  = 'Ethernet 2' ;# take from 'netsh interface show interface'
proxyflag = 'true' ;# set to 'true' if running from LAB/TPC, 'false' if running from home

fsecureInstallVersionNew="3.5.99.196"
fsecureInstallVersionCurrent="4.0.1"

Root		=       {'ip':'192.168.18.1',
                     'mac':'D8:B0:20:FD:6B:40',
                     'mac1':'D8-B0-20-FD-6B-40',
                     #'mac1':'C8-9C-BB-B6-A1-60',
                     'router-id':'573785184',
                     'model':'XS-2437X-B',
                     #'model':'G-1426G-D',
                     'model_L2':'XS-2437X-B',
                     'serial_num':'ALCLEB4A5812',
                     'gui_url':'https://www.webgui.nokiawifi.com',
                     'gui_username':'superadmin',
                     'gui_password':'EWT,k!kja3jgcC-W',
                     'gui_Normal_User':'admin',
                     'gui_Normal_User_pwd':'21345',
                     'gui_NormaUser_pwd':'XGFTX3!tFp',
                     'ont_gui_username':'superadmin',
                     'gui_type':'B2',
                     'ssid_defa_name':'ALHN-5812',
                     'ssid_defa_password':'XGFTX3!tFp',
                     'ssid_user_defi_name':'E2E-Auto-B3-Setup1',
                     'ssid_user_defi_password':'ABCD12345',
                     'app_username':'admin',
                     'app_password':'XGFTX3!tFp',
                     'opid':'NOKL',
                     'unium_port':'8090',
                     'Type': 'AONT',
                     'country_id':'in',
                     'telnet_port':'22',
                     'telnet_username':'superadmin',
                     'telnet_password':'EWT,k!kja3jgcC-W',
                     'telnet_vtysh':'EQEXIERR75RJx3MdfzCAKRhjAjMRIL+pcn7Y1hCk6VQsy6A=',
                     'product_code':'3FE49334H',
                     'TopoDefName':'XS-2437X-B',
                     'defa_frn_name':'XS-2437X-B (D8-B0-20-FD-6B-40)',
                     'defa_frn_name_gui':'Bridge',
                     'defa_frn_name1':'Kitchen',
                     'udefi_frn_name':'RootAtc3',
                     'ssid_defa_name_l2':'NOKIA-6450-4',
                     'ssid_defa_password_l2':'7ca88254a3',
                     'ssid_udef_name_l2':'L2_Bridge_E2E',
                     'OUI':'089BB9',
                     'Productclass':'Beacon 1.1'}

ont_sw_path = 'C:\\Regression\\NWCC_Git_Code\\atc_code\\Builds'
Account         = {'FirstName':'ATC20_XS2437XB', \
                   'LastName':'Sangeeth', \
                   'Email':'atc20_xs2437xb@gmail.com', \
                   'Password':'Nokia@123', \
                   'Key_URL':'https://auth.stg.homewifi.nokia.com/sso/admin/tenant3/console/#/tenant3/users', \
                   'userName':'tenant3keycloak', \
                   'password':'tenant3keycloak', \
                   'Mac_add':Root['mac1'], \
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


NewUser_Credentials1 = {'email': Account['Email'], \
                    'name': Account['FirstName'], \
                    'first_name': 'Sangeeth', \
                    'last_name': 'ATC', \
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
           'password':'cepN2aYFwn',\
           'password2':'ENEMtrny3BCx7AIpuajtX3gDTt6nrTS6tXmbo/7FL51thw=='}
ssh_prompt="root@Beacon 10:/configs/overlay/home/superadmin#"

master_url=""
subMac=Root['mac1']
subName=Account['FirstName']
subId=NewUser_Credentials1['user_uuid']
subEmail=Account['Email']
subSerial=  Root['serial_num']