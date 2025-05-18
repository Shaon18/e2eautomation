#LoginPage locators
InputUsername = "xpath=//pv-form-field[1]/div/pv-inputbox/div/div/input"
InputPassword = "xpath=//pv-form-field[2]/div/pv-inputbox/div/div/input"
LoginBtn = "xpath=//pv-button/button"

httpsAdvanced = "css=#details-button"
httpsProceed = "css=#proceed-link"

SecurityTab = "xpath=//li[6]/div"
AccessControl = "xpath=//li[6]/ul/li[6]"
LANTab = "//pv-tabs-panel/ul/li[2]"
Telnet = "xpath=//pv-select[@formcontrolname='telnetLan']//input[@placeholder='Select option']"
SSH = "xpath=//pv-select[@formcontrolname='sshLan']//input[@placeholder='Select option']"
HTTP = "xpath=//pv-select[@formcontrolname='httpLan']//input[@placeholder='Select option']"

AllowTelnet = "xpath=//div[@class='pv-select-options-list bottom medium show']//li[normalize-space()='Allow']"
AllowSSH = "xpath=//div[@class='pv-select-options-list bottom medium show']//li[normalize-space()='Allow']"
AllowHTTP = "xpath=//div[@class='pv-select-options-list bottom medium show']//li[normalize-space()='Allow']"
Savebtn = "xpath=//pv-card[2]/div[2]/pv-button/button"
Confirmbtn = "xpath=//pv-card/div[2]/div/pv-button[2]/button"


WanTab = "xpath=//div[normalize-space()='WAN']"
AdvanceSettingTab = "xpath=//div[normalize-space()='Advanced settings']"
StaticRoutingTab = "xpath=//li[normalize-space()='Static routing']"
DDNSTab = "xpath=//li[normalize-space()='DDNS']"
LanTab = "xpath=//div[normalize-space()='LAN']"

MaintenanceTab="xpath=//div[normalize-space()='Maintenance']"
UpgradeTab="xpath=//span[normalize-space()='Firmware upgrade']"
UploadeChooseTab="css=.pv-upload__input-file"
WebguiSoftwareUploadButton="css=app-firmware-upgrade > div > pv-card:nth-child(1) > div > pv-button > button"

TroubleshootingTab="xpath=//div[normalize-space()='Troubleshooting']"
ssidpass="xpath=//input[@class='input-box large show-password ng-untouched ng-pristine ng-valid']"
