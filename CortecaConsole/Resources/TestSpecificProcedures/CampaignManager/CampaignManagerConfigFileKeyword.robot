*** Settings ***
Resource     ../../KeywordDefinition/CommonKeywords.robot
Resource    CampaignManagerCommonKeywords.robot
Resource    ../../KeywordDefinition/WebGUIAccessControlEnable.resource
Variables    ../../JavaScriptCodes/executeJavaScriptCodeCorteca.py
Variables    ../../../InputFiles/EnvironmentInput.py
Variables    ../../../Locators/CortecaConsoleLocators.py

*** Keywords ***
Login and Open Campaign Config File Page
    Login To CampaignManager
    Open which Campaign  ConfigFile
    Wait Until Page Contains Element    ${btnCampaignManagerAddNewConfigFile}
    Capture Page Screenshot

Add A New Config File
    [Documentation]    This function will perform the following:
    ...                1: Create the Config file \n
    ...                 Argument:  campaignManagerConfigFileDict -> A dictionary argument in which all variables needed for rule creation
    ...                    {
    ...                    'Name':'<Name for the rule>',
    ...                    'Description':'Description for the rule', #
    ...                    'Version':'<Version>',
    ...                    'HwModel':'<Hw model>',
    ...                    'NewConfigFilePath':'<config file path>',
    ...                    'DefaultConfigFilePath':'<Default config file path>',
    ...                    'Firmware':'<current firmware>'
    ...                    }]}
    ...                 eg: ccampaignManagerConfigFileDict={
    ...                    'Name':'NewConfigPush',
    ...                    'Description':'NewConfigPush_Beacon_6',
    ...                    'Version':'1',
    ...                    'HwModel':'BEACON 6 HA-0336G-A',
    ...                    'NewConfigFilePath':'C:\\Users\\ajayan\\Desktop\\Monthly Plan\\Automation\\e2eautomation\\CortecaConsole\\Resources\\CFPNKBU001',
    ...                    'DefaultConfigFilePath':'',
    ...                    'Firmware':'3FE49062HJLJ53'
    ...                    }
    ...                ${configFile} -> config file path
    [Arguments]    ${campaignManagerConfigFile}    ${configFile}=${NewConfigFilePath}
    Log To Console    **** Open In admin dashboard -> campaigns -> ConfigFiles ****
    Login and Open Campaign Config File Page
    Log To Console    ***** Add A New Config File ******
    Check Element    ${btnCampaignManagerAddNewConfigFile}
    Press Click Button    ${btnCampaignManagerAddNewConfigFile}
    Enter Value    ${eleCampaignManagerNewConfigFileName}    ${campaignManagerConfigFile}[Name]    timeout=60s
    Enter Value    ${eleCampaignManagerNewConfigFileVersion}    ${campaignManagerConfigFile}[Version]
    Enter Value    ${eleCampaignManagerNewConfigFileDescription}    ${campaignManagerConfigFile}[Description]
    Log    **** Adding Harware Models to ${campaignManagerConfigFile}[Name] *****
    ${dropDownItemSelector}    Replace String    ${dropDownItemSelectCampaignConfigFileModel}    MODEL    ${campaignManagerConfigFile}[HwModel]
    Select From Dropdown Item    ${dropDownItemCampaignConfigFileClick}    ${dropDownItemSelector}
    Upload A File    ${eleCampaignManagerNewConfigFileSelectFile}    ${configFile}
    Press Click Button    ${btnCampaignManagerNewConfigFileSave}
    Log To Console    ***** Validating Success toaster after config file creation ******
    Wait Until Page Contains    Configuration file ${campaignManagerConfigFile}[Name] create initiated.
    Page Should Contain    Configuration file ${campaignManagerConfigFile}[Name] create initiated
    Wait Until Page Contains    Configuration file ${campaignManagerConfigFile}[Name] created successfully.    timeout=90s
    Page Should Contain    Configuration file ${campaignManagerConfigFile}[Name] created successfully.
    Page Should Contain    ${campaignManagerConfigFile}[Name]
    Logout From Corteca Console

Delete A Config File
    [Documentation]    This keyword is used to delete the specific config file
    ...    Arg: config file name
    [Arguments]    ${configFileName}
    Log To Console    Deleting ${configFileName}
    Login and Open Campaign Config File Page
    Page Should Contain    ${configFileName}
    ${itemSelector}    Replace String    ${btnCampaignManagerNewConfigFileList}    CONFIGFILE    ${configFileName}
    Scroll Element Into View    ${itemSelector}
    Press Click Element    ${itemSelector}
    Mouse Down    ${btnCampaignManagerNewConfigFileDelete}
    Press Click Element    ${btnCampaignManagerNewConfigFileDelete}
    Press Click Element    ${btnCampaignManagerNewConfigFileDeleteConfirm}
    Capture Page Screenshot
    Wait Until Page Contains    Selected configuration file ${configFileName} was deleted successfuly.    timeout=60s
    Page Should Contain    Selected configuration file ${configFileName} was deleted successfuly.
    Sleep    ${sleepMin}
    Run Keyword And Continue On Failure    Execute Javascript    ${closeToaster}
    Sleep    ${sleepMin}
    Logout From Corteca Console

Create A New Rule For Campaign ConfigFile
    [Documentation]    Create a Rule for the given config file group
    ...                 Argument:
    ...                campaignManagerConfigFileName -> config file group name under which rule need to create
    ...                campaignManagerConfigFileCSV -> CSV file path. default null
    ...                campaignConfigFileRuleDict -> Dictinary data for rule creation
    ...                        eg: campaignConfigFileRuleDict{
    ...                                    'fromFirmwareAny':True,
    ...                                    'ruleName':'NewConfigRule',
    ...                                    'timezone': 'Asia/Kolkata',
    ...                                    'enableBoot':'False',
    ...                                    'enableScheduler':'True',
    ...                                    'targetDeviceViaCsv':True,
    ...                                    'hourGapDownload':'1',
    ...                                    'frequency':'Day',
    ...                                    'durationTimeDownload':'1'}
    ...              fromfirmwareList -> From firmware list
    ...              toasterCheck -> toaster check. default True. If true it will validate toaster success.
    [Arguments]    ${campaignManagerConfigFileName}    ${campaignConfigFileRuleDict}    ${campaignManagerConfigFileCSV}=''    ${fromfirmwareList}=[]     ${toasterCheck}=${True}
    [Teardown]    Close Browser
    Login and Open Campaign Config File Page
    Open The Given ConfigFile   ${campaignManagerConfigFileName}
    Log    **** Add New Rule ****
    ${ruleNewName}    Add A New Rule Config File    ${campaignConfigFileRuleDict}    ${fromfirmwareList}    ${campaignManagerConfigFileCSV}    ${toasterCheck}
    Return From Keyword    ${ruleNewName}

Open The Given ConfigFile
    [Documentation]    Open the given configFile from Available List
    ...                 Argument:
    ...                    configFileGroupName -> Name of the config group
    [Arguments]    ${configFileGroupName}
    ${configfileSelector}    Replace String    ${eleCortecaAdminCampaignConfigFileList}    CONFIGFILE    ${configFileGroupName}
    Check Element    ${configfileSelector}
    Mouse Down    ${configfileSelector}
    Press Click Element    ${configfileSelector}

Add A New Rule Config File
    [Documentation]    keyword to create schedule rule for given config file
    ...                 Argument:
    ...                    campaignConfigFileRuleDict -> Dictinary data for rule creation: for example refer  Create A New Rule For Campaign ConfigFile
    ...                    fromfirmwareList -> list of from firmware versions to set
    ...                    campaignConfigFileCsv -> csv file path
    ...                    toasterCheck -> toaster check. default True. If true it will validate toaster success.
    [Arguments]    ${campaignConfigFileRuleDict}    ${fromfirmwareList}=[]    ${campaignConfigFileCsv}=''    ${toasterCheck}=${True}
    Press Click Element    ${btnCampaignManagerAddNewConfigFile}
    ${ruleNewName}    Generate Random String    1    [NUMBERS]
    ${ruleNewName}    Set Variable    ${ruleNewName}_${campaignConfigFileRuleDict}[ruleName]
    Enter Value    ${eleCampaignManagerNewConfigFileAddRuleName}    ${ruleNewName}
    Set Test Variable    ${ruleNewName}
    Log    **** From firmware selections and Target devices ****
    Target Device And Firmware Selection    ${campaignConfigFileRuleDict}[fromFirmwareAny]    ${campaignConfigFileRuleDict}[targetDeviceViaCsv]    ${fromfirmwareList}    ${campaignConfigFileCsv}
    Log    **** Cron Tab enable disable ****
    Cron Tab Selection For Firmware Boot And Schedule    ${campaignConfigFileRuleDict}[enableBoot]    ${campaignConfigFileRuleDict}[enableScheduler]
    Log    **** Create Schedule for Download ****
    Create Schedule For Download    ${campaignConfigFileRuleDict}[frequency]    ${campaignConfigFileRuleDict}[hourGapDownload]    ${campaignConfigFileRuleDict}[durationTimeDownload]
    Select Firmware Timezone    ${campaignConfigFileRuleDict}[timezone]
    Check Element    ${eleCampaignManagerRuleSave}
    Press Click Element    ${eleCampaignManagerRuleSave}
    Run Keyword And Continue On Failure    Wait Until Page Contains    ${ruleNewName} rule created successfully.
    ${status}    Run Keyword And Return Status    Page Should Contain    ${ruleNewName} rule created successfully.
    Run Keyword And Continue On Failure    Run Keyword If    ${toasterCheck}    Should Be True    ${status}
    Capture Page Screenshot
    Page Should Contain    ${ruleNewName}
    Return From Keyword    ${ruleNewName}

Get Rule Trend Graph
    [Documentation]    keyword to perform rule trend validation for root and extenders
    ...                 Argument:
    ...                    configFileName ->configFile group name
    ...                    rulename->  rule name
    ...                    ruleUsingCSV -> True -> Rule created via csv
    ...                                    False -> Rule created not via csv
    [Arguments]    ${configFileName}    ${ruleName}
    Login and Open Campaign Config File Page
    Open The Given ConfigFile   ${configFileName}
    Wait Until Page Contains    ${ruleName}
    ${NewRuleTrendSelectClick}    Replace String    ${eleCampaignConfigFileNewRuleTrendSelectClick}    RULE    ${ruleName}
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Element    ${btnCampaignManagerRuleTrend}
    Sleep    15s
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${eleCampaignGraphHighChart}
    Capture Page Screenshot
    ${graphValue}    Fetch SVG Graph Values    ${eleCampaignGraphHighChart}    ${eleCampaignGraphTooltip}
    Log    ${graphValue}
    Logout From Corteca Console
    Return From Keyword    ${graphValue}

Rule Trend Validation ConfigFile
    [Documentation]    keyword to perform rule trend validation for root and extenders
    ...                 Argument:
    ...                    configFileName ->configFile group name
    ...                    rulename->  rule name
    ...                    ruleUsingCSV -> True -> Rule created via csv
    ...                                    False -> Rule created not via csv
    [Arguments]    ${configFileName}    ${ruleName}    ${ruleUsingCSV}=${False}    ${extenderCheck}=${False}
    ${graphValue}    Get Rule Trend Graph    ${configFileName}    ${ruleName}
    Log    ${graphValue}
    Run Keyword If    not ${ruleUsingCSV}    Should Not Be Empty    ${graphValue}
    Run Keyword If    ${ruleUsingCSV}    Rule Trend Validation CSV    ${graphValue}    extenderCheck=${extenderCheck}

Get Match Response Count From Graph
    [Arguments]    ${graphValue}    ${matchString}
    ${countMatch}    Set Variable    0
    FOR    ${value}    IN    @{graphValue}
        Log    ${value}
        Log    ${matchString}
        ${value}    Convert To String    ${value}
        ${matchStringValue}    Get Regexp Matches    ${value}    ${matchString}
        Log    ${matchString}
        ${matchGrouplen}    Get Length    ${matchStringValue}
        ${countMatch}    Evaluate    ${countMatch}+${matchGrouplen}
    END
    Return From Keyword    ${countMatch}

Rule Trend Validation CSV
    [Documentation]    keyword to check rule trend validation for root and extenders
    ...                 Argument:
    ...                    graphValue ->Grapgh values; output of 'Fetch SVG Graph Values'
    [Arguments]    ${graphValue}    ${rootCount}=1    ${extenderCheck}=${False}
    ${errorCount}    Set Variable    0
    ${succesCount}    Set Variable    0
    ${meshNodeCount}    Get Length    ${meshNodes}
    ${errorCount}    Get Match Response Count From Graph    ${graphValue}     .*Error.*
    ${succesCount}    Get Match Response Count From Graph    ${graphValue}    .*Successes.*
    Log Many    ${errorCount}    ${succesCount}
    Run Keyword And Continue On Failure    Should Be Equal As Integers    ${succesCount}    ${rootCount}    msg="Success count not matching with Root count"
    Run Keyword If    ${extenderCheck}    Should Be Equal As Integers    ${errorCount}    ${meshNodeCount}    msg="Error count not matching with extender count"

    
Validate Rule Creation With Wrong Model MAC
    [Documentation]    keyword to Validate rule creation fails when wrong models given in csv
    ...                 Argument:
    ...                    csvFileName ->csv file name
    ...                    configFileGroupName->  config file group name under which rule need to create
    ...                    campaignConfigFileRuleDict-> Dictinary data for rule creation: for example refer  'Create A New Rule For Campaign ConfigFile'
    ...                    fromfirmwareList -> list of from firmware versions to set. default empty list
    [Arguments]    ${csvFileName}    ${configFileGroupName}    ${campaignConfigFileRuleDict}    ${fromfirmwareList}=[]
    ${csvFilePathWrongMac}    Create CSV File    ${csvFileName}
    Append to CSV    ${csvFilePathWrongMac}    MAC
    Append to CSV    ${csvFilePathWrongMac}    \n${campaignManagerConfigFileDict}[WrongMac]
    Login and Open Campaign Config File Page
    Open The Given ConfigFile   ${configFileGroupName}
    Log    **** Add New Rule ****
    Press Click Element    ${btnCampaignManagerAddNewConfigFile}
    ${ruleNewName}    Generate Random String    1    [NUMBERS]
    ${ruleNewName}    Set Variable    ${ruleNewName}_${campaignConfigFileRuleDict}[ruleName]
    Enter Value    ${eleCampaignManagerNewConfigFileAddRuleName}    ${ruleNewName}
    Set Test Variable    ${ruleNewName}
    Log    **** From firmware selections and Target devices ****
    Target Device And Firmware Selection    ${campaignConfigFileRuleDict}[fromFirmwareAny]    ${campaignConfigFileRuleDict}[targetDeviceViaCsv]    ${fromfirmwareList}    ${csvFilePathWrongMac}
    Log    **** Cron Tab enable disable ****
    Cron Tab Selection For Firmware Boot And Schedule    ${campaignConfigFileRuleDict}[enableBoot]    ${campaignConfigFileRuleDict}[enableScheduler]
    Log    **** Create Schedule for Download ****
    Check Element    ${eleCampaignManagerRuleSave}
    Create Schedule For Download    ${campaignConfigFileRuleDict}[frequency]    ${campaignConfigFileRuleDict}[hourGapDownload]    ${campaignConfigFileRuleDict}[durationTimeDownload]
    Select Firmware Timezone    ${campaignConfigFileRuleDict}[timezone]
    Check Element    ${eleCampaignManagerRuleSave}
    Press Click Element    ${eleCampaignManagerRuleSave}
    Run Keyword And Continue On Failure    Wait Until Page Contains    Not matching with device selection   timeout=240s
    Run Keyword And Continue On Failure    Page Should Contain    Not matching with device selection
    Capture Page Screenshot
    Run Keyword And Ignore Error    Execute Javascript    ${closeToaster}
    Sleep    5s
    Page Should Not Contain    ${ruleNewName}
    Logout From Corteca Console

Rule Report Download
    [Documentation]    keyword to perform rule report validation for root and extenders
    ...                 Argument:
    ...                    configFileName ->config file group name
    ...                    rulename->  rule name
    [Arguments]    ${configFileName}    ${ruleName}
    ${pattern}    Set Variable    ${ruleName}*.csv
    Remove Files From User Download Path    ${pattern}
    Login and Open Campaign Config File Page
    Open The Given ConfigFile   ${configFileName}
    Wait Until Page Contains    ${ruleName}
    ${NewRuleTrendSelectClick}    Replace String    ${eleCampaignConfigFileNewRuleTrendSelectClick}    RULE    ${ruleName}
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Element    ${btncampaignManagerReportDownload}
    Sleep    5s
    Capture Page Screenshot
    ${reportData}    Get Files From User Download Path    ${pattern}
    Log    ${reportData}
    Logout From Corteca Console
    Return From Keyword    ${reportData}
    
Rule Report Validation ConfigFile
    [Documentation]    keyword to perform rule report validation for root and extenders
    ...                 Argument:
    ...                    configFileName ->config file group name
    ...                    rulename->  rule name
    [Arguments]    ${configFileName}    ${ruleName}    ${extenderCheck}=${False}
    ${reportData}    Rule Report Download    ${configFileName}    ${ruleName}
    Log    ${reportData}
    Report validation    ${Root}[mac1]    ${reportData}    ${RootConfigFileApplyStatus}
    Return From Keyword If    '${extenderCheck}'=='False'
    FOR    ${extender}    IN    @{meshNodes}
        Run Keyword And Continue On Failure    Report validation    ${${extender}}[mac1]    ${reportData}    ${ExtConfigFileApplyStatus}
    END

Report validation
    [Documentation]    keyword to perform rule report validation for root and extenders
    ...                 Argument:
    ...                    mac -> MAC to check in report
    ...                    ruleReportData->  rule report as dictionary
    ...                    applyStatus -> string to match the status. Eg : COMPLETED/ERROR
    [Arguments]    ${mac}    ${ruleReportData}    ${applyStatus}
    ${mac}    Convert To Upper Case    ${mac}
    ${mac}    Replace String    ${mac}    :    -
    Dictionary Should Contain Key    ${ruleReportData}    ${mac}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${ruleReportData}[${mac}][MAC]    ${mac}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${ruleReportData}[${mac}]["Last status"]    ${applyStatus}

Verify Applied ConfigFile Webgui Changes
    [Documentation]    keyword to validated the webgui changes before and after config file applies
    ...                 Argument:
    ...                    afterApply -> default True -> webgui check after config file applies.
    ...                                -> false ->  webgui check before config file applies.
    [Arguments]    ${afterApply}=${True}
    [Teardown]    Close Browser
    Open Pureview WebGui
    Click Element    ${WanTab}
    Sleep    10s
    Scroll Element Into View    ${LanTab}
    Sleep    2s
    ${statusStaticRoute}    Run Keyword And Return Status    Click Element    ${StaticRoutingTab}
    Capture Page Screenshot    
    Click Element    ${AdvanceSettingTab}
    Sleep    10s
    Scroll Element Into View    ${MaintenanceTab}
    Sleep    2s
    ${statusDdns}    Run Keyword And Return Status    Click Element    ${DDNSTab}
    Capture Page Screenshot
    Run Keyword If    ${afterApply}    Should Be True    '${statusStaticRoute}'=='${False}' and '${statusDdns}'=='${False}'
    Run Keyword If    '${afterApply}'=='False'    Should Be True    '${statusStaticRoute}'=='${True}' and '${statusDdns}'=='${True}'

Verify Applied ConfigFile Portal Changes
    [Documentation]    keyword to validated the portal changes before and after config file applies
    ...                 Argument:
    ...                    configurationFileName -> Applied config file name
    ...                    afterApply -> default True -> portal check after config file applies.
    ...                                -> false ->  portal check before config file applies.
    [Arguments]    ${configurationFileName}    ${afterApply}=${True}
    Login To Corteca Console
    Open Corteca Console Home Page
    ${status}    Page Should Contain Element    ${eleSettingsTab}
    Run Keyword If    ${status}    Press Click Element    ${eleNewPortal}
    Press Click Element    ${eleSettingsTab}
    Press Click Element    ${eleConfigurationTab}    timeout=60s
    ${tableData}    Get Text Data    ${eleAppliedConfigurationTable}    timeout=60s
    Run Keyword If    ${afterApply}    Should Contain    ${tableData}    ${configurationFileName}    msg="Expected ${configurationFileName} in Applied config but portal shows ${tableData}"
    ...    ELSE     Should Not Contain    ${tableData}    ${configurationFileName}    msg="Expected ${configurationFileName} not shown in Applied config but portal shows ${tableData}"
    Logout From Corteca Console

Validate Config Campaign After Reboot
    [Documentation]    keyword to verify the config file campaign trigger before and after reboot
    ...                 Argument:
    ...                    configFileName -> Applied config file name
    ...                    ruleName -> rule name
    [Arguments]    ${configFileName}    ${ruleName}
    ${pattern}    Set Variable    ${ruleName}*.csv
    ${mac}    Convert To Upper Case    ${Root}[mac1]
    ${mac}    Replace String    ${mac}    :    -
    ${reportData}    Get Files From User Download Path    ${pattern}
    ${lastUpdate}    Set Variable    ${reportData}[${mac}]["Last Executed Time"]
    Log    ${lastUpdate}
    Log To Console    Initiating device reboot
    ${result}   SSHExecute    reboot
    sleep    900s
    Log To Console   After Waiting 900s on reboot verify the USP mqtt connection
    Validate_Process    ${Root}[ip]    ${Root}[telnet_vtysh]
    Log To Console    Waiting for 9 min to confirm whether the config applied after reboot
    Sleep    540s
    Log To Console    Validate the config file not applied after reboot by comparing the rule report last execution status
    Remove Files From User Download Path    ${pattern}
    Login and Open Campaign Config File Page
    Open The Given ConfigFile   ${configFileName}
    Wait Until Page Contains    ${ruleName}
    ${NewRuleTrendSelectClick}    Replace String    ${eleCampaignConfigFileNewRuleTrendSelectClick}    RULE    ${ruleName}
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Element    ${btncampaignManagerReportDownload}
    Sleep    5s
    Capture Page Screenshot
    ${reportData}    Get Files From User Download Path    ${pattern}
    ${lastUpdateAfterReboot}    Set Variable    ${reportData}[${mac}]["Last Executed Time"]
    Log    ${lastUpdateAfterReboot}
    Should Be Equal As Strings    ${lastUpdate}    ${lastUpdateAfterReboot}    msg="Seems config file again applied since Last Executed Time Not matching before and after reboot"

Delete Rule
    [Documentation]    keyword to verify the delete rule
    ...                 Argument:
    ...                    configFileName -> Applied config file name
    ...                    ruleName -> rule name
    [Arguments]    ${configFileName}    ${ruleName}
    Login and Open Campaign Config File Page
    Open The Given ConfigFile   ${configFileName}
    Wait Until Page Contains    ${ruleName}
    ${NewRuleTrendSelectClick}    Replace String    ${eleCampaignConfigFileNewRuleTrendSelectClick}    RULE    ${ruleName}
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Button     ${btnCampaignManagerNewConfigFileRuleDelete}
    Press Click Button     ${btnCampaignManagerNewConfigFileRuleConfirm}
    Run Keyword And Continue On Failure    Campaign Toaster Validation    Selected rule .*${ruleName} got deleted successfuly.*   timeout=240s
    Capture Page Screenshot
    Page Should Not Contain    ${ruleName}
    Capture Page Screenshot
    Logout From Corteca Console

Verify The Edit Configs
    [Documentation]    keyword to verify the Edit configs of rule created
    ...                 Argument:
    ...                    configFileName -> Applied config file name
    ...                    ruleName -> rule name
    [Arguments]    ${configFileName}    ${rulename}
    ${newRuleName}    Set Variable    newDummyName
    Login and Open Campaign Config File Page
    Open The Given ConfigFile   ${configFileName}
    Wait Until Page Contains    ${ruleName}
    ${NewRuleTrendSelectClick}    Replace String    ${eleCampaignConfigFileNewRuleTrendSelectClick}    RULE    ${ruleName}
    Set Test Variable    ${NewRuleTrendSelectClick}    ${NewRuleTrendSelectClick}
    Log To Console    **** 1: Campaign rule Boot Toggle validation ****
    Run Keyword And Continue On Failure    Validate Cron Tab Toggle Check   ${rulename}
    Log To Console    **** 2: Campaign rule Edit Schedule change validation ****
    Run Keyword And Continue On Failure    Validate Editing Schedule    ${rulename}
    Log To Console    **** 3: Campaign rule Edit Schedule change validation ****
    Run Keyword And Continue On Failure    Validate Editing TimeZone    ${rulename}
    Log To Console    **** 4: Campaign rule Edit Name validation ****
    Run Keyword And Continue On Failure    Validate Editing Name    ${newRuleName}

Validate Editing Name
    [Documentation]    keyword to verify the Name edit for a rule
    ...                 Argument:
    ...                    ruleName -> rule name
    [Arguments]    ${newRuleName}
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Button     ${btnCampaignManagerConfigFileRuleEdit}
    Sleep    5s
	Enter Value    ${eleCampaignManagerNewConfigFileAddRuleName}    ${newRuleName}
	Press Click Element    ${eleCampaignManagerRuleSave}
	Wait Until Page Contains    Selected rule ${newRuleName} is successfully changed.    timeout=30s
	Capture Page Screenshot
	Run Keyword And Continue On Failure    Page Should Contain    Selected rule ${newRuleName} is successfully changed.
	${status}    Run Keyword And Return Status    Page Should Contain    ${newRuleName}
	Run Keyword And Ignore Error    Execute Javascript    ${closeToaster}
	Should Be True    ${status}    msg="Editing Name is failed"

Validate Cron Tab Toggle Check
    [Documentation]    keyword to verify the Boot toggle button edit for a rule
    ...                 Argument:
    ...                    ruleName -> rule name
    [Arguments]    ${ruleName}
    Log To Console    Validate  the Boot toggle button edit
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Button     ${btnCampaignManagerConfigFileRuleEdit}
    Sleep    10s
    ${prevStatus}    Execute Javascript    ${campaignToggle}
	Press Click Element    ${toggleCampaignManagerNewRuleEnableBootClick}
	${currentStatus}    Execute Javascript    ${campaignToggle}
	Press Click Element    ${eleCampaignManagerRuleSave}
	Wait Until Page Contains    Selected rule ${ruleName} is successfully changed.    timeout=30s
	Capture Page Screenshot
	Run Keyword And Continue On Failure    Page Should Contain    Selected rule ${ruleName} is successfully changed.
	${status}    Run Keyword And Return Status    Page Should Contain    ${ruleName}
	Run Keyword And Ignore Error    Execute Javascript    ${closeToaster}
	Should Be True    ${status}    msg="Boot Toggle from ${prevStatus} to ${currentStatus} is failed"

Validate Editing Schedule
    [Documentation]    keyword to verify the schedule change for a rule
    ...                 Argument:
    ...                    ruleName -> rule name
    [Arguments]    ${ruleName}
    Log To Console    Validate the schedule change
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Button     ${btnCampaignManagerConfigFileRuleEdit}
    Sleep    10s
    Create Schedule For Download    Day    5    4
	Press Click Element    ${eleCampaignManagerRuleSave}
	Wait Until Page Contains    Selected rule ${ruleName} is successfully changed.    timeout=30s
	Capture Page Screenshot
	Run Keyword And Continue On Failure    Page Should Contain    Selected rule ${ruleName} is successfully changed.
	${status}    Run Keyword And Return Status    Page Should Contain    ${ruleName}
	Run Keyword And Ignore Error    Execute Javascript    ${closeToaster}
	Should Be True    ${status}    msg="Schedule change is failed"


Validate Editing TimeZone
    [Documentation]    keyword to verify the Timezone change for a rule
    ...                 Argument:
    ...                    ruleName -> rule name
    [Arguments]    ${ruleName}
    Log To Console    Validate the Timezone change
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Button     ${btnCampaignManagerConfigFileRuleEdit}
    Sleep    10s
    Select Firmware Timezone    Asia/Kashgar
	Press Click Element    ${eleCampaignManagerRuleSave}
	Wait Until Page Contains    Selected rule ${ruleName} is successfully changed.    timeout=240s
	Capture Page Screenshot
	Run Keyword And Continue On Failure    Page Should Contain    Selected rule ${ruleName} is successfully changed.
	Run Keyword And Ignore Error    Execute Javascript    ${closeToaster}
	${status}    Run Keyword And Return Status    Page Should Contain    ${ruleName}
	Should Be True    ${status}    msg="TimeZone change is failed"
    Run Keyword If    ${status}    Press Click Element    ${NewRuleTrendSelectClick}
    Run Keyword If    ${status}    Press Click Button     ${btnCampaignManagerConfigFileRuleEdit}
    Check Element    ${eleCampaignManagerRuleSave}
    Page Should Contain    Asia/Kashgar
    Run Keyword And Ignore Error    Press Click Element    ${btnEditTabClose}

Apply Default Config File
    [Documentation]    keyword to Apply default config file for teardown
    ...                 Argument:
    ...                    campaignManagerConfigFile -> rule name
    [Arguments]    ${campaignManagerConfigFile}
    Run Keyword And Continue On Failure    Delete A Config File    ${campaignManagerConfigFile}[Name]
    Log To Console    Reverting to Default Configs
    Perform Factory Reset In USP
    Sleep    10s
#    Log To Console    **** Open In admin dashboard -> campaigns -> ConfigFiles ****
#    Login and Open Campaign Config File Page
#    Log To Console    **** Add Config file ****
#    Add A New Config File    ${campaignManagerConfigFile}    configFile=${DefaultConfigFilePath}
#    Apply Config From Settings    ${campaignManagerConfigFileDict}[Name]
#    Run Keyword And Continue On Failure    Delete A Config File    ${campaignManagerConfigFileDict}[Name]

Apply Config From Settings
    [Documentation]    keyword to Apply default config file from Settings page
    ...                 Argument:
    ...                    configFile -> Config file name
    ...                    afterApply -> default value webgui check
    [Arguments]    ${configFile}    ${afterApply}=${False}
    Log To Console    **** Applying config file from portal settings page ****
    Login To Corteca Console
    Open Corteca Console Home Page
    Press Click Element    ${eleSettingsTab}
    Press Click Element    ${eleConfigurationTab}    timeout=60s
    ${configFileSelectClick}    Replace String    ${eleSettingsConfigFileSelectClick}    CONFIGFILE    ${configFile}
    Press Click Element    ${configFileSelectClick}
    Sleep    2s
    Press Click Element    ${eleSettingsConfigFileApply}
    Sleep    5s
    Capture Page Screenshot
    Click Element    ${eleSettingsConfigFileApplyConfirm}
    Capture Page Screenshot
    Sleep    60s
    Log To Console    **** Verify the applied config file ****
    Verify Applied ConfigFile Webgui Changes    ${afterApply}

Verify Config Campaign Based On Device Status
    [Documentation]    keyword to make wan up and down and verify the config campaign behaviour
    ...                 Argument:
    ...                    wanStatus -> String variable (true/false)
    ...                    deviceStatus -> boolean variable (True/False)
    ...                    configFile-> config file name
    ...                    ruleName-> rule name
    [Arguments]    ${wanStatus}    ${deviceStatus}    ${configFile}    ${ruleName}
    Make WAN Down    ${wanStatus}
    Run Keyword If    ${deviceStatus}    Validate_Process    ${Root}[ip]    ${Root}[telnet_vtysh]
    ${getSleepCount}    Get The Next Quad Wait Time
    Log To Console    ${getSleepCount}
    Log To Console    "Wait until next schedule triggered"
    ${sleepTime}    Evaluate    ${getSleepCount}+900
    Sleep    ${sleepTime}
    Log To Console    "Validation after Schedule time"
    Validate Config Campaign After Wan UpAndDown    ${configFile}    ${ruleName}    ${deviceStatus}

Validate Config Campaign After Wan UpAndDown
    [Documentation]    keyword to verify the config campaign behaviour based on device online and offline
    ...                 Argument:
    ...                    deviceStatus -> boolean variable (True/False)
    ...                    configFile-> config file name
    ...                    ruleName-> rule name
    [Arguments]    ${configFile}    ${ruleName}    ${deviceStatus}
    Log    ${deviceStatus}
    Run Keyword If    '${deviceStatus}'=='False'    Verify Applied ConfigFile Webgui Changes    afterApply=${False}
    Return From Keyword If    '${deviceStatus}'=='False'
    Run Keyword And Continue On Failure    Rule Trend Validation ConfigFile    ${configFile}    ${ruleName}    ruleUsingCSV=${True}
    Run Keyword And Continue On Failure    Rule Report Validation ConfigFile    ${configFile}    ${ruleName}
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Webgui Changes    afterApply=${True}
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Portal Changes    ${configFileName}    afterApply=${True}
