#Files Contains all the variables common for set/Get operation validations or other common comparison values
# All test specific hardcoded values
import os
CurrentWorkingDirectoryFolder=os.getcwd()

sleepMin="2s"
sleepAvg="10s"
sleepMax="60s"
ssidNameChange="automaionNewSSID@"
ssidPasswordChange="automationPassoword1234@"

defaultSpeedTestMode="TR143"
defaultServer="13.233.92.195"
invalidUserName={}
RowCount="30"
RowCount="30"

defaultSpeedTestMode="TR143"
defaultServer="13.233.92.195"#for speedtest
defaultserverurl="www.yahoo.com"
ListofPingUrls=['142.250.179.225', 'www.yahoo.com']

AdvancedMetricsGraphHeader=['Downlink throughput', 'Uplink throughput', 'Channel usage', 'Device number', 'TX bitrate', 'RX bitrate', 'Signal strength', 'SNR ratio', 'Noise level', 'TX power', 'TX packet retry rate', 'TX packet error rate', 'RX packet error rate']
AdvancedMetricsGraphlocater=['DownlinkThroughput', 'UplinkThroughput', 'ChannelUsage', 'DeviceNumber', 'TxBitrate', 'RxbitRate', 'SignalStrength', 'SNRRatio', 'NoiseLevel', 'TxPower', 'TxPacketRetryRate', 'TxPacketErrorRate', 'RxPacketErrorRate']
AdvancedMetricsMeasurementYAxis=['bps', 'bps', '0', '0', 'Mbps', 'Mbps', 'dBm', 'dB', 'dBm', 'dBm', '%', '%', '%']
compareSpeedTestTable={'Date': "Today", 'Download': "\d+",'Upload': "\d+", 'Ping':"\d+",'Jitter':'\d+','Server':defaultServer,'Mode':defaultSpeedTestMode}

DataModelBrowserCheckCmd1="Device.DeviceInfo.FirmwareImage."
DataModelBrowserCheckCmd2="Device.Time."
DataModelBrowserCheckCmd3="Device.DeviceInfo."
DataModelBrowserCheckCmd4="Device.LocalAgent."
DataModelBrowserCheckCmd5="Device.IP.Interface.1.IPv4Address.1."
DataModelBrowserCheckCmd6="Device.DHCPv4.Server.Pool.1.DNSServers"

DefTimezonevalue="IST-5:30"
Timezonevaluechange="IST-3:30"
DefPortaTimezone="GMT+05:30"
DefPortalTimezonechange="GMT+03:30"
toasterLoop=3
# Campaign Firmware Rule creation Dict
'''
  campaignFirmwareRuleDict={
        'fromFirmwareAny':<True/False based on from version>,
       'ruleName':'<Rule Name>',
       'timezone ': '<Timezone>',
       'enableBoot':'<False/True>',
       'enableScheduler':'<False/True>',
       'activateSameAsDownload':'<True/False>',
       'targetDeviceViaCsv':'<True/False>',
       'hourGapDownload':'<Hour gap from current time used to set download time>',
       'durationTimeDownload':'<Download retry duration>',---->
       'hourGapActivate':'<Hour gap from current time used to set Activation time>',
       'durationTimeActivate':'<Activate retry duration>'
       }
'''
NWCCL1BEUSPFirmwarecampaign01 ={
                                        'fromFirmwareAny':True,
                                        'ruleName':'NewRule',
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot':'False',
                                        'enableScheduler':'True',
                                        'targetDeviceViaCsv':'False',
                                        'hourGapDownload':'1',
                                        'frequency':'Day',
                                        'activateSameAsDownload':True,
                                        'hourGapActivate':'2',
                                        'durationTimeDownload':'1',
                                        'durationTimeActivate':'1'
}

kibanaValidationSuccess='MAC AND "hw-rest-usp" AND OPERATION AND "operate"'

#container app
noApplicationInstalled='No applications have been downloaded yet'
installInitiated='Application installation initiated\\nThis can take up to one minute.'
installSuccessToaster='Application installed successfully'
uninstallInitiated='Application uninstallation initiated\\nThis can take up to one minute.'
uninstallSuccessToaster='Application uninstalled successfully'
containerCliName="cfgcli -g InternetGatewayDevice.SoftwareModules.ExecutionUnit.INDEX.Name"
containerCliVersion="cfgcli -g InternetGatewayDevice.SoftwareModules.DeploymentUnit.INDEX.Version"
containerCliAutostart="cfgcli -g InternetGatewayDevice.SoftwareModules.ExecutionUnit.INDEX.AutoStart"
containerCliRequestedState="cfgcli -g InternetGatewayDevice.SoftwareModules.ExecutionUnit.INDEX.RequestedState"
containerCliStatus="cfgcli -g InternetGatewayDevice.SoftwareModules.ExecutionUnit.INDEX.Status"

epocContainerMin=0
epocContainerMax=600
deviceTimezoneCli="cfgcli -g InternetGatewayDevice.Time.CurrentLocalTime"
deviceTimezoneMatch="CurrentLocalTime="
containerManifestKey="ubus -s /var/run/ubus-session/ubus.sock call usp.raw get '{\"path\":\"Device.X_ALU-COM_ContainerApps.F-Secure_Sense.RouterManifestKey\"}' | grep \"value\""
containerExecutionUnit="cfgcli -G InternetGatewayDevice.SoftwareModules.ExecutionUnit."
epochTime="epoch"
ssid_modified="Your WiFi network has been modified successfully"
ChangeDeviceTimezoneCli="cfgcli -s InternetGatewayDevice.Time.X_ALU-COM_LocalTimeZone IST-3:30"
ChangeDeviceTimezoneClidefault="cfgcli -s InternetGatewayDevice.Time.X_ALU-COM_LocalTimeZone IST-5:30"

containerFingerPrint="Nokia Fingerprint"
containerFsecure="F-Secure Sense"

containerStatusEnable="active"
containerAutostartEnable="enable"
containerStatusDisable="Idle"
containerAutostartDisable="disable"
customerInfoList=['Name','Email','Associated MAC','Timezone','Customer ID']
default_text1="Nokia"
modified_pass="Nokia@1234"

timeZone="GMT+05:30"
defaultserverurl="www.google.com"
ListofPingUrls=['www.python.org', '142.250.179.225']

defaultserverurl="www.google.com"
ListofPingUrls=['142.250.179.225', 'www.yahoo.com']

AdvancedMetricsGraphHeader=['Downlink throughput', 'Uplink throughput', 'Channel usage', 'Device number', 'TX bitrate', 'RX bitrate', 'Signal strength', 'SNR ratio', 'Noise level', 'TX power', 'TX packet retry rate', 'TX packet error rate', 'RX packet error rate']
AdvancedMetricsGraphlocater=['DownlinkThroughput', 'UplinkThroughput', 'ChannelUsage', 'DeviceNumber', 'TxBitrate', 'RxbitRate', 'SignalStrength', 'SNRRatio', 'NoiseLevel', 'TxPower', 'TxPacketRetryRate', 'TxPacketErrorRate', 'RxPacketErrorRate']
AdvancedMetricsMeasurementYAxis=['bps', 'bps', '0', '0', 'Mbps', 'Mbps', 'dBm', 'dB', 'dBm', 'dBm', '%', '%', '%']
compareSpeedTestTable={'Date': "Today", 'Download': "\d+",'Upload': "\d+", 'Ping':"\d+",'Jitter':'\d+','Server':defaultServer,'Mode':defaultSpeedTestMode}


payload_fmcadmin ={
"username":"ptfmcadmin", \
  "email": "shaonnokia40@gmail.com", \
  "password": "Pt3@fmcadmin",
}

payload_fullaccess = {
"username":"ptfullaccess", \
  "email": "shaonnokia1818@gmail.com", \
  "password": "Pt3@fullaccess",
}

payload_readonly = {
  "username":"ptadminreadonly", \
  "email": "shaonnokia1819@gmail.com", \
  "password": "Pt3@readonly",
}

payload_hdmgeneral ={
"username":"pthdmgeneral", \
  "email": "shaonnokia20@gmail.com", \
  "password": "Pt3@hdmgeneral",
}


payload_fmcuser = {
"username":"ptfmcuser", \
  "email": "shaonnokia36@gmail.com", \
  "password": "Pt3@fmcuser",
}

payload_carereadonly = {
"username":"carereadonly", \
  "email": "shaonnokia80@gmail.com", \
  "password": "Pt3@carereadonly",
}

payload_carefullaccess = {
"username":"carefullaccess", \
  "email": "shaonnokia88@gmail.com", \
  "password": "Pt3@carefullaccess",
}

payload_apisecond = {
"username":"ptapisecond", \
  "email": "shaonnokia98@gmail.com", \
  "password": "Pt3@apisecond",
}

payload_apifirst ={
"username":"ptapifirst", \
  "email": "shaonnokia71@gmail.com", \
  "password": "Pt3@apifirst"}

BBDT280324_NWCC_AIOC_USP_AdminDashboard_03={
                                        'fromFirmwareAny':True,
                                        'ruleName':'NewConfigRule',
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot':'True',
                                        'enableScheduler':'True',
                                        'targetDeviceViaCsv':True,
                                        'hourGapDownload':'0',
                                        'frequency':'Day',
                                        'durationTimeDownload':'2'
}

BBDT280327_NWCC_AIOC_USP_AdminDashboard_06={
                                        'fromFirmwareAny':True,
                                        'ruleName':'factoryResetRule',
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot':'True',
                                        'enableScheduler':'True',
                                        'targetDeviceViaCsv':True,
                                        'hourGapDownload':6,
                                        'frequency':'Day',
                                        'durationTimeDownload':'2'}

BBDT280329_NWCC_AIOC_USP_AdminDashboard_08={
                                        'fromFirmwareAny': True,
                                        'ruleName': 'factoryResetRule',
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot': 'True',
                                        'enableScheduler': 'True',
                                        'targetDeviceViaCsv': True,
                                        'hourGapDownload': 2,
                                        'frequency': 'Day',
                                        'durationTimeDownload': '2'}

BBDT280326_NWCC_AIOC_USP_AdminDashboard_05={
                                        'fromFirmwareAny': True,
                                        'ruleName': 'softwareUpgradeRule',
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot': 'True',
                                        'enableScheduler': 'True',
                                        'targetDeviceViaCsv': True,
                                        'hourGapDownload': 3,
                                        'frequency': 'Day',
                                        'durationTimeDownload': '2'}

campaignManagerConfigFileDummy={
'Name':'DummyConfigFileGroup',
'Description':'NewConfigPush_Beacon_6',
'Version':'1',
'HwModel':'BEACON 6 HA-0336G-A',
'CSVDeviceFilePath':'C:\\Users\\ladmin\\Downloads\\campaign.csv',
'Firmware':'3FE49062HJLJ53',
'WrongMac':'08-9B-B9-C6-5C-51'
}

configFileName="CFPNKBU001"
defaultConfigFileName="CFPNKBU001"
NewConfigFilePath=CurrentWorkingDirectoryFolder + '\\InputFiles\\Supportingfiles\\' + configFileName
DefaultConfigFilePath=CurrentWorkingDirectoryFolder + '\\InputFiles\\Supportingfiles\\' + defaultConfigFileName
RootConfigFileApplyStatus="COMPLETED"
ExtConfigFileApplyStatus="ERROR"

ConfigRuleEditCheckFile1=CurrentWorkingDirectoryFolder + '\\InputFiles\\Supportingfiles\\CampaignEditCheckB6File1.csv'
ConfigRuleEditCheckFile2=CurrentWorkingDirectoryFolder + '\\InputFiles\\Supportingfiles\\CampaignEditCheckB6File2.csv'

rootCount=1
WanDownSetCommand="cfgcli -s InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.Enable "
WanDownGetCommand="cfgcli -g InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.Enable "

BBDT255203_NWCC_L1_Campaign_Applications_03_Scenario1={
                                        'fromFirmwareAny': True,
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot': 'True',
                                        'enableScheduler': 'True',
                                        'targetDeviceViaCsv': True,
                                        'hourGapDownload': '0',
                                        'frequency': 'Day',
                                        'durationTimeDownload': '2'}

BBDT255203_NWCC_L1_Campaign_Applications_03_Scenario2={
                                        'fromFirmwareAny': False,
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot': 'True',
                                        'enableScheduler': 'True',
                                        'targetDeviceViaCsv': True,
                                        'hourGapDownload': '5',
                                        'frequency': 'Day',
                                        'durationTimeDownload': '2'}

BBDT255207_NWCC_L1_Campaign_Applications_07_Scenario1={
                                        'fromFirmwareAny': True,
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot': 'False',
                                        'enableScheduler': 'True',
                                        'targetDeviceViaCsv': True,
                                        'hourGapDownload': '0',
                                        'frequency': 'Day',
                                        'durationTimeDownload': '2'}

BBDT255207_NWCC_L1_Campaign_Applications_07_Scenario2={
                                        'fromFirmwareAny': True,
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot': 'True',
                                        'enableScheduler': 'False',
                                        'targetDeviceViaCsv': True,
                                        'hourGapDownload': '0',
                                        'frequency': 'Day',
                                        'durationTimeDownload': '2'}

BBDT255206_NWCC_L1_Campaign_Applications_06={
                                        'fromFirmwareAny': False,
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot': 'True',
                                        'enableScheduler': 'True',
                                        'targetDeviceViaCsv': True,
                                        'hourGapDownload': '0',
                                        'frequency': 'Day',
                                        'durationTimeDownload': '2'}

BBDT255209_NWCC_L1_Campaign_Applications_09_Scenario1={
                                        'fromFirmwareAny': True,
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot': 'True',
                                        'enableScheduler': 'True',
                                        'targetDeviceViaCsv': True,
                                        'hourGapDownload': '0',
                                        'frequency': 'Day',
                                        'durationTimeDownload': '2'}

BBDT255209_NWCC_L1_Campaign_Applications_09_Scenario2={
                                        'fromFirmwareAny': True,
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot': 'True',
                                        'enableScheduler': 'True',
                                        'targetDeviceViaCsv': True,
                                        'hourGapDownload': '5',
                                        'frequency': 'Day',
                                        'durationTimeDownload': '2'}

FingerPrintKibanaValidation='"MAC" AND "Updating usp datamodel :UspRequestBody.*objectPath=Device.X_ALU-COM_FPEngine."'

BBDT255213_NWCC_L1_Campaign_Applications_13={
                                        'fromFirmwareAny': True,
                                        'timezone': 'Asia/Kolkata',
                                        'enableBoot': 'True',
                                        'enableScheduler': 'True',
                                        'targetDeviceViaCsv': True,
                                        'hourGapDownload': '5',
                                        'frequency': 'Day',
                                        'durationTimeDownload': '2'}

BBDT255213_NWCC_L1_Campaign_Applications_13_Edit={'hourGapDownload': '0',
                                        'frequency': 'Day',
                                        'durationTimeDownload': '2'}
adminAssociation= {
   'customerid':'admincheck123',
   'tenantName':'Bobbie',
   'email':'usernamecheck@gmail.com',
   'tenantName_update':'Bobbie_Office',
   'email_update':'usernamecheck1@gmail.com',
   'tenantName_update_api':'Bobbie_House',
   'email_update_api':'usernamecheck2@gmail.com' }

ModelGroupCreate={
'ModelName':'ATCAutomationModelGroup',
'ModelProfile':'ATCAutomationModelProfile',
'ModelProfileEditName':'NewProfileForEditCheck'
}
