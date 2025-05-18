*** Settings ***
Library    String
Library    OperatingSystem
Resource     ../../KeywordDefinition/CommonKeywords.robot
Resource    CampaignManagerCommonKeywords.robot
Resource    ../KibanaKeywords.resource
Variables    ../../JavaScriptCodes/executeJavaScriptCodeCorteca.py
Variables    ../../../InputFiles/EnvironmentInput.py
Variables    ../../../Locators/CortecaConsoleAdminLocators.py

*** Keywords ***
Login and Open Campaign Firmware Page
    [Documentation]    This function will perform the following:
    ...                 1: Open admin page and move to firmware campaign
    Login To CampaignManager
    Open which Campaign  Firmware
    Wait Until Page Contains Element    ${btnCampaignManagerAddNewFirmware}
    Capture Page Screenshot

Add A New Firmware Version
    [Documentation]    This function will perform the following:
    ...                1: Create the firmware rule \n
    ...                 Argument:  campaignManagerFirmware -> A dictionary argument in which all variables needed for rule creation
    ...                    {
    ...                    'Name':'<Name for the rule>',
    ...                    'Description':'Description for the rule', # 
    ...                    'GroupOfModel':[{'HwModel':'<HW model>',
    ...                    'Version':'<Version>',
    ...                    'Firmware':'<Firmware to version>',
    ...                    'FirmwarePath':'<Firmware file path>',
    ...                    'CurrentFirmware':'<Firmware current version>',
    ...                    }]}
    ...                 eg: campaignManagerFirmware={'Name':'3FE49062HJLJ53_Beacon_6','Description':'3FE49062HJLJ53_Beacon_6',
    ...                'GroupOfModel':[{'HwModel':'BEACON 6 HA-0336G-A','Version':'3FE49062HJLJ53',
    ...                'Firmware':'3FE49062HJLJ53','FirmwarePath':'C:\\NewAutomation\\e2eautomation\\CortecaConsole\\Build\\3FE49062HJLK96','CurrentFirmware':'3FE49062HJLJ51'}]}
    [Arguments]    ${campaignManagerFirmware}
    Check Element    ${btnCampaignManagerAddNewFirmware}
    Press Click Button    ${btnCampaignManagerAddNewFirmware}
    Enter Value    ${eleCampaignManagerNewFirmwareName}    ${campaignManagerFirmware}[Name]    timeout=60s
    Enter Value    ${eleCampaignManagerNewFirmwareDescription}    ${campaignManagerFirmware}[Description]
    Log    **** Adding Harware Models to ${campaignManagerFirmware}[Name] *****
    Add Hardware Models To New Firmware Group    ${campaignManagerFirmware}[GroupOfModel]
    Press Click Button    ${btnCampaignManagerNewFirmwareSave}
    Run Keyword And Continue On Failure    Campaign Toaster Validation    .*Firmware image upload for ${campaignManagerFirmware}[Name] is in progress.*
    Run Keyword And Continue On Failure    Campaign Toaster Validation    .*Success.*    timeout=300
    Page Should Contain    ${campaignManagerFirmware}[Name]

Add Hardware Models To New Firmware Group
    [Documentation]    This function is to select the hardware model list for firmware group creation and upload the firmwares
    ...                 Argument:  campaignManagerFirmware -> A list of dictionary argument in which all variables needed for firmware group creation
    ...                    'GroupOfModel':[{'HwModel':'<HW model>',
    ...                    'Version':'<Version>',
    ...                    'Firmware':'<Firmware to version>',
    ...                    'FirmwarePath':'<Firmware file path>',
    ...                    'CurrentFirmware':'<Firmware current version>',
    ...                    }]
    [Arguments]    ${GroupOfModel}
    ${lenDict}    Get Length    ${GroupOfModel}
    ${child}    Set Variable    1
    FOR    ${group}    IN    @{GroupOfModel}
        Log    **** Adding data for ${group} ****
        Add A Hardware Model    ${group}[HwModel]    ${group}[Version]    ${group}[FirmwarePath]    ${child}   
        Exit For Loop If	'${lenDict}'=='1'
        Press Click Button    ${eleCampaignManagerNewFirmwareAddModel}
        ${child}    Evaluate    ${child}+1
        ${lenDict}    Evaluate    ${lenDict}-1
        Check Element    ${btnCampaignManagerNewFirmwareSave}
    END

Add A Hardware Model
    [Documentation]    Keyword to add new firmware
    ...                 Argument:
    ...                    model -> Model Name to select for firmware create
    ...                    version -> version expected after upgrade
    ...                    firmwarePath -> Image upload file path
    ...                    childIndex -> optional default 1
    [Arguments]    ${model}    ${version}    ${firmwarePath}    ${childIndex}=1
    Log    **** Adding ${model} And ${version} ****
    ${childIndex}    Convert To String    ${childIndex}
    Select Model For Firmware    ${model}    ${childIndex}
    ${firmwareVersion}    Replace String    ${eleCampaignManagerNewFirmwareVersion}    INDEX    ${childIndex}
    Enter Value    ${firmwareVersion}    ${version}
    Upload A File    ${eleCampaignManagerNewFirmwareSelectFile}    ${firmwarePath}    ${childIndex}

Select Model For Firmware
    [Documentation]    Keyword to add hardware model for firmware creation
    ...                 Argument:
    ...                    hwModel -> Model Name to select for firmware create
    ...                    childIndex -> optional default 1
    [Arguments]    ${hwModel}    ${childIndex}=1
    ${childIndex}    Convert To String    ${childIndex}
    ${dropDownFirmwareClick}    Replace String    ${dropDownItemCampaignFirmwareClick}    INDEX    ${childIndex}
    ${dropDownItemSelector}    Replace String    ${dropDownItemSelectCampaignFirmware}    INDEX    ${childIndex}
    ${dropDownItemSelector}    Replace String    ${dropDownItemSelector}    MODEL    ${hwModel}
    Select From Dropdown Item    ${dropDownFirmwareClick}    ${dropDownItemSelector}
    Sleep    2s

Create A New Rule For Campaign Firmware
    [Documentation]    Create a Rule for the given firmware group
    ...                 Argument:  
    ...                    campaignManagerFirmwareName -> Name of the firmware group
    ...                    fromfirmwareList -> from which firmware
    ...                    campaignFirmwareRuleDict -> Dictionary of variables needed for rule creation
    ...                            campaignFirmwareRuleDict={
    ...                                 'ruleName':'<Rule Name>',
    ...                                 'timezone ': '<Timezone>',
    ...                                 'enableBoot':'<False/True>',
    ...                                 'enableScheduler':'<False/True>',
    ...                                 'activateSameAsDownload':'<True/False>',
    ...                                 'targetDeviceViaCsv':'<True/False>',
    ...                                 'hourGapDownload':'<Hour gap from current time used to set download time>',
    ...                                 'durationTimeDownload':'<Download retry duration>',---->
    ...                                 'hourGapActivate':'<Hour gap from current time used to set Activation time>',
    ...                                 'durationTimeActivate':'<Activate retry duration>'
    ...                                 }
    ...                    Eg: {
    ...                                 'fromFirmwareAny':False,
    ...                                 'timezone ': 'Asia/Kolkata',
    ...                                 'enableBoot':'False',
    ...                                 'enableScheduler':'False',
    ...                                 'activateSameAsDownload':'True',
    ...                                 'hourGapDownload':'1 hour',
    ...                                 'durationTimeDownload':'1',
    ...                                 'hourGapActivate':'2 hour',
    ...                                 'durationTimeActivate':'1'
    ...                                 }
    [Arguments]    ${campaignManagerFirmwareName}    ${campaignFirmwareRuleDict}    ${fromfirmwareList}=[]
    Login And Open Campaign Firmware Page
    Open The Given Firmware    ${campaignManagerFirmwareName}
    Log    **** Add New Rule ****
    ${ruleNewName}    Create A New Rule    ${campaignFirmwareRuleDict}    ${fromfirmwareList}
    Return From Keyword    ${ruleNewName}

Open The Given Firmware
    [Documentation]    Open the given firmware from Available firmware versions
    ...                 Argument:
    ...                    firmwareGroupName -> Name of the firmware group
    [Arguments]    ${firmwareGroupName}
    ${firmwareSelector}    Replace String    ${eleCortecaAdminCampaignFirmwareList}    FIRMWARE    ${firmwareGroupName}
    Check Element    ${firmwareSelector}
    Mouse Down    ${firmwareSelector}
    Press Click Element    ${firmwareSelector}

Create A New Rule
    [Documentation]    keyword to create schedule rule for given firmware group
    ...                 Argument:
    ...                    campaignFirmwareRuleDict -> Dictionary of parameters needed for rule creation
    ...                    fromfirmwareList -> list of from firmware versions to set
    [Arguments]    ${campaignFirmwareRuleDict}    ${fromfirmwareList}=[]
    Press Click Element    ${btnCampaignManagerAddNewFirmware}
    ${ruleNewName}    Generate Random String    1    [NUMBERS]
    ${ruleNewName}    Set Variable    ${ruleNewName}_${campaignFirmwareRuleDict}[ruleName]
    Enter Value    ${eleCampaignManagerNewFirmwareAddRuleName}    ${ruleNewName}
    Set Test Variable    ${ruleNewName}
    Log    **** From firmware selections and Target devices ****
    Target Device And Firmware Selection    ${campaignFirmwareRuleDict}[fromFirmwareAny]    ${campaignFirmwareRuleDict}[targetDeviceViaCsv]    ${fromfirmwareList}
    Log    **** Cron Tab enable disable ****
    Cron Tab Selection For Firmware Boot And Schedule    ${campaignFirmwareRuleDict}[enableBoot]    ${campaignFirmwareRuleDict}[enableScheduler]
    Log    **** Create Schedule for Download ****
    Create Schedule For Download    ${campaignFirmwareRuleDict}[frequency]    ${campaignFirmwareRuleDict}[hourGapDownload]    ${campaignFirmwareRuleDict}[durationTimeDownload]
    Run Keyword If    ${campaignFirmwareRuleDict}[activateSameAsDownload]    Press Click Element    ${eleCampaignManagerActivateSameAsDownlod}    ELSE    Create Schedule For Firmware Activate    ${campaignFirmwareRuleDict}[frequency]    ${campaignFirmwareRuleDict}[hourGapActivate]    ${campaignFirmwareRuleDict}[durationTimeActivate]
    Select Firmware Timezone    ${campaignFirmwareRuleDict}[timezone]
    Check Element    ${eleCampaignManagerRuleSave}
    Press Click Element    ${eleCampaignManagerRuleSave}
    Campaign Toaster Validation    .*${ruleNewName} rule created successfully.*   timeout=240s
    Capture Page Screenshot
    Page Should Contain    ${ruleNewName}
    Return From Keyword    ${ruleNewName}

Select Firmware Timezone
    [Documentation]    keyword to select the timezone for rule creation
    ...                 Argument:
    ...                    timezone -> timezone to set
    [Arguments]    ${timezone}
    ${timezoneSelector}    Replace String    ${drpDwnMultiCampaignFirmwareNewRuleTimezone}    TIMEZONE    ${timezone}
    Select From Dropdown Item    ${drpDwnMultiCampaignFirmwareNewRuleTimezoneClick}    ${timezoneSelector}

Create Schedule For Firmware Activate
    [Documentation]    keyword to create schedule for activate firmware
    ...                 Argument:
    ...                    frequency -> Day/year etc
    ...                    activateTime -> to set the activate schedule time
    ...                    activateRetryDuration -> to set the activate retry duration
    [Arguments]    ${frequency}    ${activateTime}    ${activateRetryDuration}
    Run Keyword If    '${frequency}'=='Day'    Schedule Firmware Activate For Day    ${activateTime}    ${activateRetryDuration}
    ...    ELSE IF    '${frequency}'=='Week'    Schedule Firmware Activate For Week    ${activateTime}    ${activateRetryDuration}
    ...    ELSE IF    '${frequency}'=='Month'    Schedule Firmware Activate For Month    ${activateTime}    ${activateRetryDuration}
    ...    ELSE IF    '${frequency}'=='Year'    SSchedule Firmware Activate For Year    ${activateTime}    ${activateRetryDuration}

Schedule Firmware Activate For Day
    [Documentation]    keyword to schedule activate firmware for Frequency Day
    ...                 Argument:
    ...                    scheduleTimeGap -> current time and schedule time gap
    ...                    scheduleRetryDuration -> to set the download retry duration
    [Arguments]    ${scheduleTimeGap}    ${scheduleRetryDuration}
    Log    **** Select Frequency ****
    ${targetActivateFreqency}    Replace String    ${eleCampaignManagerScheduleActivateFrequency}    FREQUENCY    Day
    ${timeToSet}    Get Time For Setting Schedule    ${scheduleTimeGap}
    Set Test Variable    ${scheduleActivateTime}    ${timeToSet}
    ${targetActivateDuration}    Replace String    ${eleCampaignManagerScheduleActivateDuration}    TIME    ${scheduleRetryDuration}
    ${targetActivateScheduleTime}    Replace String    ${eleCampaignManagerScheduleActivateTime}    TIME    ${timeToSet}
    Select From Dropdown Item    ${eleCampaignManagerScheduleActivateFrequencyClick}    ${targetActivateFreqency}
    Select From Dropdown Item    ${eleCampaignManagerScheduleActivateTimeClick}    ${targetActivateScheduleTime}
    Run Keyword If    '${scheduleRetryDuration}'!='1'    Select From Dropdown Item    ${eleCampaignManagerScheduleActivateDurationClick}    ${targetActivateDuration}
    Sleep    2s

Kibana Validation For Firmware Campaign
    [Documentation]    keyword to perform kibana validation for root and extenders
    ...                 Argument:
    ...                    operation -> kibana validation filter
    [Arguments]    ${operation}    ${extenderValidation}=True
    ${kibanaValidationRootEpocTime}    Set Variable    0
    ${kibanaValidationRootOperation}    Replace String    ${kibanaValidationSuccess}    OPERATION    ${operation}
    ${kibanaValidationRoot}    Replace String    ${kibanaValidationRootOperation}    MAC    "${Root}[mac1]"
    ${kibanaValidationRootEpocTime}    ${logData}    kibana Report Validation    ${kibanaValidationRoot}
    Log    ${logData}
    Run Keyword If    '${extenderValidation}'=='False'    Should Not Be Empty    ${logData}
    Return From Keyword If    '${extenderValidation}'=='False'
    FOR    ${extender}    IN    @{meshNodes}
        ${timeDiff}    Set Variable    0
        ${kibanaValidationExt}   Replace String    ${kibanaValidationRootOperation}    MAC    "${${extender}}[mac1]"
        ${ExtKibanatime}    Run Keyword And Continue On Failure    kibana Report Validation    ${kibanaValidationExt}
        ${timeDiff}    Evaluate    ${kibanaValidationRootEpocTime}-${ExtKibanatime}
        Run Keyword And Continue On Failure    Should Be True    ${timeDiff}>0    Root downloded before extender
    END

Rule Trend Validation Firmware
    [Documentation]    keyword to perform rule trend validation for root and extenders
    ...                 Argument:
    ...                    firmwareName ->firmware group name
    ...                    rulename->  rule name
    [Arguments]    ${firmwareName}    ${ruleName}
    Login And Open Campaign Firmware Page
    Open The Given Firmware    ${firmwareName}
    Wait Until Page Contains    ${ruleName}
    ${NewRuleTrendSelectClick}    Replace String    ${eleCampaignFirmwareNewRuleTrendSelectClick}    RULE    ${ruleName}
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Element    ${btnCampaignManagerRuleTrend}
    Capture Page Screenshot
    ${graphValue}    Fetch SVG Graph Values    ${eleCampaignGraphHighChart}    ${eleCampaignGraphTooltip}
    Should Not Be Empty    ${graphValue}
    Logout From Corteca Console
    
Rule Report Validation Firmware
    [Documentation]    keyword to perform rule report validation for root and extenders
    ...                 Argument:
    ...                    firmwareName ->firmware group name
    ...                    rulename->  rule name
    ...                    firmwareList ->firmware list to check
    [Arguments]    ${firmwareName}    ${ruleName}    ${firmwareList}
    ${pattern}    Set Variable    ${ruleName}*.csv
    Remove Files From User Download Path    ${pattern}
    Login And Open Campaign Firmware Page
    Open The Given Firmware    ${firmwareName}
    Wait Until Page Contains    ${ruleName}
    ${NewRuleTrendSelectClick}    Replace String    ${eleCampaignFirmwareNewRuleTrendSelectClick}    RULE    ${ruleName}
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Element    ${btncampaignManagerReportDownload}
    Sleep    5s
    Capture Page Screenshot
    ${reportData}    Get Files From User Download Path    ${pattern}
    Report validation    ${Root}[mac1]    ${reportData}    ${firmwareList}
    FOR    ${extender}    IN    @{meshNodes}
        Run Keyword And Continue On Failure    Report validation    ${${extender}}[mac1]    ${reportData}    ${firmwareList}
    END
    Logout From Corteca Console

Report validation
    [Documentation]    keyword to perform rule report validation for root and extenders
    ...                 Argument:
    ...                    mac -> MAC to check in report
    ...                    ruleReportData->  rule report as dictionary
    ...                    firmwareList ->firmware list to check
    [Arguments]    ${mac}    ${ruleReportData}    ${firmwareList}
    ${mac}    Convert To Upper Case    ${mac}
    ${mac}    Replace String    ${mac}    :    -
    Dictionary Should Contain Key    ${ruleReportData}    ${mac}
    Run Keyword And Continue On Failure    List Should Contain Value    ${firmwareList}    ${ruleReportData}[${mac}]["Firmware version"]
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${ruleReportData}[${mac}][MAC]    ${mac}	
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${ruleReportData}[${mac}]["Last status"]    COMPLETED

Enable Disable Rule
    [Documentation]    keyword to perform enable disable rule
    ...                 Argument:
    ...                    firmwareName ->firmware group name
    ...                    rulename->  rule name
    [Arguments]    ${firmwareName}    ${ruleName}    ${enableDisable}
    Login And Open Campaign Firmware Page
    Open The Given Firmware    ${firmwareName}
    Wait Until Page Contains    ${ruleName}
    Sleep    3s
    Cron Tab Toggle    ${toggleCampaignManagerNewFirmwareRuleEnableDisable}    ${toggleCampaignManagerNewFirmwareRuleEnableDisableClick}    ${enableDisable}
    Campaign Toaster Validation    .*${ruleName} is successfully changed.*   timeout=240s
    Capture Page Screenshot
