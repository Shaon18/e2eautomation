# Selectors should be relative path without pointing index
# Selectors of Admin Page

#Corteca Apps Page locators
eleCortecaDashbordAdmin="xpath=//div[contains(text(),'Admin')]"
eleCortecaAdminProvisioning="css=a[name='Provisioning']"
eleCortecaAdminAssociation="css=a[name='CustomerID association']"
eleCortecaAdminDeploymentReport="css=a[name='Deployment reports']"
# eleCortecaAdminCampaign="css=a[name='Campaigns']"
eleCortecaAdminCampaign="xpath=//a[normalize-space()='Campaigns']"


#Campaign Firmware
eleCortecaAdminCampaignFirmware="css=a[name='Firmware versions']"
eleCortecaAdminCampaignFirmwarePage="css=app-firmware-versions pv-card app-list"

eleCortecaAdminCampaignFirmwareList="xpath=//app-firmware-versions/div//h4[contains(.,'FIRMWARE')]"

btnCampaignManagerAddNewFirmware="css=app-campaigns > app-firmware-versions > div > div > pv-button > button"
eleCampaignManagerNewFirmwareName="css=add-new-firmware > div  div:nth-child(1) > pv-form-control:nth-child(1) > div > pv-input > div > input"
eleCampaignManagerNewFirmwareDescription="css=add-new-firmware > div  div:nth-child(1) > pv-form-control:nth-child(2) > div > pv-input > div > input"
dropDownItemCampaignFirmwareClick="xpath=//add-new-firmware//div[3]/div[INDEX]//p-dropdown//span"
dropDownItemSelectCampaignFirmware="xpath=//add-new-firmware//div[3]/div[INDEX]//p-dropdownitem[contains(.,'MODEL')]"
eleCampaignManagerNewFirmwareVersion="xpath=//div[3]/div[INDEX]//pv-form-control[2]//input"
eleCampaignManagerNewFirmwareSelectFile="xpath=//add-new-firmware/div/div[1]/div[3]/div[INDEX]/div[2]//p-fileupload/div/div[1]//span/input"
eleCampaignManagerNewFirmwareAddModel="xpath=//pv-button[contains(.,'Add new hardware model')]//button"
btnCampaignManagerNewFirmwareSave="xpath=//pv-button[contains(.,'SAVE')]//button"

eleCampaignManagerNewFirmwareAddRuleName="xpath=//pv-input[@formcontrolname='name']//input"
drpDwnMultiCampaignFirmwareNewRuleTargetFirmwareClick="xpath=//p-multiselect[@formcontrolname='selectedFirmwares']/div"
drpDwnMultiCampaignFirmwareNewRuleTargetFirmware="xpath=//p-multiselectitem/li[contains(.,'FIRMWARE')]"
toggleCampaignManagerNewRuleEnableBoot="css=div.cron-scheduler > div > pv-toggle[formcontrolname='apply_on_boot'] input"
toggleCampaignManagerNewRuleEnableBootClick="css=div.cron-scheduler > div > pv-toggle[formcontrolname='apply_on_boot'] > label"
toggleCampaignManagerNewRuleEnableScheduler="css=div.cron-scheduler > div > pv-toggle[formcontrolname='scheduleEvent'] input"
toggleCampaignManagerNewRuleEnableSchedulerClick="css=div.cron-scheduler > div > pv-toggle[formcontrolname='scheduleEvent'] > label"

# eleCampaignManagerScheduleDurationClick="xpath=//p-dropdown[@formcontrolname='duration_in_hours']//span"
# eleCampaignManagerScheduleDuration="xpath=//p-dropdown[@formcontrolname='duration_in_hours']//p-dropdownitem/li[contains(.,'TIME h')]"
#
# eleCampaignManagerScheduleFrequencyClick="xpath=//campaign-cron[@formcontrolname='cron']//p-dropdown[@formcontrolname='baseFrequency']"
# eleCampaignManagerScheduleFrequency="xpath=//campaign-cron[@formcontrolname='cron']//p-dropdownitem/li[contains(.,'FREQUENCY')]"
#
# eleCampaignManagerScheduleTimeClick="xpath=//campaign-cron[@formcontrolname='cron']//p-dropdown[@formcontrolname='hours']"
# eleCampaignManagerScheduleTime="xpath=//campaign-cron[@formcontrolname='cron']//p-dropdownitem/li[contains(.,'TIME h')]"

eleCampaignManagerScheduleDurationClick="xpath=//p-dropdown[@formcontrolname='duration_in_hours']//span"
eleCampaignManagerScheduleDuration="xpath=//p-dropdown[@formcontrolname='duration_in_hours']//p-dropdownitem/li[contains(.,'TIME h')]"

eleCampaignManagerScheduleFrequencyClick="xpath=//p-dropdown[@formcontrolname='baseFrequency']"
eleCampaignManagerScheduleFrequency="xpath=//p-dropdown[@formcontrolname='baseFrequency']//p-dropdownitem/li[contains(.,'FREQUENCY')]"

eleCampaignManagerScheduleTimeClick="xpath=//p-dropdown[@formcontrolname='hours']"
eleCampaignManagerScheduleTime="xpath=//p-dropdown[@formcontrolname='hours']//p-dropdownitem/li[contains(.,'TIME h')]"


#Activate
eleCampaignManagerActivateSameAsDownlod="xpath=//pv-toggle[@formcontrolname='same_as_download']/label"
eleCampaignManagerRuleSave="xpath=//pv-button[@type='submit']"

eleCampaignManagerScheduleActivateDurationClick="xpath=//p-dropdown[@formcontrolname='duration_activate_in_hours']//span"
eleCampaignManagerScheduleActivateDuration="xpath=//p-dropdown[@formcontrolname='duration_activate_in_hours']//p-dropdownitem/li[contains(.,'${time} h')]"

eleCampaignManagerScheduleActivateFrequencyClick="xpath=//campaign-cron[@formcontrolname='cronActivate']//p-dropdown[@formcontrolname='baseFrequency']"
eleCampaignManagerScheduleActivateFrequency="xpath=//campaign-cron[@formcontrolname='cronActivate']//p-dropdownitem/li[contains(.,'FREQUENCY')]"

eleCampaignManagerScheduleActivateTimeClick="xpath=//campaign-cron[@formcontrolname='cronActivate']//p-dropdown[@formcontrolname='hours']"
eleCampaignManagerScheduleActivateTime="xpath=//campaign-cron[@formcontrolname='cronActivate']//p-dropdownitem/li[contains(.,'TIME h')]"

drpDwnMultiCampaignFirmwareNewRuleTimezoneClick="xpath=//p-dropdown[@formcontrolname='timezone']"
drpDwnMultiCampaignFirmwareNewRuleTimezone="xpath=//p-dropdownitem/li[contains(.,'TIMEZONE')]"

eleCampaignFirmwareNewRuleTrendSelectClick="xpath=//app-firmware-versions//tr[contains(.,'RULE')]//button"
# Rule Trend
btnCampaignManagerRuleTrend="xpath=//pv-button[@title='Rule trends']"
btncampaignManagerReportDownload="xpath=//pv-button[@title='Download rule report']"
btncampaignManagerEdit="xpath=//pv-button[@title='Edit rule']"

eleCampaignGraphHighChart="xpath=//*[local-name()='svg']//*[name()='g' and @class='highcharts-series-group']//*[name()='rect']"
eleCampaignGraphTooltip="xpath=//*[local-name()='div']//*[name()='div'][contains(@class,'highcharts-label highcharts-tooltip')]"

toggleCampaignManagerNewFirmwareRuleEnableDisable="css=app-firmware-versions tbody > tr label > input"
toggleCampaignManagerNewFirmwareRuleEnableDisableClick="css=app-firmware-versions tbody > tr  pv-toggle > label"

#Campaign Application
eleCortecaAdminCampaignApplication="css=a[name='Applications']"
eleCortecaAdminCampaignApplicationPage="css=app-applications pv-card app-list"
applistIndex="css=app-list > pv-list li:nth-child(INDEX) h4 div"
eleCortecaAdminCampaignApplicationSelect=xpath="//app-list//span[normalize-space()='APPLICATION']"
eleCortecaAdminCampaignApplicationAddNewRule="xpath=//button[normalize-space()='Add new rules']"
eleCortecaAdminCampaignApplicationAddNewRuleActionClick="xpath=//add-new-rules//p-dropdown[@formcontrolname='action']//span"
eleCortecaAdminCampaignApplicationAddNewRuleAction="xpath=//add-new-rules//p-dropdown[@formcontrolname='action']//p-dropdownitem[contains(.,'ACTION')]"
# eleCortecaAdminCampaignApplicationAddNewRuleAction="xpath=//add-new-rules//p-dropdown[@formcontrolname='action']//p-dropdownitem"

radioBtnHardwareModel="css=#hardwareModel"
dropDownItemCampaignApplicationModelClick="xpath=//add-new-rules//p-multiselect[@formcontrolname='selectedModels']"
dropDownItemSelectCampaignApplicationModel="xpath=//add-new-rules//p-multiselect[@formcontrolname='selectedModels']//p-multiselectitem[contains(.,'MODEL')]"

dropDownItemCampaignApplicationFirmwareClick="xpath=//add-new-rules//p-multiselect[@formcontrolname='selectedFirmwares']"
dropDownItemSelectCampaignApplicationFirmware="xpath=//add-new-rules//p-multiselect[@formcontrolname='selectedFirmwares']//p-multiselectitem[contains(.,'FIRMWARE')]"

dropDownItemCampaignApplicationAppVersionClick="xpath=//add-new-rules//p-dropdown[@formcontrolname='selectedVersions']//span"
dropDownItemSelectCampaignApplicationAppVersion="xpath=//add-new-rules//p-dropdown[@formcontrolname='selectedVersions']//p-dropdownitem[contains(.,'VERSION')]"

eleCampaignApplicationRuleTrendSelectClick="xpath=//app-list//li[contains(.,'RULE')]//button"

eleCampaignAppInstallCount="css=app-applications div.flex-row.admin-camp-app-details__install-app-card > pv-card:nth-child(1) > div > div.pv-card__body > span"
eleCampaignAppLicenseCount="css=app-applications > div div.admin-camp-app-details__license"
eleCampaignAppUninstallCount="css=app-applications div.flex-row.admin-camp-app-details__install-app-card > pv-card:nth-child(2) > div > div.pv-card__body > span"

#
# eleCampaignManagerAppScheduleDurationClick="xpath=//add-new-rules//p-dropdown[@formcontrolname='duration_in_hours']//span"
# eleCampaignManagerAppScheduleDuration="xpath=//add-new-rules//p-dropdown[@formcontrolname='duration_in_hours']//p-dropdownitem/li[contains(.,'TIME h')]"
#
# eleCampaignManagerAppScheduleFrequencyClick="xpath=//add-new-rules//campaign-cron[@formcontrolname='cron']//p-dropdown[@formcontrolname='baseFrequency']"
# eleCampaignManagerAppScheduleFrequency="xpath=//add-new-rules//campaign-cron[@formcontrolname='cron']//p-dropdownitem/li[contains(.,'FREQUENCY')]"
#
# eleCampaignManagerAppScheduleTimeClick="xpath=//add-new-rules//campaign-cron[@formcontrolname='cron']//p-dropdown[@formcontrolname='hours']"
# eleCampaignManagerAppScheduleTime="xpath=//add-new-rules//campaign-cron[@formcontrolname='cron']//p-dropdownitem/li[contains(.,'TIME h')]"

toggleCampaignManagerAppRuleEnableDisable="css=app-list > pv-list li:nth-child(INDEX) pv-toggle[title='Enable/Disable rule'] input"
toggleCampaignManagerAppRuleEnableDisableClick="css=app-list > pv-list li:nth-child(INDEX) pv-toggle[title='Enable/Disable rule'] label"

#CampaignConfiguration files
eleCortecaAdminCampaignConfigFile="css=a[name='Configuration files']"
eleCortecaAdminCampaignConfigFilePage="css=app-config-files pv-card app-list"
btnCampaignManagerAddNewConfigFile="css=app-campaigns > app-config-files > div > div > pv-button > button"
eleCampaignManagerNewConfigFileName="css=add-new-config > div  div:nth-child(1) > pv-form-control:nth-child(1) > div > pv-input > div > input"
eleCampaignManagerNewConfigFileVersion="css=add-new-config > div  div:nth-child(1) > pv-form-control:nth-child(2) > div > pv-input > div > input"
eleCampaignManagerNewConfigFileDescription="css=add-new-config > div  div:nth-child(1) > pv-form-control:nth-child(3) > div > pv-input > div > input"
dropDownItemCampaignConfigFileClick="xpath=//add-new-config//p-dropdown//span"
dropDownItemSelectCampaignConfigFileModel="xpath=//add-new-config//p-dropdownitem[contains(.,'MODEL')]"
eleCampaignManagerNewConfigFileSelectFile="xpath=//add-new-config//div[INDEX]//p-fileupload/div/div[1]//span/input"
btnCampaignManagerNewConfigFileSave="xpath=//pv-button[contains(.,'SAVE')]//button"
btnCampaignManagerNewConfigFileList="xpath=//app-config-files//li[contains(.,'CONFIGFILE')]//button"
btnCampaignManagerNewConfigFileDelete="xpath=//button[contains(.,'Delete configuration')]"
btnCampaignManagerNewConfigFileDeleteConfirm="xpath=//p-dialog//button[contains(.,'Delete')]"

eleCortecaAdminCampaignConfigFileList="xpath=//app-config-files/div//h4[contains(.,'CONFIGFILE')]"

eleCSVFileSelect="css=input[value='CSV']"
eleCampaignManagerCSVUpload="//div[INDEX]//p-fileupload/div/div[1]//span/input"

toggleCampaignManagerNewAppRuleEnableDisable="css=add-new-rules pv-toggle[formcontrolname='enabled'] input"
toggleCampaignManagerNewAppRuleEnableDisableClick="css=add-new-rules pv-toggle[formcontrolname='enabled'] label"

#config file rule creation
eleCampaignManagerNewConfigFileAddRuleName="xpath=//pv-input[@formcontrolname='name']//input"
drpDwnMultiCampaignFirmwareNewRuleTargetFirmwareClick="xpath=//p-multiselect[@formcontrolname='selectedFirmwares']/div"
drpDwnMultiCampaignFirmwareNewRuleTargetFirmware="xpath=//p-multiselectitem/li[contains(.,'FIRMWARE')]"
toggleCampaignManagerNewConfigFileEnableBoot="css=add-new-config-rules  div.cron-scheduler > div > pv-toggle[formcontrolname='apply_on_boot'] > label > input"
toggleCampaignManagerNewConfigFileEnableBootClick="css=add-new-config-rules  div.cron-scheduler > div > pv-toggle[formcontrolname='apply_on_boot'] > label"
toggleCampaignManagerNewConfigFileEnableScheduler="css=add-new-config-rules  div.cron-scheduler > div > pv-toggle[formcontrolname='scheduleEvent'] > label > input"
toggleCampaignManagerNewConfigFileEnableSchedulerClick="css=add-new-config-rules  div.cron-scheduler > div > pv-toggle[formcontrolname='scheduleEvent'] > label"

eleCampaignConfigFileNewRuleTrendSelectClick="xpath=//app-config-files//tr[contains(.,'RULE')]//button"

toggleCampaignManagerNewFirmwareRuleEnableDisable="css=app-config-files tbody > tr label > input"
toggleCampaignManagerNewFirmwareRuleEnableDisableClick="css=app-config-files tbody > tr  pv-toggle > label"

btnCampaignManagerNewConfigFileRuleDelete="xpath=//button[contains(.,'Delete rule')]"
btnCampaignManagerNewConfigFileRuleConfirm="xpath=//p-dialog//button[contains(.,'Delete')]"

btnCampaignManagerConfigFileRuleEdit="xpath=//button[contains(.,'Edit rule ')]"

btnEditTabClose="css=div > button"

#Campaign Reboot
eleCortecaAdminCampaignReboot="css=a[name='Reboots']"

#App Deployment report
eleAppDeploymentReportDownloadClick="xpath=//p-dropdown[@formcontrolname='app_uuid']//span"
eleAppDeploymentReportDownload="xpath=//p-dropdownitem/li[contains(.,'APPS')]"
eleAppDeploymentReportDownloadFile="xpath=//div[2]//div[2]//button[@type='submit'][contains(.,'Download')]"
