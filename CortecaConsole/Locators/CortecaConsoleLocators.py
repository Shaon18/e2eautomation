# Selectors should be relative path without pointing index

#LoginPage locators
txtInputUsername="css=#username"
txtInputPassword="css=#password"
btnLogin="css=#sbtbtn"

eleCustomerInfoCardExpand="css=pv-side-nav p-accordiontab a"
eleCustomerCardInfoOld="section[class='user-profile ng-star-inserted'] dd:nth-child(INDEX)"
eleCustomerCard="xpath=//li[@class='--userinfo-open-src ng-star-inserted']"
eleCustomerCardInfo="#profile-option dd:nth-child(INDEX)"

#Corteca Apps Page locators
eleNewPortal="xpath=//div[normalize-space()='Home troubleshooting']"
eleCortecaDashbordHome="xpath=//div[contains(text(),'Home troubleshooting')]"
eleCortecaDashbordTroubleshooting="xpath=//div[contains(text(),'Troubleshooting')]"
eleCortecaDashbordAdmin="xpath=//div[contains(text(),'Admin')]"
eleCortecaDashbordAnalytics="xpath=//div[contains(text(),'Analytics')]"
eleCortecaDashboardWifiOptimization="xpath=//div[contains(text(),'WiFi Optimization')]"
eleCortecaDashboardFcc="xpath=//div[contains(text(),'FCC Broadband Compliance')]"

multiDrpDwnCortecaOtherApss="css=p-multiselect[formcontrolname='selectedGroups'] div[class='p-multiselect-trigger']"

#Corteca Home Dashboard
eleHomeSearch="css=#formGroupSubscriberpop"
btnSubscriberSearch="css=app-customer-search  div > pv-button > button"
subscriberSearchResultTable="xpath=//td[normalize-space()='SUBSCRIBER']"

#Corteca Troubleshooting Dashboard
eleTroubleSearch="css=#formGroupSubscriber"
eleTroubleshootingExpand="css=app-dashborad > pv-side-nav > aside > div.pv-side-nav__collapse > pv-vector"

#Corteca RadioManagement Page
eleTroubleshootingRadioManagementTab="css=a[title='Radio management']"
eleTroubleshootingRadioManagementDeviceTab="css=li[id='collapse-radio-management'] ul a[title='INDEX']"
eleTroubleshootingRadioManagementDeviceName="css=radio-management label > b"
eleTroubleshootingRadioManagementDeviceStatus="css=radio-management  div.flex-column > span"
eleTroubleshootingRadioManagementDeviceTab="css=li[id='collapse-radio-management'] ul a[title='INDEX']"
eleTroubleshootingRadioManagementFeatureStatusCard="css=feature-status pv-card"
eleTroubleshootingRadioManagementCloudChannelManagement="css=channel-management pv-card"
eleTroubleshootingRadioManagementProhibitedChannelManagement="css=prohibited-channel-management pv-card"
eleTroubleshootingRadioManagementConnectivityConfiguration="css=pv-card[title='Connectivity configuration']"
eleTroubleshootingRadioManagementHomeagentRestart="css=pv-card[title='Home agent restart']"
eleTroubleshootingRadioManagementWiFiPointLocation="css=wifi-point-location pv-card"
eleTroubleshootingRadioManagementWireless24_GHzSettings="css=ghz-settings[ghztype='ghz24Setting']"
eleTroubleshootingRadioManagementWireless5_GHzSettings="css=ghz-settings[ghztype='ghz5Setting']"
eleTroubleshootingRadioManagementWireless5_GHz_LowSettings="css=ghz-settings[ghztype='ghz5Setting']"
eleTroubleshootingRadioManagementWireless5_GHz_HighSettings="css=ghz-settings[ghztype='ghz5hbSetting']"
eleTroubleshootingRadioManagementWireless6_GHzSettings="css=ghz-settings[ghztype=ghz5hbSetting']"

#Corteca Advanced Metrics
eleTroubleshootingAdvancedMetricsTab='css=a[title="Advanced metrics"]'
eleTroubleshootingAdvancedMetricsDeviceTab='css=div[id="collapse-adv-deb-tab"] ul a[title="INDEX"]'
eleTroubleshootingAdvancedMetricsDeviceName='css=div.inspect-tab__info-left-text > h4'
eleTroubleshootingAdvancedMetricsDeviceStatus='css=div.inspect-tab__info-left-text > span'
eleTroubleshootingAdvancedMetricsBand='css=p-tabview > div > div.p-tabview-nav-container > div > ul > li:nth-child(INDEX) > a > span'
eleTroubleshootingAdvancedMetricsLastReport='css=ul > li:nth-child(1) > small'
eleTroubleshootingAdvancedMetricsDevices='css=ul > li:nth-child(2) > small'
eleTroubleshootingAdvancedMetricsDownloadAverage='css=ul > li:nth-child(3) > small'
eleTroubleshootingAdvancedMetricsUploadAverage='css=ul > li:nth-child(4) > small'
eleTroubleshootingAdvancedMetricsDownlinkThroughput='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(1) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsUplinkThroughput='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(2) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsChannelUsage='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(3) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsDeviceNumber='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(4) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsTxBitrate='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(5) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsRxbitRate='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(6) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsSignalStrength='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(7) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsSNRRatio='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(8) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsNoiseLevel='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(9) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsTxPower='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(10) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsTxPacketRetryRate='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(11) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsTxPacketErrorRate='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(12) > div >  p-accordiontab > div > div > a.p-accordion-header-link'
eleTroubleshootingAdvancedMetricsRxPacketErrorRate='css=div.inspect-tab__charts.ng-star-inserted > p-accordion:nth-child(13) > div >  p-accordiontab > div > div > a.p-accordion-header-link'

eleAdvancedMetricsGraphHighChart="xpath=(//p-accordion[@class='p-element'])[INDEX] //*[local-name()='svg']//*[name()='g' and @class='highcharts-series-group']//*[name()='path']"
#eleAdvancedMetricsGraphTooltip="xpath=(//div[@class='highcharts-label highcharts-tooltip highcharts-color-undefined'])[INDEX]"
eleAdvancedMetricsGraphTooltip="xpath=(//div[@class='highcharts-tooltip-container'])[INDEX]"
#eleAdvancedMetricsGraphTooltip="xpath=//*[local-name()='div']//*[name()='div'][contains(@class,'highcharts-label highcharts-tooltip')]"
eleAdvancedMetricsYAxisMeasurement="xpath=(//*[name()='g'][@class='highcharts-axis-labels highcharts-yaxis-labels'])[INDEX]"
eleAdvancedMetricsDownloadCSVButton="xpath=//button[@type='button'][normalize-space()='Download .csv']"
eleAdvancedMetricsDownloadCSVpopup="xpath=(//h4[normalize-space()='Export WiFi point Summary'])[1]"
eleAdvancedMetricsDownloadCSVExport="(//button[normalize-space()='Export'])[1]"

#Corteca Ping
eleHomePingtestResult="css=ping-test div ul[class='speed-test--result']"
elePingTestCardHdr="css=ping-test > div > div.speed-test-header.last-speed-test"
eleNewPingTest='css=ping-test[class="ng-star-inserted"] button[type="submit"]'
elePingURL='(//input[@type="text"])[1]'
eleInputPingUrl='xpath= //ping-test[contains(@class,"ng-star-inserted")]//input[contains(@placeholder,"or IP address")]'
eleAveragepingval="css=ping-test > div > div.speed-test-content.ng-star-inserted > ul.speed-test--result > li > p.no-whitespace > span"
eleMinimumpingval="css=div[class='speed-test-section ng-star-inserted'] li:nth-child(1) small:nth-child(1)"
eleMaximumpingval="css=div[class='speed-test-section ng-star-inserted'] li:nth-child(2) small:nth-child(1)"
elePingCustomerPagePagination="div[class='ping-test-history'] div[class='pv-table'] span[class='p-paginator-current ng-star-inserted']"
elePingCustomerPagePaginationArrow="div[class='ping-test-history'] div[class='pv-table'] p-paginator > div > button"
elePingPagedropdown="css=div[class='ping-test-history'] div[class='pv-table'] div[role]"
elePingPagedropdown30="css=div[class='ping-test-history'] div[class='pv-table'] li[aria-label='30']"

#Toaster
elecloseToaster="css=#toast-container button span"
eleToaster="css=#toast-container"
mac_sub="xpath=(//button[@type='button'][contains(.,'MAC')])[2]"
eleclosereadonlyDia="xpath=//button[normalize-space()='Close']"

#Corteca SpeedTestCard
eleSpeedtestTrigger="css=speed-test button[type='submit']"
eleSpeedtestNoResult="css=class='no-valid-test'"
eleSpeedtestContent="xpath=//div[contains(@class,'speed-test-content')]"
eleHomeSpeedtestResult="css=speed-test div ul[class='speed-test--result']"

eleSpeedtestTab="xpath=//a[contains(@title,'Speed Test')]"

HomeInput = "xpath=//input[contains(@id,'formGroupSubscriber')]"
SearchHomeMac = "//button[@type='submit']"
MasterHomeDropdown = "//div[@aria-label='dropdown trigger']"
Home_tenant2_dropdown = '//li[@aria-label="tenant2"]'
Home_tenant3_dropdown = '//li[@aria-label="tenant3"]'
HomeMenuButton = '//button[@type="basic"]'

#Settings
eleSettingsTab="xpath=//li[normalize-space()='Settings']"
eleConfigurationTab="xpath=//li[normalize-space()='Configurations']"
eleAppliedConfigurationTable="css=app-configurations  div.applied-config  pv-data-table tbody"
eleSettingsConfigFileSelectClick="xpath=//tr[contains(.,'CONFIGFILE')]//input"
eleSettingsConfigFileApply="css=#btnapply"
eleSettingsConfigFileApplyConfirm="xpath=//button[normalize-space()='Proceed']"
timezonecheck="xpath=//dd[normalize-space()='timezone']"
#Support Actions - RadioRestart
eleSupportActions="//div[@class='pv-card__header-title pv-card__header--medium supportActionTitle']"
#eleSupportActions="pv-card[id='troubleshooting_network_coverage'] div[class='pv-card__header-title pv-card__header--medium']"
eleSupportActionNetworkDevice="//span[normalize-space()='Network device']//pv-vector[@name='chevron_down']//*[name()='svg']"
#eleSupportActionNetworkDevice="div[class='flex-column'] div:nth-child(1) span:nth-child(1) pv-vector:nth-child(1) svg"
eleSupportActionRestartRadioClick="//a[normalize-space()='Restart Radio']"
eleSupportActionRestartRadioHeader="//h2[normalize-space()='Restart Radio']"
eleSupportActionsRestartRadioSelectDevice="(//span[@class='select2-selection__placeholder'][normalize-space()='Select network device'])[3]"
eleSupportActionsRestartRadioDevice="//span[@title='INDEX']"
eleSupportActionsRestartRadios="//label[normalize-space()=INDEX]"
eleSupportActionsRestartTrigger="//button[normalize-space()='Restart Radio']"


#Container App
eleApplicationTab="css=app-dashborad ul a[title='Applications']"
eleApplicationPage="css=app-dashborad app-applications > div > div"
eleFsecureNoAppInstalled="css=pv-vector[name='app_no_installed_apps_message']"
eleFsecureNoAppInstalledText="css=div[class='no-data-msg']"
eleFsecureApplicationContainerTab="xpath=//div[contains(text(),'F-Secure Sense')]"
eleMLabApplicationContainerTab="xpath=//div[contains(text(),'M-Lab Speed Test')]"
eleFPApplicationContainerTab="xpath=//*[contains(text(),'Nokia Fingerprint')]"

#CloudRegression selectors
provision_mac_address="xpath=(//input[contains(@type,'text')])[1]"
provision_password="xpath=(//input[contains(@type,'text')])[2]"
provision_oui="xpath=(//input[contains(@type,'text')])[3]"
provision_productcode="xpath=(//input[contains(@type,'text')])[4]"
provision_serial_number="xpath=(//input[contains(@type,'text')])[5]"
eleAppCurrentSelection="css=app-applications pv-list-preview div[class='app-details-header flex-row']"
eleSelectAppVersionDropdownClick="css=app-applications p-dropdown[id='appVersions'] div"
eleSelectAppVersionDropdownSelect="xpath=//p-dropdownitem[contains(.,'VERSION')]"
eleApplicationContainerInstall="css=#btnInstall > button"
network_map="(//a[contains(.,'Network')])[1]"
status_check="//div[@class='pv-table']"

#validate
validate_macaddress="xpath=(//input[contains(@type,'text')])[6]"
validate_password="xpath=(//input[contains(@type,'text')])[7]"

eleApplicationEventTableRow1="css=pv-card[class='event-history-card'] table tbody tr:nth-child(1)"
eleApplicationEventTableRow3="css=pv-card[class='event-history-card'] table tbody tr:nth-child(3)"
eleApplicationEventTableRow2="css=pv-card[class='event-history-card'] table tbody tr:nth-child(2)"

eleNewPortal="css=app-whw-header > nav > div.logo.flex-row.flex-row__start-center > pv-vector"
eleUninstallApp=("css=div[class='installed-applications pv-yscroll-div']"" table tbody tr:nth-child(APPINDEX) td:nth-child(5) pv-button")
eleUninstallConfirm="css=app-applications > p-dialog pv-button:nth-child(2)"

delete_mac_address="xpath=(//input[contains(@type,'text')])[8]"

#bulk
upload_button="(//span[@class='p-button-label ng-star-inserted'][contains(.,'Upload')])[1]"

#masteruser
provision_mac_address_master="xpath=(//input[contains(@type,'text')])[1]"
click_tenantid="xpath=//li[@aria-label='tenant3']"
vadilate_mastermac="xpath=(//input[contains(@type,'text')])[7]"
vadilate_masterpass="xpath=(//input[contains(@type,'text')])[8]"
delete_masteruser_mac="xpath=(//input[contains(@type,'text')])[9]"
bulk_masteruser="xpath=(//input[contains(@type,'text')])[6]"
nwwc_hdm_oui="xpath=(//input[contains(@type,'text')])[2]"
nwcc_hdm_product="xpath=(//input[contains(@type,'text')])[3]"
nwcc_hdm_serial_num="xpath=(//input[contains(@type,'text')])[4]"

#_________________device_association___________________
customerid_input="xpath=(//input[contains(@type,'text')])[1]"
admin_association_select="xpath=//a[contains(@title,'CustomerID association')]"
mac_address_input_cus="xpath=(//input[contains(@type,'text')])[2]"
submit_device_single="xpath=(//button[@type='submit'][contains(.,'Submit')])[1]"
tenantName_input="xpath=(//input[contains(@type,'text')])[3]"
email_input="xpath=(//input[contains(@type,'text')])[4]"

#________________update_associtation__________
update_customer_id="xpath=(//input[contains(@type,'text')])[5]"
update_new_customer_id="xpath=(//input[contains(@type,'text')])[6]"
submit_update="xpath=(//button[@type='submit'][contains(.,'Submit')])[2]"
#___________validate_____________
validate_customer_id_alone="xpath=(//input[contains(@type,'text')])[9]"
validate_macaddress="xpath=(//input[contains(@type,'text')])[10]"
validate_customer_id="xpath=(//input[contains(@type,'text')])[11]"
validate_macaddress_both="xpath=(//input[contains(@type,'text')])[12]"

#____________Advanced deleting______________
deleting_cus_address="xpath=(//input[contains(@type,'text')])[13]"
deleting_cus_network="xpath=(//input[@type='text'])[14]"
deleting_cus_id_both="xpath=(//input[contains(@type,'text')])[15]"
deleting_cus_mac="xpath=(//input[contains(@type,'text')])[16]"
deleting_network_mac="xpath=(//input[contains(@type,'text')])[17]"
deleting_network_device="xpath=//span[contains(.,'Network devices')]"
delete_button_2="xpath=(//button[@type='submit'][contains(.,'Delete')])[2]"
delete_button_3="xpath=(//button[@type='submit'][contains(.,'Delete')])[3]"
delete_button_4="xpath=(//button[@type='submit'][contains(.,'Delete')])[4]"


##FetchLog
Troubleshooting="xpath=//strong[contains(.,'Troubleshooting dashboard')]"
FetchSystemLogs="xpath=//a[@href='#'][contains(.,'Fetch system log')]"
networkhistory="xpath=//span[normalize-space()='Event history']"
logs_continue="xpath=(//button[@type='button'][contains(.,'Continue')])[2]"
fetch_log_url_name="/activity-log/networks/subMac/logs?type=device"
fetchlogstatus_1="/activity-log/networks/"
fetchlogstatus_2="/logs/"
recommendations="xpath=//span[@aria-hidden='true'][contains(.,'×')]"
networkhistorytable="xpath=//div[@class='pv-table']"


dropdownlist=["Last 24 Hours","Last 30 days","Last 7 days"]



eleSpeedtestTab="xpath=//a[contains(@title,'Speed Test')]"
#deviceusagetest case
usageOverview="xpath=//a[@title='Usage'][contains(.,'Usage')]"
broadbandusage="xpath=//span[@role='combobox'][contains(.,'Last 24 Hours')]"
dropdowndeviceusage="xpath=//div[@class='p-element p-multiselect-label-container']"
# dropdowndeviceusage="xpath=//div[@class='p-multiselect-label']"
txVSrx="xpath=//span[@role='combobox'][contains(.,'SPEED (TX+RX)')]"
DeviceUsage="xpath=//span[@class='p-tabview-title ng-star-inserted'][contains(.,'Device')]"
repeatdiagnostic="xpath = //button[@type='submit'][contains(.,'Repeat diagnostic')]"
chartjsforusage="xpath=//canvas[contains(@class,'chartjs-render-monitor ng-star-inserted')]"

drpDown="xpath=//span[@role='combobox'][contains(.,'Last 24 Hours')]"

sevenDays="xpath=//span[@class='ng-star-inserted'][contains(.,'Last 7 days')]"

thirtyDays="xpath=//span[@class='ng-star-inserted'][contains(.,'Last 30 days')]"
adder_1 = r"/stats/networks/subMac/members_usage?from="
adder_2="T10%3A35%3A19Z&to="
adder_3="T10%3A35%3A19Z"

devicevsspeed="xpath=//a[contains(.,'Devices vs Speed')]"

nodataavailable="xpath=//div[@class='live-bar-chart-no-data ng-star-inserted'][contains(.,'No data available.')]"
selectAtleastOneDevice="xpath=//div[@class='live-chart-line-component']//div[@class='live-graph']//div[contains(.,'Please select atleast one device.')]"

vsspeedgraph="xpath=(//canvas[contains(@class,'chartjs-render-monitor')])[1]"

#xpath=//span[contains(.,'Usage')]
#Broadband Usage
brsevendays="xpath=//span[contains(.,'Last 7 days')]"
brthirtydays="xpath=//span[contains(.,'Last 30 days')]"
dropdown="xpath=(//span[@role='combobox'])[1]"
dropdowndevice="xpath=(//span[@role='combobox'])[2]"


# WIFI REBOOT

trouble="xpath=//div[@class='console-app__sub-title'][contains(.,'Troubleshoot issues in a single home network')]"
subssearch="xpath=//input[contains(@id,'formGroupSubscriber')]"
clickfirstresult="xpath=//td[contains(@class,'pv-table__td-macAddress ng-star-inserted')]"
selectnetworkdevice="xpath=(//span[@class='select2-selection__placeholder'][contains(.,'Select network device')])"
errormsg="xpath=(//div[contains(.,'× Error An unexpected error occurred, please try again.')])[3]"



#NETWORK DIAGNOSTICS

clickproblems="xpath=//span[@class='recommendation-list-icon']"



#Speedtest

downloadsymbol="xpath=//img[@src='assets/responsive/icon/download-sm.svg']"
speedtestcard="xpath=//div[contains(@class,'speed-test-content-db ng-star-inserted')]"


#Speedtest Page
downspeedleft="xpath=(//span[@class='unit download-mbps-unit'])[1]"
uploadspeedleft="xpath=(//span[contains(@class,'unit speed-upload-unit')])[1]"

downloadspeedright="xpath=//td[@class='pv-table__td-download ng-star-inserted']"
uploadspeedright="xpath=//td[@class='pv-table__td-upload ng-star-inserted']"
ping_right="xpath=//td[@class='pv-table__td-ping ng-star-inserted']"
jitter_right="xpath=//td[@class='pv-table__td-jitter ng-star-inserted']"
server_name_right="xpath=//td[@class='pv-table__td-name ng-star-inserted']"
server_mode_right="xpath=(//td[@class='pv-table__td-mode ng-star-inserted'])[1]"
Testnotruntext="//ping-test[@class='ng-star-inserted']//span[contains(text(),'Test Not Run.')]"








#Wifi point
firmware="xpath=//pv-card[contains(.,'Firmware')]"
connectivity_info="xpath=//pv-card[contains(.,'Connectivity information')]"
resources_info="xpath=//pv-card[contains(.,'WiFi point resources')]"
maint_info="xpath=//pv-card[contains(.,'Maintenance')]"
connectivity_info_ondefault_staging=connectivity_info
firmware_ext=firmware
connectivity_info_ext=connectivity_info
associated_devices= "xpath=//pv-card[contains(.,'Associated devices')]"
device_info="xpath=//pv-card[contains(.,'Device information')]"
roaming_history="xpath=//pv-card[contains(.,'Roaming history')]"
wifiscangraph="xpath=//div[contains(@class,'network-scan ng-star-inserted')]"
reload_icon="xpath=//img[contains(@alt,'spin-animation')]"
health_card="xpath=//pv-card[contains(.,'Health')]"
networkhistorychecker="xpath=//th[contains(@class,'pv-table__th-description ng-star-inserted')]"
topology_backhaul='xpath=//*[@id="mesh-tree"]/div/canvas'
overv="xpath=//span[contains(.,'Overview')]"

#slice card
eleNetworkSliceCard="xpath=//pv-card[contains(.,'Slices')]"
#Health Card


##Speed Test Overview Page

download_mbps="xpath=//span[@class='unit download-mbps-unit']"
upload_mbps="xpath=//span[@class='unit speed-upload-unit']"
ping="xpath=(//small[contains(@class,'opacity-light')])[1]"
jitter="xpath=(//small[contains(@class,'opacity-light')])[2]"



reloadicon_modify_wifi="xpath=(//button[contains(@class,'pv-button medium icon primary pv-icon-btn')])[1]"
selectwifinetwork="xpath=(//span[contains(.,'Select the WiFi Network')])"
enterwifinetwork="xpath=//input[contains(@placeholder,'Enter New WiFi network name')]"
enternetworkpassword="xpath=//input[contains(@placeholder,'Enter New Password')]"
closethecard="xpath=//button[contains(@class,'pv-button large flat default pv-icon-btn')]"



# URLS
connectedclientlist="xpath=//span[@class='ng-star-inserted'][contains(.,'INDEX')]"

sleepmin="20s"


#MemoryUsage
PersistentMemoryUsage ="xpath=//div[1]/div[1]/pv-list[1]/ul[1]/li[1]/h4[1]"
NonPersistentMemoryUsage ="xpath=//div[1]/div[1]/pv-list[1]/ul[1]/li[2]/h4[1]"

#CPUUsage
CPUUsage ="xpath=//div[1]/div[1]/pv-list[1]/ul[1]/li[3]/h4[1]"

#EventsAlarm
AlarmList= "xpath=//div[2]/div[1]/p-dropdown[1]/div[1]"
AlarmMacList = "//alarms[1]/pv-card[1]/div[1]/div[1]/h2[1]/div[2]/p-dropdown[1]/div[1]/div[1]"
AnalyticsMacField = "//pv-input[1]/div[1]/input[1]"
AlarmTypeList = "xpath=//div[2]/div[1]/p-multiselect[1]/div[1]/div[2]"
AlarmTypeList_Unselect = "xpath=(//div[@role='checkbox'])[1]"
AnalyticsMacTable = "//tbody[1]/tr[1]/td[2]"

#Fiber Health
HealthStatus = "xpath=//app-fiber-wireless-health[1]/pv-card[1]/div[1]/div[1]/p[1]/span[1]"
RxSignal = "xpath=//app-fiber-wireless-health[1]/pv-card[1]/div[1]/div[2]/div[1]/div[1]/div[1]"
TxSignal = "xpath=//app-fiber-wireless-health[1]/pv-card[1]/div[1]/div[2]/div[1]/div[3]/div[1]"
TransceiverTemp = "xpath=//app-fiber-wireless-health[1]/pv-card[1]/div[1]/div[2]/div[2]/div[1]/div[1]"

# Devices
eleHomeDashboardDeviceTab="//li[normalize-space()='Devices']"
eleDevicePageSignalStrength="//*[@id='home-devices-signal-strength']"
eleDevicePageConnectedDevicesCard="//*[@id='home-devices-connected-devices']"
eleDevicePageConnectedDevice="xpath=//span[@class='p-tabview-title ng-star-inserted'][contains(.,'Connected')]"
eleDevicePageNotConnectedDevice="xpath=//span[@class='p-tabview-title ng-star-inserted'][contains(.,'Not connected')]"
eleDevicePageConnectedDevicesTable='xpath=//*[@id="home-devices-connected-devices"]//pv-data-table'
eleDevicePageDropDown='xpath=//ul[@class="p-multiselect-items p-component ng-star-inserted"]//li'
eleDeviceDetailDevInfo="xpath=//pv-card[contains(.,'Device information')]"
eleDeviceDetailConnInfo="xpath=//pv-card[contains(.,'Connectivity information')]"
eleDeviceDetailWifiCap="xpath=//pv-card[contains(.,'WiFi capabilities')]"
eleDeviceDetailHeathInfo="xpath=//pv-card[contains(.,'Health')]"
eleDeviceDetailEventHistory="xpath=//div[contains(@class,'card-loader alt ng-star-inserted')]"
eleDeviceDetailDeviceCard="xpath=//*[@id='home-devices-device-card']"
eleDeviceDetailRoamingInfo="xpath=//div[@class='pv-card']//div[@class='component-loader']"

#DataModelBrowser
eleAdvancedSettingsTAB = 'css=pv-vector[name="menu_settings"]'
eleDataModelBrowserPage = "xpath=//span[normalize-space()='Data Model Browser']"
eleBrowserHdr = "xpath=//div[@class='p-element pv-card__header-title pv-card__header--medium'][normalize-space()='Browser']"
eleNetworkDevice = "xpath=//div[normalize-space()='Network device']"
eleDataModelBrowser = "xpath=//div[normalize-space()='Data Model Browser']"
elehelptxtinbox = "xpath=//input[@placeholder='Please enter data model browser']"
elehelptxt = "xpath=//div[@class='help-text']"
eleApplybtninDMbrowser = "xpath=//button[normalize-space()='Apply']"
eleInputDMcommand = "xpath=//input[@placeholder='Please enter data model browser']"
eleAutocompletehelper = "xpath=//li[@role='option']"
ApplybtninDMbrowser = "xpath=//button[normalize-space()='Apply']"
eleEditbutton = "xpath=//button[normalize-space()='Edit']"
eleSetbutton= "xpath=//button[normalize-space()='Set']"
eleDMvalidationVersion = "xpath=//span[normalize-space()='Version:']"
eleDMvalidationStatus = "xpath=//span[normalize-space()='Status:']"
eleWiFiPointDropdown = "css=#selectWifipoint > div"
eleWiFiPointDropdownList = "css=#selectWifipoint_list"
eleDMvalidationLocalTimezone = "xpath=//span[normalize-space()='LocalTimeZone:']"
eleDMvalidationNTPStatus = "xpath=//span[normalize-space()='Status:']"
eleDMvalidationNTPEnable = "xpath=//span[normalize-space()='Enable:']"
eleDMinputLocalTimezone = "xpath=//div[@class='data-model-list pv-yscroll-div']//div[4]//pv-input[1]//div[1]//input[1]"
eleDMinputNTPEnable = "xpath=//div[@class='list-item-info flex ng-star-inserted']//div[3]//pv-input[1]//div[1]//input[1]"
eleDMvalidationfirmware1 = "xpath=//label[normalize-space()='Device.DeviceInfo.FirmwareImage.1.']"
eleDMvalidatiomfirmware2 = "xpath=//label[normalize-space()='Device.DeviceInfo.FirmwareImage.2.']"
eleDMvalidatiomfirmware1radiobtn = "xpath=//div[@class='data-model-list pv-yscroll-div']//div[1]//div[1]//p-radiobutton[1]"
eleDMvalidatiomfirmware2radiobtn = "xpath=//div[@class='data-model-list pv-yscroll-div']//div[2]//div[1]//p-radiobutton[1]"
elewifipointname = "xpath=//span[@class='ng-star-inserted'][normalize-space()='INDEX']"


#Network History
eleHistoryhdr="xpath=//section[@class='history-view ng-star-inserted']//h1[@class='pv-page-header']"
eleHistoryPageTab1="xpath=//span[normalize-space()='L1 Events']"
eleHistoryPageTab2="xpath=//span[normalize-space()='L2 Events']"
eleHistoryPageTab3="xpath=//span[normalize-space()='Alarms']"
eleHistoryPageTab4="xpath=//span[normalize-space()='DFS Statistics']"
eleHistoryeventdrpdown="xpath=//div[contains(text(),'All Events')]"
eleHistoryeventSelectall="xpath=//div[@role='checkbox']"
eleHistoryeventAgent="xpath=//span[normalize-space()='Agent']"
eleHistoryeventDevice="xpath=//span[normalize-space()='Device']"
eleHistoryeventInterference="xpath=//span[normalize-space()='Interference']"
eleHistoryeventUser="xpath=//span[normalize-space()='User']"
eleHistoryeventMeshNetwork="xpath=//span[normalize-space()='Mesh Network']"
eleHistorydevicesdrpdown="xpath=//div[contains(text(),'All Devices')]"
eleHistoryTableTime="xpath=//th[@class='pv-table__th-starttime ng-star-inserted']"
eleHistoryTableEvent="xpath=//th[@class='pv-table__th-originType ng-star-inserted']"
eleHistoryTableDescription="xpath=//th[@class='pv-table__th-description ng-star-inserted']"
eleEventHistoryPagePagination="p-paginator > div > span.p-paginator-current.ng-star-inserted"
eleEventHistoryPagePaginationArrow="p-paginator > div > button"
eleEventHistoryCalendar="css=app-network-history > div.search-container > div > input[type=text]"
eleHistorycurrentDate="css=div.drp-buttons > span"
eleHistorycalendarCancel="xpath=//body/div[3]/div[4]/button[1]"
elePaginationNextArrow="css=p-paginator > div > button.p-ripple.p-element.p-paginator-next.p-paginator-element.p-link"
elePaginationLastArrow="css=p-paginator > div > button.p-ripple.p-element.p-paginator-last.p-paginator-element.p-link.ng-star-inserted"
