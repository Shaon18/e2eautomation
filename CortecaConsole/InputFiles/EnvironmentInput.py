# Environment variables, such as paths.
# dont use _,- for variable declaration
import json
import os
currentdirectoryfolder=os.getcwd()
browserOption="Chrome"
Downloads=r"C:\Users\ladmin\Downloads"
cloudDetail   = {'URL':'https://homeconsole1.stg.homewifi.nokia.com/tenant3', \
                   'remoteMobileAccess':'https://l1api.stg.homewifi.nokia.com', \
				   'ApiURL':'https://l1api.stg.homewifi.nokia.com', \
                   'L2Server':'https://xca-back.stg.homewifi.nokia.com', \
                   'L1Server':'https://verne-stg-mqtt-nlb.stg.homewifi.nokia.com', \
                   'KeyCloak':'https://auth.stg.homewifi.nokia.com/sso/admin/tenant3/console',\
                   'BoengServer':'https://wifi5.trial.nokia.com', \
                   'OTAServer':'https://swupd.wifi.nokia.com', \
                   'OTAPollTime':'0 2 * * *', \
				   'ServerPort':'443', \
                   'OTAActiveTime':'03:00:00', \
                   'uname':'tenant3user', \
                   'pswd':'tenant3user', \
                 'tenant_name':'tenant3'}

tenant3readonlyCred = {'uname':'hema_home_readonly_access', \
                   'pswd':'Hema_home_readonly_access@123'}

DeviceBandList = {
    "Dual Band": ["B2", "B31", "B32", "BG6", "BG62", "B11","BG31"],
    "Tri Band": ["B6"],
    "Tri Band 6G": ["B10", "B19"],
    "Quad Band": ["B24"]
}

WifiBandList = {
    "Dual Band": ["24_GHz", "5_GHz"],
    "Tri Band": ["24_GHz", "5_GHz_Low", "5_GHz_High"],
    "Tri Band 6G": ["24_GHz", "5_GHz", "6_GHz"],
    "Quad Band": ["24_GHz", "5_GHz_Low", "5_GHz_High", "6_Ghz"]
}

WifiBandList2 = {
                "Dual Band"     : ["2.4 GHz", "5 GHz"],
                "Tri Band"      : ["2.4 GHz", "5 GHz Low", "5 GHz High"],
                "Tri Band 6G"   : ["2.4 GHz", "5 GHz", "6 GHz"],
                "Quad Band"     : ["2.4 GHz", "5 GHz Low", "5 GHz High", "6 GHz"]
                }


DefaultTenant = {'URL':'https://homeconsole1.stg.homewifi.nokia.com/',
'uname':'demouserl2',
'pswd':'demouserl2'}

SpeedtestServer="13.233.92.195"

comport = '23' ;# 22 for SSH, 23 for Telnet
cliport = '23' ;
health=['Last hour','Last day','Last week']

masteruser = {'URL':'https://homeconsole1.stg.homewifi.nokia.com/', \
				'uname':'masteruser', \
				'pswd':'Masteruser@123',}	#stg or kdev1

Keycloak = {'URL':'https://auth.stg.homewifi.nokia.com/sso/admin/tenant3/console', \
				'uname':'tenant3keycloak', \
				'pswd':'tenant3keycloak',}	#stg or kdev1
API_URl='https://l1api.stg.homewifi.nokia.com'

RemoteLogin = {'URL':'https://homeconsole1.stg.homewifi.nokia.com/tenant3', \
				'uname':'tenant3remote', \
				'pswd':'Tenant3remote@1',}


headers = {
  'Content-Type': 'application/json',
  'clientid': 'nokiaMobileApp',
  'clientsecret': 'nokiaMobileAppSecret',
  'X-Service-Type': 'KC'
}

kibanadetails = {'url':'https://kibana.dev2.homewifi.nokia.com/', \
				'baseurl':'https://kibana.dev2.homewifi.nokia.com/app/discover#/', \
				'firstuser':'kibanaro', \
				'firstpassword':'4s2LfP3Ey4jg4Czv', \
                'KibannaPlatform':'stg*'}	#stg or kdev1


payload = json.dumps({
  "email": "tenant3user@nokia.com",
  "password": "tenant3user",
})

provision_api_json={
  "username": "12-31-21-21-11-11",
  "password": "1234456"
}

proxies = {"http": "http://10.158.100.6:8080",
    "https": "http://10.158.100.6:8080",
    "HTTP_PROXY":"http://10.158.100.6:8080",
    "HTTPS_PROXY":"http://10.158.100.6:8080"
}

API_CGI_URL="devicehub/devices/INDEX/router/management?persist=false"
CAP_Version = 'AIOC'


supporting_path= currentdirectoryfolder + r"\Supportingfiles"
locators_folder = os.path.join(currentdirectoryfolder, '..', 'Locators')
Selector_path = os.path.abspath(locators_folder)
topologyscpath=currentdirectoryfolder.replace('\CortecaConsole\InputFiles', '\LOGS\Screenshots')
topology_image=currentdirectoryfolder + r"\Supportingfiles\topology.png"


RemoteLogging_Cmds =['ritool dump','route','arp','ifconfig','uptime','date','lanhostd dump','ip address','ps','cfgcli dump','curl -is 127.0.0.1:18090/1/topology','netstat','cp','iptables -h','ddmcli dump mesh network topo','uci','ndk_dumpleases','free','iwlist','iwconfig','iwpriv','ls','ln','obuspa']

################### Give the model name of each device, take model name from cfgcli -g DeviceInfo. ########

RootDeviceType = {"B1"      : "Beacon 1",
                  "B3"      : "Beacon 3",
                  "B2"      : "Nokia WiFi Beacon 2",
                  "B6"      : "BEACON 6 HA-0336G-A",
                  "B31"     : "Nokia WiFi Beacon 3.1",
                  "B11"     : "Nokia WiFi Beacon 1.1",
                  "BG6"     : "Nokia WiFi Beacon G6",
                  "BG62"    : "Nokia WiFi Beacon G6.2",
                  "B32"     : "AAP321NK",
                  "B24"     : "Nokia WiFi Beacon 24",
                  "B19"     : "Nokia WiFi Beacon 19",
                  "B10"     : "Nokia WiFi Beacon 10",
                  "HA140WB" : "HA-140W-B",
                  "5G31"    : "FastMile 5G Gateway 3.1",
                  "5G32"    : "FastMile 5G Gateway 3.2",
                  "5G3"     : "FastMile 5G Gateway 3",
                  "G3"      : "Gateway 3",
                  "G140WC"  : "G-140W-C",
                  "G140WH"  : "G-140W-H",
                  "G240WG"  : "G-240W-G",
                  "G240WJ"  : "G-240W-J",
                  "G0425GA" : "G-0425G-A",
                  "G1425GA" : "G-1425G-A",
                  "G1426GA" : "G-1426G-A",
                  "G2425GA" : "G-2425G-A",
                  "G2425GB" : "G-2425G-B",
                  "G2426GA" : "G-2426G-A",
                  "G2426GB" : "G-2426G-B",
                  "XS2426GA": "XS-2426G-A"
                  }

ExtDeviceType = {"B1"   : "Beacon 1",
                 "B3"   : "Beacon 3",
                 "B2"   : "Beacon 2",
                 "B6"   : "BEACON 6 HA-0336G-A",
                 "B31"  : "Nokia WiFi Beacon 3.1",
                 "B11"  : "Nokia WiFi Beacon 1.1",
                 "B32"  : "AAP321NK",
                 "B24"  : "Nokia WiFi Beacon 24",
                 "B19"  : "Nokia WiFi Beacon 19",
                 "B10"  : "Nokia WiFi Beacon 10",
                 }




#CLI Commends
BooengDM="cfgcli -G InternetGatewayDevice.X_ALU-COM_Wifi.X_ASB_COM_BOENGAgent."
ConfigureBoeng="cfgcli -s InternetGatewayDevice.X_ALU-COM_Wifi.X_ASB_COM_BOENGAgent.Onboarding_URL https://wifi5.trial.nokia.com"
EnableBoeng="cfgcli -s InternetGatewayDevice.X_ALU-COM_Wifi.X_ASB_COM_BOENGAgent.Enable true"
EnableNTP="cfgcli -s InternetGatewayDevice.Time.Enable true"
ConfigureTZ="cfgcli -s InternetGatewayDevice.Time.X_ALU-COM_LocalTimeZone IST-5:30"
ConfigureNTPServer="cfgcli -s InternetGatewayDevice.Time.NTPServer1 135.249.193.254"
TimeDM="cfgcli -G Time."
L1Server="cfgcli -G L1Server."
L2Server="cfgcli -G L2Server."
Remoteurl="cfgcli -G InternetGatewayDevice.X_ALU-COM_NWCC.RemoteMobileAccess."
netstat_plas="netstat -anp | grep -i 'plas'"
MQTT_status="obuspa -c get Device.MQTT.Client.1.Status"
netstat_obuspa="netstat -anp | grep obuspa | grep tcp"
messages="cat /logs/messages"
messages_component="cat /logs/messages_component | grep -i boeng | grep 200"
boengprocess="ps | grep boeng"
core="ls /logs/core"
changeadminpass="cfgcli -s InternetGatewayDevice.X_Authentication.Account.Password "
curl="curl -is 127.0.0.1:18090/1/topology"
BeaconInfo= 'cfgcli -G InternetGatewayDevice.X_ALU-COM_BeaconInfo.'
Increase_Memory= "dd if=/dev/zero of=/tmp/output.dat  bs=25M count=2"
MemoryDM= "obuspa -c get Device.DeviceInfo.MemoryStatus."
MemoryCheck= "df -kh"
FreeCheck= "free"
Check_CPU="obuspa -c get Device.DeviceInfo.ProcessStatus.CPUUsage"
Increase_CPU= "yes > /dev/null &"
Kill_Increase_CPU= "killall yes"
DisableBoeng="cfgcli -s InternetGatewayDevice.X_ALU-COM_Wifi.X_ASB_COM_BOENGAgent.Enable true"
ConfigureL1Server= "cfgcli -s InternetGatewayDevice.X_ALU-COM_NWCC.L1Server.URL https://verne-stg-mqtt-nlb.stg.homewifi.nokia.com"
ConfigureL2Server= "cfgcli -s InternetGatewayDevice.X_ALU-COM_NWCC.L2Server.URL https://xca-back.stg.homewifi.nokia.com"
ConfigureRemoteurl="cfgcli -s InternetGatewayDevice.X_ALU-COM_NWCC.RemoteMobileAccess.URL https://l1api.stg.homewifi.nokia.com"


#keycloak
keycloak_tenant3="https://auth.stg.homewifi.nokia.com/sso/admin/tenant3/console"
hdm_main="https://nwcc-sp2-hdmmanaged.stg.homewifi.nokia.com/hdm"
hdm_campaign="https://nwcc-sp2-hdmmanaged.stg.homewifi.nokia.com/cm-console/login.jsp"
deviceprov="/device-provisioning/devices/INDEX?derive=false&nwcc=true&acs=false"
fmcuser="https://fmc.stg.homewifi.nokia.com/nokia-altiplano-ac/welcome.html"


installCountIncrement=1

MarketPlace={
    "url":"https://containerappdb-gw.stg.homewifi.nokia.com",
    "token":"TG1QI0lBQE5SIzQhMjg=",
    "gmailId":"atccloudmarketplace@gmail.com",
    "password":"marketPlace@123",
    'cloudUrl':'https://homeconsole1.stg.homewifi.nokia.com/tenant3',
    'uname':'tenant3user',
    'cloudPasssword':'tenant3user',
    "tenant":"tenant3"
}

MarketPlaceAndCampaignDictForTrial={
'Application':'F-Secure Sense',
'appUuid':'fb882f7e-b50b-526b-8f4a-5c0be5039ed0',
'HwModel':['BEACON 6 HA-0336G-A'],
'FirmwareVersions':['3FE49062HJLL92'],
'HwMacs':["14-55-B9-73-CD-20","14-55-B9-73-CB-40"],
'AppVersion':'4.4.2',
"workflow":"Trial",
"key":"nokiahwstg",
"scope": "view",
"max_allowed": "5"
}

MarketPlaceAndCampaignDictForOnline={
'Application':'Nokia Fingerprint',
'appUuid':'2cbf535a-7965-5260-a98a-02ce2977723c',
'HwModel':['BEACON 6 HA-0336G-A'],
'FirmwareVersions':['3FE49062HJLL92'],
'HwMacs':["14-55-B9-73-CD-20","14-55-B9-73-CB-40"],
'AppVersion':'4.0.1',
"workflow":"Online",
"key":"nokiahwstg",
"scope": "view",
"max_allowed": "-1"
}
#
# MarketPlaceAndCampaignDictForOnline={
# 'Application':'F-Secure Sense',
# 'appUuid':'fb882f7e-b50b-526b-8f4a-5c0be5039ed0',
# 'HwModel':['BEACON 6 HA-0336G-A'],
# 'FirmwareVersions':['3FE49062HJLL92'],
# 'HwMacs':["14-55-B9-73-CD-20"],
# 'AppVersion':'4.4.2',
# "workflow":"Online",
# "key":"nokiahwstg",
# "scope": "view",
# "max_allowed": "-1"
# }

# MarketPlaceAndCampaignDictForOffline={
# 'Application':'Speedtest® by Ookla',
# 'appUuid':'870ae6d3-a5b8-52c3-9a94-01923a5a7bdf',
# 'HwModel':['BEACON 6 HA-0336G-A'],
# 'FirmwareVersions':['3FE49062HJLL92'],
# 'HwMacs':["14-55-B9-73-CD-20"],
# 'AppVersion':'0.1.1',
# "workflow":"Offline",
# "key":"nokiahwstg",
# "scope": "view",
# "max_allowed": "-1"
# }

MarketPlaceAndCampaignDictForOffline={
'Application':'OpenVPN™ Client',
'appUuid':'d50ffa52-3a20-5887-ab58-8f33b6fe4d62',
'HwModel':['BEACON 6 HA-0336G-A'],
'FirmwareVersions':['3FE49062HJLL92'],
'HwMacs':["14-55-B9-73-CD-20","14-55-B9-73-CB-40"],
'AppVersion':'2.0.0',
"workflow":"Offline",
"key":"nokiahwstg",
"scope": "view",
"max_allowed": "-1"
}

MarketPlaceAndCampaignDictForRule={
        'fromFirmwareAny': True,
        'timezone': 'Asia/Kolkata',
        'enableBoot': 'True',
        'enableScheduler': 'True',
        'targetDeviceViaCsv': True,
        'hourGapDownload': '0',
        'frequency': 'Day',
        'durationTimeDownload': '2'
}
emailSubjectTrial= MarketPlaceAndCampaignDictForTrial["Application"] + " subscription completed by " + MarketPlace["tenant"]
emailSubjectOffline= MarketPlaceAndCampaignDictForOffline["Application"] + " Approval request from " + MarketPlace["tenant"]
emailSubjectOnline= MarketPlaceAndCampaignDictForOnline["Application"] + " subscription completed by " + MarketPlace["tenant"]

#uiAutomator
appiumServer="http://localhost:4723"
wifiSettingPackage="com.android.settings"
wifiSettingPackageActivity="com.android.settings.Settings"
automationName="UiAutomator2"
