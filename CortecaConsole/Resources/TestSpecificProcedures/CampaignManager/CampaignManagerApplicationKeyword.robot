*** Settings ***
Resource     ../../KeywordDefinition/CommonKeywords.robot
Resource    CampaignManagerCommonKeywords.robot
Variables    ../../JavaScriptCodes/executeJavaScriptCodeCorteca.py
Variables    ../../../InputFiles/EnvironmentInput.py
Variables    ../../../Locators/CortecaConsoleLocators.py
Resource    ../ContainerAppKeyword.resource
Resource    ../../KeywordDefinition/ApiRequest.resource
Library    Collections


*** Keywords ***
Login and Open Campaign Application Page
    Login To CampaignManager
    Open which Campaign    Application
    Wait Until Page Contains Element    ${eleCortecaAdminCampaignApplicationPage}    timeout=120s
    Capture Page Screenshot

Create Application Campaign Rule
    [Arguments]    ${campaignApplicationListDict}    ${ruleCreationDict}    ${campaignAction}=Install    ${csvFile}=''    ${update}=${False}
    ${ruleNameDict}    Create Dictionary    
    FOR    ${app}    IN    @{campaignApplicationListDict}
        ${appVersion}    Set Variable If    ${update}    ${app}[UpdateVersion]     ${app}[AppVersion]
        ${statusUpdate}    Run Keyword And Return Status    Should Be Equal As Strings    ${appVersion}    ${EMPTY}
        Continue For Loop If    ${statusUpdate}
        ${rulename}    Set Variable    ${app}[Name]_${campaignAction}
        Create Application Rule    ${rulename}    ${campaignAction}    ${app}[HwModel]    ${app}[FirmwareVersions]    ${appVersion}    ${csvFile}    ${ruleCreationDict}    application=${app}[Application]
        Set To Dictionary    ${ruleNameDict}    ${app}[Application]=${ruleName}
    END
    Set Test Variable    ${appsCampaignRuleDict}    ${ruleNameDict}

Create Application Rule    
    [Arguments]    ${rulename}    ${campaignAction}    ${appHwModel}     ${appFirmwareVersions}    ${appVersion}    ${csvFile}    ${ruleCreationDict}    ${neg}=${False}    ${errMsg}=''    ${application}=''    ${appRuleStatus}=True    ${marketPlace}=${False}
    Run Keyword If    '${marketPlace}'=='${False}'    Login and Open Campaign Application Page
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${application}
    Press Click Element    ${appSelect}
    Log To Console    **** Creating rule for ${application} ****
    Press Click Element    ${eleCortecaAdminCampaignApplicationAddNewRule}
    Enter Value    ${eleCampaignManagerNewConfigFileAddRuleName}    ${rulename}
    Log To Console    **** Rule status enable disable ****
    Cron Tab Toggle    ${toggleCampaignManagerNewAppRuleEnableDisable}    ${toggleCampaignManagerNewAppRuleEnableDisableClick}    ${appRuleStatus}
    Log To Console    **** Selecting the campaign action ${campaignAction} ****
    Select Campaign Rule Action    ${campaignAction}
    Log To Console    **** Selecting the Target Models ****
    Run Keyword If    ${ruleCreationDict}[targetDeviceViaCsv]    Target Device With CSV Upload    ${csvFile}    ELSE    Select Network Devices    ${appHwModel}
    Log To Console    **** Selecting the Firmware versions ****
    Select From Firmwares    ${appFirmwareVersions}    ${ruleCreationDict}[fromFirmwareAny]
    Log To Console    **** Selecting the App versions ****

    Select Application Version    ${appVersion}
    Check Element    ${toggleCampaignManagerNewRuleEnableBootClick}
    Log To Console    **** Selecting Cron Tab for Boot and Schedule ****
    Cron Tab Selection For Firmware Boot And Schedule    ${ruleCreationDict}[enableBoot]    ${ruleCreationDict}[enableScheduler]
    Log To Console    **** Creating the schedule for App ****
    Check Element    ${eleCampaignManagerRuleSave}
    Run Keyword If    ${ruleCreationDict}[enableScheduler]    Create Schedule For Download    ${ruleCreationDict}[frequency]    ${ruleCreationDict}[hourGapDownload]    ${ruleCreationDict}[durationTimeDownload]
    Log To Console    **** Selecting the Timezone ****
    Select Firmware Timezone    ${ruleCreationDict}[timezone]
    Log To Console    **** Saving the Rule ****
    Capture Page Screenshot
    Check Element    ${eleCampaignManagerRuleSave}
    Press Click Element    ${eleCampaignManagerRuleSave}
    Run Keyword If    ${neg}    Wait Until Page Contains    ${errMsg}    timeout=120s
    Run Keyword If    ${neg}    Page Should Contain    ${errMsg}
    Return From Keyword If    ${neg}
    Run Keyword And Continue On Failure    Wait Until Page Contains    ${rulename} rule created successfully.    timeout=120s
    Run Keyword And Continue On Failure    Page Should Contain    ${rulename} rule created successfully.
    Capture Page Screenshot
    Page Should Contain    ${rulename}
    Sleep    2s
    Logout From Corteca Console

Select Campaign Rule Action
    [Arguments]    ${campaignAction}
    ${actionSelector}    Replace String    ${eleCortecaAdminCampaignApplicationAddNewRuleAction}    ACTION    ${campaignAction}
    Select From Dropdown Item    ${eleCortecaAdminCampaignApplicationAddNewRuleActionClick}    ${actionSelector}

Select Network Devices
    [Arguments]    ${appHwModel}
    Press Click Element    ${radioBtnHardwareModel}
    FOR    ${model}    IN    @{appHwModel}
        ${modelSelector}    Replace String    ${dropDownItemSelectCampaignApplicationModel}    MODEL    ${model}
        Select From Dropdown Item    ${dropDownItemCampaignApplicationModelClick}    ${modelSelector}
        Sleep    2s
    END

Select From Firmwares
    [Arguments]    ${appFirmwareVersions}    ${fromfirmwareAny}
    Return From Keyword If    ${fromfirmwareAny}
    FOR    ${firmware}    IN    @{appFirmwareVersions}
        ${firmwareSelector}    Replace String    ${dropDownItemSelectCampaignApplicationFirmware}    FIRMWARE    ${firmware}
        Select From Dropdown Item    ${dropDownItemCampaignApplicationFirmwareClick}    ${firmwareSelector}
        Sleep    2s
    END

Select Application Version
    [Arguments]    ${appVersion}
    ${versionSelector}    Replace String    ${dropDownItemSelectCampaignApplicationAppVersion}    VERSION    ${appVersion}
    Select From Dropdown Item    ${dropDownItemCampaignApplicationAppVersionClick}    ${versionSelector}
    Sleep    2s

Get Installed Campaign Count    
    [Arguments]    ${appsList}    ${action}=Install
#    ${appKeys}    Get Dictionary Keys    ${appsList}
    ${appCountDict}    Create Dictionary    
    FOR    ${app}    IN    @{appsList}
#        Log    ${appsList}[${app}]
        Login and Open Campaign Application Page
        ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${app}
        Press Click Element    ${appSelect}
        Sleep    2s
        ${count}    Run Keyword If    '${action}'=='Install' or '${action}'=='Update'    Get Text    ${eleCampaignAppInstallCount}    ELSE IF    '${action}'=='Uninstall'    Get Text    ${eleCampaignAppUninstallCount}
        Set To Dictionary    ${appCountDict}    ${app}=${count}
        Logout From Corteca Console
    END
    Return From Keyword    ${appCountDict}

Get Enabled license Campaign Count
    [Arguments]    ${appsList}
#    ${appKeys}    Get Dictionary Keys    ${appsList}
    ${appLicenseCountDict}    Create Dictionary
    FOR    ${app}    IN    @{appsList}
        ${countLicense}    Get Enabled License Count for App    ${app}
        Set To Dictionary    ${appLicenseCountDict}    ${app}=${countLicense}
    END
    Return From Keyword    ${appLicenseCountDict}

Get Enabled License Count for App
    [Arguments]    ${app}
    Login and Open Campaign Application Page
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${app}
    Press Click Element    ${appSelect}
    Sleep    5s
    ${count}    Get Text    ${eleCampaignAppLicenseCount}
    ${countLicense}    Get Regexp Matches    ${count}    \\d+
    Logout From Corteca Console
    Return From Keyword    ${countLicense}[0]
    
Get App Name To Check    
    [Arguments]    ${appInstalledList}    ${appsListFromUser}    ${action}=Install
    ${emptyStatus}    Run Keyword And Return Status    Should Be Equal As Strings    ${appInstalledList}    []
    ${appPortal}    Run Keyword If    ${emptyStatus}    Create Dictionary    ELSE    Get Dictionary Keys    ${appInstalledList}
    ${appName}    Run Keyword If    '${action}'=='Uninstall'    Evaluate    list(set(${appPortal})^set(${appsListFromUser}))    ELSE    Evaluate    list(set(${appPortal})&set(${appsListFromUser}))
    Return From Keyword    ${appName}

Get Rule Trend Graph
    [Documentation]    keyword to perform rule trend validation for root and extenders
    ...                 Argument:
    ...                    configFileName ->configFile group name
    ...                    rulename->  rule name
    ...                    ruleUsingCSV -> True -> Rule created via csv
    ...                                    False -> Rule created not via csv
    [Arguments]    ${app}    ${ruleName}
    Login and Open Campaign Application Page
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${app}
    Press Click Element    ${appSelect}
    Run Keyword And Ignore Error    Execute Javascript    window.scrollTo(0, 0)
    Wait Until Page Contains    ${ruleName}    timeout=60s
    ${NewRuleTrendSelectClick}    Replace String    ${eleCampaignApplicationRuleTrendSelectClick}    RULE    ${ruleName}
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Element    ${btnCampaignManagerRuleTrend}
    Sleep    15s
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${eleCampaignGraphHighChart}
    Capture Page Screenshot
    ${graphValue}    Fetch SVG Graph Values    ${eleCampaignGraphHighChart}    ${eleCampaignGraphTooltip}
    Log    ${graphValue}
    Logout From Corteca Console
    Return From Keyword    ${graphValue}

Rule Trend Validation Application
    [Arguments]    ${app}    ${rulename}    ${ruleUsingCSV}=${True}    ${extenderCheck}=${False}
    ${graphValue}    Get Rule Trend Graph    ${app}    ${ruleName}
    Log    ${graphValue}
    Run Keyword If    '${ruleUsingCSV}'=='False'    Should Not Be Empty    ${graphValue}
    Run Keyword If    ${ruleUsingCSV}    Rule Trend Validation CSV    ${graphValue}    extenderCheck=${extenderCheck}

Rule Trend Validation CSV
    [Documentation]    keyword to check rule trend validation for root and extenders
    ...                 Argument:
    ...                    graphValue ->Grapgh values; output of 'Fetch SVG Graph Values'
    [Arguments]    ${graphValue}    ${rootCount}=1    ${extenderCheck}=${False}    ${errorCount}=0
    ${errorCount}    Set Variable    0
    ${succesCount}    Set Variable    0
    ${meshNodeCount}    Get Length    ${meshNodes}
    ${errorCount}    Get Match Response Count From Graph    ${graphValue}     .*Error.*
    ${succesCount}    Get Match Response Count From Graph    ${graphValue}    .*Successes.*
    Log Many    ${errorCount}    ${succesCount}
    Run Keyword And Continue On Failure    Should Be Equal As Integers    ${succesCount}    ${rootCount}    msg="Success count not matching with Root count"
    Run Keyword If    ${extenderCheck}    Should Be Equal As Integers    ${errorCount}    ${meshNodeCount}    msg="Error count not matching with extender count"

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
    Return From Keyword

Get Match From Graph
    [Arguments]    ${graphValue}    ${matchString}
    ${matchGrouplen}    Set Variable    0
    FOR    ${value}    IN    @{graphValue}
        Log    ${value}
        Log    ${matchString}
        ${value}    Convert To String    ${value}
        ${matchStringValue}    Get Regexp Matches    ${value}    ${matchString}
        Log    ${matchStringValue}
        ${len}    Get Length    ${matchStringValue}
        Continue For Loop If    ${len}<=0
        ${matchGrouplen}    Get Regexp Matches    ${matchStringValue}[0]    \\d+
        ${matchGrouplen}    Set Variable    ${matchGrouplen}[0]
    END
    Return From Keyword    ${matchGrouplen}

Rule Report Download
    [Documentation]    keyword to perform rule report validation for root and extenders
    ...                 Argument:
    ...                    configFileName ->config file group name
    ...                    rulename->  rule name
    [Arguments]    ${app}    ${ruleName}
    ${pattern}    Set Variable    ${ruleName}*.csv
    Remove Files From User Download Path    ${pattern}
    Login and Open Campaign Application Page
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${app}
    Press Click Element    ${appSelect}
    Run Keyword And Ignore Error    Execute Javascript    window.scrollTo(0, 0)
    Wait Until Page Contains    ${ruleName}
    ${NewRuleTrendSelectClick}    Replace String    ${eleCampaignApplicationRuleTrendSelectClick}    RULE    ${ruleName}
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Element    ${btncampaignManagerReportDownload}
    Sleep    5s
    Capture Page Screenshot
#    ${reportData}    Get Files From User Download Path    ${pattern}
    ${reportData}    Create Dictionary From Rule Report CSV    ${pattern}
    Log    ${reportData}
    Logout From Corteca Console
    Return From Keyword    ${reportData}

Rule Report Validation Application
    [Documentation]    keyword to perform rule report validation for root and extenders
    ...                 Argument:
    ...                    configFileName ->config file group name
    ...                    rulename->  rule name
    [Arguments]    ${app}    ${rulename}    ${ruleUsingCSV}=${True}    ${extenderCheck}=${False}
    ${reportData}    Rule Report Download    ${app}    ${rulename}
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

Campaign Application Teardown
    [Arguments]    ${campaignManagerApplication}    ${appsCampaignRuleDict}    ${action}=Uninstall
    FOR    ${appDetail}    IN    @{campaignManagerApplication}
        ${version}    Set Variable If    '${action}'=='Update'    ${appDetail}[UpdateVersion]    ${appDetail}[AppVersion]
        Run Keyword And Continue On Failure    Run Keyword IF    '${action}'=='Install'    Install Container Application    ${appDetail}[Application]    ${appDetail}[AppVersion]
        Run Keyword And Continue On Failure    Run Keyword IF    '${action}'=='Uninstall'   Uninstall The Application And History Validation    ${appDetail}[Application]    ${appDetail}[AppVersion]
    END
    Log To Console    Removing campaign Rule
    Run Keyword And Continue On Failure    Delete Application Rules   ${appsCampaignRuleDict}

Campaign Application SuiteSetup
    [Arguments]    ${campaignManagerApplication}    ${action}=Uninstall
    FOR    ${appDetail}    IN    @{campaignManagerApplication}
        Run Keyword And Continue On Failure    Run Keyword IF    '${action}'=='Install'    Install Container Application    ${appDetail}[Application]    ${appDetail}[AppVersion]
        Run Keyword And Continue On Failure    Run Keyword IF    '${action}'=='Uninstall'   Uninstall The Application And History Validation    ${appDetail}[Application]    ${appDetail}[AppVersion]
    END

Delete Application Rules    
    [Arguments]    ${appsList}
    ${appKeyList}    Get Dictionary Keys    ${appsList}
    FOR    ${app}    IN    @{appKeyList}
        Delete App Rule    ${app}    ${appsList}[${app}]
    END

Delete App Rule
    [Arguments]    ${appName}    ${ruleName}
    Login and Open Campaign Application Page
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${appName}
    Press Click Element    ${appSelect}
    Wait Until Page Contains    ${ruleName}
    ${NewRuleTrendSelectClick}    Replace String    ${eleCampaignApplicationRuleTrendSelectClick}    RULE    ${ruleName}
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Button     ${btnCampaignManagerNewConfigFileRuleDelete}
    Press Click Button     ${btnCampaignManagerNewConfigFileRuleConfirm}
    Run Keyword And Continue On Failure    Campaign Toaster Validation    Selected rule .*${ruleName} was deleted successfuly.*   timeout=240s
    Capture Page Screenshot
    Page Should Not Contain    ${ruleName}
    Capture Page Screenshot
    Logout From Corteca Console
    
Reboot Root Device
    ${result}   SSHExecute    reboot
    sleep  900s
    Log To Console   After Waiting 900s on reboot verify the USP mqtt connection
    Validate_Process    ${Root}[ip]    ${Root}[telnet_vtysh]

App Deployment Report Validation
    [Arguments]    ${appToCheck}    ${appVersion}    ${macList}    ${uuid}    ${action}=Install
    ${reportData}    App Deployement Report Download    ${appToCheck}
    Log    ${reportData}
    FOR    ${mac}    IN    @{macList}
        ${deviceDetails}    getDeviceDetails    ${mac}
        ${macPresent}    Run Keyword And Return Status    Dictionary Should Contain Key    ${reportData}    ${mac}
        Run Keyword If    '${action}'=='Uninstall'     Should Not Be True    ${macPresent}    msg= Not Expected. ${mac} exist in Deployment Report for action Uninstall
        Return From Keyword If    '${action}'=='Uninstall'
        Should Be True    ${macPresent}    msg= Not Expected. ${mac} Not exist in Deployment Report for action ${action}
        Log    ${reportData}[${mac}]
        Log To Console    Deployment Report Validation
        ${status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${deviceDetails}    uuid
        ${customerId}    Set Variable If    ${status}    ${deviceDetails}[uuid]    ${EMPTY}
        Run Keyword And Continue On Failure    Should Match Regexp    ${reportData}[${mac}][Version]    ${appVersion}
        Run Keyword And Continue On Failure    Should Match Regexp    ${reportData}[${mac}][UUID]    ${uuid}
        Run Keyword And Continue On Failure    Should Match Regexp    ${reportData}[${mac}]["Firmware version"]    ${deviceDetails}[version]
        Run Keyword And Continue On Failure    Should Match Regexp    ${reportData}[${mac}]["Model Name"]    ${deviceDetails}[model]
        Run Keyword And Continue On Failure    Should Match Regexp    ${reportData}[${mac}]["Tenant ID"]    ${cloudDetail}[tenant_name]
        Run Keyword And Continue On Failure    Deployment Report TimeStamp Validation    ${reportData}[${mac}]["Installed time"]    ${appToCheck}
        Run Keyword And Continue On Failure    Should Match Regexp    ${reportData}[${mac}]["Customer ID"]    ${customerId}
    END

Deployment Report TimeStamp Validation
    [Arguments]    ${depoymentReportTimestamp}    ${appToCheck}
    ${deploymentReporttime}    Convert Date    ${depoymentReportTimestamp.strip()}    result_format=%Y-%m-%d %H:%M:%S    date_format=%Y-%m-%dT%H:%M:%SZ
    Log    ${deploymentReporttime}
    ${deploymentReportISTTime}    Add Time To Date    ${deploymentReporttime}    5 hours 30 minutes

    # Format the IST time to desired format
    ${formatteddeploymentReportISTTime}    Convert Date    ${deploymentReportISTTime}    result_format=%Y-%m-%d %H:%M:%S
    Log    IST Time: ${formatteddeploymentReportISTTime}
    
    Open Application From Portal
    Sleep    ${sleepMax}
    ${versionEvent}    Get Text    ${eleApplicationEventTableRow1}
    ${historytime}    Fetch From Left    ${versionEvent}    ${appToCheck}
    ${getYear}    Get Current Date    result_format=%Y
    ${historytime}    Set Variable    ${getYear} ${historytime}
    ${historyIsttimePortal}    Convert Date    ${historytime.strip()}    result_format=%Y-%m-%d %H:%M:%S    date_format=%Y %b %d, %I:%M %p
    ${deploymentReportISTTime}    Set Variable    ${formatteddeploymentReportISTTime}[:16]
    ${historyISTTime}    Set Variable    ${historyIsttimePortal}[:16]
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${deploymentReportISTTime}    ${historyISTTime}
    Logout From Corteca Console

App Deployement Report Download
    [Arguments]    ${appToCheck}
    ${pattern}    Set Variable    app_report*.csv
    Remove Files From User Download Path    ${pattern}
    Login To Corteca Console
    Open Corteca Console Admin Page    pageCheckText=Deployment reports    tabSelection=DeploymentReport
    Capture Page Screenshot
    ${appDeploymentReport}    Replace String    ${eleAppDeploymentReportDownload}    APPS    ${appToCheck}
    Select From Dropdown Item Deployment    ${eleAppDeploymentReportDownloadClick}    ${appDeploymentReport}
    Sleep    5s
    Capture Page Screenshot
    Press Click Element    ${eleAppDeploymentReportDownloadFile}
    Wait Until Page Contains    Success
    ${reportData}    Get Files From User Download Path    ${pattern}    DictKeyIndex=4
    Log    ${reportData}
    Logout From Corteca Console
    Return From Keyword    ${reportData}

Select From Dropdown Item deployment
    [Documentation]    This function used to select the dropdow item
    ...                - Arguments:
    ...                    dropDownClickSelector-> locator of the dropdown click
    ...                    dropDownItemSelect -> locator for the dropdown item select
    [Arguments]    ${dropDownClickSelector}    ${dropDownItemSelect}
    Mouse Over    ${dropDownClickSelector}
    Click Element    ${dropDownClickSelector}
    Scroll Element Into View    xpath=//footer
    Sleep    5s
    Mouse Down    ${dropDownItemSelect}
    Click Element    ${dropDownItemSelect}
    Sleep    2s

Functionality Validation For Fsecure    
    [Arguments]    ${macList}    ${action}=Install
    Log To Console    "Sleeping 300s for FSecure Fuctionality Check"
    Sleep    300s
    FOR    ${mac}    IN    @{macList}
        Log To Console    "Router ID validation after 300s for mac ${mac}"
        ${statusAPI}    Run Keyword And Return Status    getSecureSubscription    ${mac}
        Run Keyword If    '${action}'=='Uninstall'    Should Be Equal As Strings    ${statusAPI}    False
        Return From Keyword If    '${action}'=='Uninstall'
        ${fsecureDetails}    getSecureSubscription    ${mac}
        Log To Console    ${fsecureDetails}[data][routers]
        Run Keyword And Continue On Failure    Should Not Be Empty    ${fsecureDetails}[data][routers]    msg=Expecting Router Key in the api respose. But got as empty
    END


Campaign Applications Operation Rule Validation
    [Arguments]    ${appsList}    ${downloadDuration}    ${campaignManagerApplication}    ${runningStatus}=${True}    ${autostartStatus}=${True}    ${appStatus}=${containerStatusEnable}    ${autoStart}=${containerAutostartEnable}    ${extenderCheck}=${False}    ${reboot}=${False}    ${csvBasedValidation}=${True}    ${action}=Install    ${ruleDisable}=${False}

    ${appsListFromUser}    Get Dictionary Keys    ${appsList}
    ${loopCount}    Evaluate    ${downloadDuration}*4
    Log    Rule Validation for the Apps mentioned by user
    FOR    ${iterateLoop}    IN RANGE    0    ${loopCount}
        Log To Console    "Checking values of license count and install/uninstall count for the apps before schedule"
        ${campaignInstalledCountBeforeInstallUninstall}    Get Installed Campaign Count    ${appsListFromUser}    ${action}
        ${campaignEnabledlicenseCountBeforeInstallUninstall}    Get Enabled license Campaign Count    ${appsListFromUser}
        Log Many    ${campaignInstalledCountBeforeInstallUninstall}    ${campaignEnabledlicenseCountBeforeInstallUninstall}
        ${getSleepCount}    Get The Next Quad Wait Time
        ${sleepTime}    Evaluate    ${getSleepCount}+420
        Run Keyword If    '${reboot}'=='False'    Log To Console    "Wait until next schedule triggered ${getSleepCount} + 7 min extra"
        Run Keyword If    '${reboot}'=='False'    Sleep    ${sleepTime}

        Run Keyword If    ${reboot}    Log To Console    "Triggering Reboot"
        Run Keyword If    ${reboot}    Reboot Root Device

        Run Keyword If    ${reboot}    Sleep    180s

        Log To Console    "Resuming validation after waiting for campaign trigger"
        ${systemTime}    Get Device Time In Epoch
        ${appInstalledList}    Get Installed App From Portal

        ${appVersion}    Set Variable    ''
        ${appToCheckList}    Get App Name To Check    ${appInstalledList}    ${appsListFromUser}    ${action}
        Log    Rule Validation for the App
        FOR    ${appToCheck}    IN    @{appToCheckList}
            FOR    ${appDetail}    IN    @{campaignManagerApplication}
                Continue For Loop If    '${appDetail}[Application]'!='${appToCheck}'
                ${appVersion}    Set Variable If    '${action}'=='Update'    ${appDetail}[UpdateVersion]    ${appDetail}[AppVersion]
                ${macList}    Set Variable    ${appDetail}[HwMacs]
                ${appuuid}    Set Variable    ${appDetail}[appUuid]
                Exit For Loop If    '${appVersion}'!=''
            END
            
            ${statusUpdate}    Run Keyword And Return Status    Should Be Equal As Strings    ${appVersion}    ${EMPTY}

            Continue For Loop If    ${statusUpdate}
            # waiting 1 min to make sure app installation completed properly
            Run Keyword If    '${action}'!='Uninstall'    Sleep    60s
            
        #Run Keyword If    ${csvBasedValidation}    App Install Validation CSV    ${appToCheck}    ${appVersion}    ${runningStatus}    ${autostartStatus}     ${appStatus}    ${autoStart}    ${systemTime}    ${appsList}

            Log To Console    **** Verify Application Portal for ${action} ****
            Run Keyword And Continue On Failure    Application Portal Validation    ${macList}    ${appToCheck}    ${appVersion}    ${action}

            Log To Console    **** Verify Trends chart for ${appToCheck} ****
            Run Keyword And Continue On Failure    Rule Trend Validation Application    ${appToCheck}    ${appsList}[${appToCheck}]
            Log To Console    **** Verify Rule Report for ${appToCheck} ****
            Run Keyword And Continue On Failure    Rule Report Validation Application    ${appToCheck}    ${appsList}[${appToCheck}]

            ${campaignInstalledCountAfterInstallUninstall}    Get Installed Campaign Count    ${appsListFromUser}    ${action}
            ${campaignEnabledlicenseCountAfterInstallUninstall}    Get Enabled license Campaign Count    ${appsListFromUser}
            Log Many    ${campaignInstalledCountAfterInstallUninstall}    ${campaignEnabledlicenseCountAfterInstallUninstall}


            Run Keyword And Continue On Failure    License And Install/Uninstall Count    ${campaignInstalledCountBeforeInstallUninstall}[${appToCheck}]    ${campaignEnabledlicenseCountBeforeInstallUninstall}[${appToCheck}]    ${campaignInstalledCountAfterInstallUninstall}[${appToCheck}]    ${campaignEnabledlicenseCountAfterInstallUninstall}[${appToCheck}]    ${action}

            Log To Console    **** Verify deployment Report ****
            Run Keyword And Continue On Failure    App Deployment Report Validation    ${appToCheck}    ${appVersion}    ${macList}    ${appuuid}    ${action}

            Run Keyword If    '${appToCheck}'=='F-Secure Sense'    Functionality Validation For Fsecure    ${macList}    ${action}
            Run Keyword If    '${appToCheck}'=='Nokia Fingerprint'    Functionality Validation For Nokia Fingerprint    ${macList}    ${action}

            Remove Values From List    ${appsListFromUser}    ${appToCheck}
            Log    ${appsListFromUser}
        END
        ${appListEmptyCheck}    Get Length    ${appsListFromUser}
        Exit For Loop If    '${appListEmptyCheck}'=='0'
    END
    Run Keyword And Continue On Failure    Should Be Empty    ${appsListFromUser}
    ${appInstalledList}    Get Installed App From Portal
    Log    ${appInstalledList}
    Run Keyword If    '${action}'=='Uninstall'    Should Be Equal As Strings    ${appInstalledList}    []
    Return From Keyword If    '${action}'=='Uninstall'
    ${appsListFromPortal}    Get Dictionary Keys    ${appInstalledList}
    ${appsListExpected}    Get Dictionary Keys    ${appsList}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${appsListFromPortal}    ${appsListExpected}

Install Application via portal
    [Arguments]    ${campaignManagerApplication}
    Log To Console    Installing apps from portal  
    FOR    ${appDetail}    IN    @{campaignManagerApplication}
        Log    **** 1: Install the fingerprinting app
        Run Keyword And Ignore Error    Install Container Application    ${app}    ${appDetail}[AppVersion]
    END

Functionality Validation For Nokia Fingerprint
    [Arguments]    ${macList}    ${action}=Install
    FOR    ${mac}    IN    @{macList}
        ${searchString}    Replace String    ${FingerPrintKibanaValidation}    MAC    ${mac}
        Log To Console    FP functionality check
        ${logData}    Fetch The Kibana Logs    ${searchString}
        Log    ${logData}
        Should Not Be Equal As Strings    ${logData}    None    No match found in kibana for ${searchString}
        ${keyVal}   Get Regexp Matches    ${logData}    param=Key, value=([^,)]*)
        ${keyVal}    Fetch From Right    ${keyVal}[0]    value=
        Run Keyword If    '${action}'=='Uninstall'    Should Be Equal As Strings    ${keyVal}    ${EMPTY}    ELSE    Should Match Regexp    ${keyVal}    \\w+
    END


License And Install/Uninstall Count
    [Arguments]    ${BeforeInstallUninstallCount}    ${BeforeEnabledlicenseCount}    ${AfterInstallUninstallCount}    ${AfterEnabledlicenseCount}    ${action}    ${installCountIncrement}=${installCountIncrement}
    Log To Console    **** Verify ${action} count ****
    Run Keyword If    '${action}'=='Idle' or '${action}'=='Active' or '${action}'=='Update'    Should Be Equal As Strings    ${AfterInstallUninstallCount}    ${BeforeInstallUninstallCount}
    Run Keyword If    '${action}'=='Idle' or '${action}'=='Active' or '${action}'=='Update'    Should Be Equal As Strings    ${BeforeEnabledlicenseCount}    ${AfterEnabledlicenseCount}
    Return From Keyword If    '${action}'=='Idle' or '${action}'=='Active' or '${action}'=='Update'
#    ${installUninstallCompare}    Run Keyword If    '${action}'=='Install'    Evaluate    int(${BeforeInstallUninstallCount})+${installCountIncrement}    ELSE IF    '${action}'=='Uninstall'    Evaluate    int(${BeforeInstallUninstallCount})+${installCountIncrement}
#    Log To Console    **** Verify Enabled license Count after ${action} ****
#    Run Keyword If    '${action}'=='Update'    Should Be Equal As Strings    ${AfterEnabledlicenseCount}    ${BeforeEnabledlicenseCount}
#    Run Keyword If    '${action}'=='Update'    Should Be Equal As Strings    ${AfterEnabledlicenseCount}    ${BeforeEnabledlicenseCount}
#    Return From Keyword If    '${action}'=='Update'
    ${installUninstallCompare}    Evaluate    int(${BeforeInstallUninstallCount})+${installCountIncrement}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${AfterInstallUninstallCount}    ${installUninstallCompare}
    ${licenseCountCompare}    Run Keyword If    '${action}'=='Install'    Evaluate    int(${BeforeEnabledlicenseCount})+${installCountIncrement}    ELSE IF    '${action}'=='Uninstall'    Evaluate    int(${BeforeEnabledlicenseCount})-${installCountIncrement}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${AfterEnabledlicenseCount}    ${licenseCountCompare}

Validate Update Application From Portal And History Validation
    [Arguments]    ${macList}    ${appToCheck}    ${appVersion}    ${runningStatus}    ${autostartStatus}
    FOR    ${mac}    IN    @{macList}
        Open Application From Portal    ${mac}
        Log    **** Open application tab and verify the installed apps
        Open Application From Portal
        Sleep    ${sleepMax}
        ${appList}    Get Installed Application List From Portal
        Log    ${appList}
        Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appToCheck}][Name]    ${appToCheck}
        Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appToCheck}][Version]    ${appVersion}
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${appList}[${appToCheck}][Running]    ${runningStatus}
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${appList}[${appToCheck}][Autostart]    ${autostartStatus}
        Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appToCheck}][Remove]    close-icon
        ${activeEvent}    Get Text    ${eleApplicationEventTableRow1}
        Run Keyword And Continue On Failure    Should Match Regexp    ${activeEvent}    .*${appToCheck}.*Installation update.*${appVersion}.*successful
        Logout From Corteca Console
    END

Validate ActiveIdle Status From Portal And History Validation
    [Arguments]    ${macList}    ${appToCheck}    ${appVersion}    ${runningStatus}    ${autostartStatus}    ${enableDisable}=idle
    FOR    ${mac}    IN    @{macList}
        Open Application From Portal    ${mac}
        Log    **** Open application tab and verify the installed apps
        Open Application From Portal
        Sleep    ${sleepMax}
        ${appList}    Get Installed Application List From Portal
        Log    ${appList}
        Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appToCheck}][Name]    ${appToCheck}
        Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appToCheck}][Version]    ${appVersion}
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${appList}[${appToCheck}][Running]    ${runningStatus}
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${appList}[${appToCheck}][Autostart]    ${autostartStatus}
        Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appToCheck}][Remove]    close-icon
        ${activeEvent}    Get Text    ${eleApplicationEventTableRow1}
        Run Keyword And Continue On Failure    Should Match Regexp    ${activeEvent}    .*${appToCheck}.*Status.*update.*(${enableDisable}).*successful
        Logout From Corteca Console
    END

Application Portal Validation
    [Arguments]    ${macList}    ${appName}    ${appVersion}    ${action}
        Run Keyword If    '${action}'=='Install'    Validate Installed Application From Portal And History Validation    ${macList}    ${appName}    ${appVersion}    True    True    historyTimeValidation=${False}
        Run Keyword If    '${action}'=='Uninstall'    Validate Uninstalled Application From Portal And History Validation    ${macList}    ${appName}    ${appVersion}
        Run Keyword If    '${action}'=='Update'    Validate Update Application From Portal And History Validation    ${macList}    ${appName}    ${appVersion}    True    True
        Run Keyword If    '${action}'=='Active'    Validate ActiveIdle Status From Portal And History Validation    ${macList}    ${appName}    ${appVersion}    True    True    enableDisable=active
        Run Keyword If    '${action}'=='Idle'    Validate ActiveIdle Status From Portal And History Validation    ${macList}    ${appName}    ${appVersion}    False    True

Get Installed App From Portal
    Open Application From Portal
    Sleep    ${sleepMax}
    ${appInstalledList}    Get Installed Application List From Portal
    Log    ${appInstalledList}
    Logout From Corteca Console
    Return From Keyword    ${appInstalledList}

EnableDisable The Campaign Rule
    [Arguments]    ${appName}    ${ruleName}    ${status}
    Login and Open Campaign Application Page
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${appName}
    Press Click Element    ${appSelect}
    Wait Until Page Contains    ${ruleName}
    ${index}    Execute Javascript    s=document.querySelectorAll("app-list li").length;return s;
    FOR    ${i}    IN RANGE    1    ${index}+1
        ${i}    Convert To String    ${i}
        ${ruleEnableDisable}    Replace String    ${applistIndex}    INDEX    ${i}
        ${liName}    Get Text    ${ruleEnableDisable}
#        Continue For Loop If    '${liName.strip()}'!='${appName.strip()}'
        Continue For Loop If    '${liName.strip()}'!='${ruleName.strip()}'
        ${ruleEnableDisable}    Replace String    ${toggleCampaignManagerAppRuleEnableDisable}    INDEX    ${i}
        ${ruleEnableDisableClick}    Replace String    ${toggleCampaignManagerAppRuleEnableDisableClick}    INDEX    ${i}
        Cron Tab Toggle    ${ruleEnableDisable}    ${ruleEnableDisableClick}    ${status}
    END
    Logout From Corteca Console

Edit Created Rule
    [Arguments]    ${application}    ${ruleName}    ${newRuleName}    ${sheduleHr}    ${scheduleRetry}
    Login and Open Campaign Application Page
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${application}
    Press Click Element    ${appSelect}
    Wait Until Page Contains    ${ruleName}
    ${NewRuleTrendSelectClick}    Replace String    ${eleCampaignApplicationRuleTrendSelectClick}    RULE    ${ruleName}
    Press Click Element    ${NewRuleTrendSelectClick}
    Press Click Element    ${btncampaignManagerEdit}
    Enter Value    ${eleCampaignManagerNewConfigFileAddRuleName}    ${newRuleName}
    Log To Console    Validate the schedule change
    Create Schedule For Download    Day    ${sheduleHr}    ${scheduleRetry}
	Press Click Element    ${eleCampaignManagerRuleSave}
	Wait Until Page Contains    Selected rule ${newRuleName} is successfully changed.    timeout=30s
	Capture Page Screenshot
	Run Keyword And Continue On Failure    Page Should Contain    Selected rule ${newRuleName} is successfully changed.
	${status}    Run Keyword And Return Status    Page Should Contain    ${newRuleName}
	Run Keyword And Ignore Error    Execute Javascript    ${closeToaster}
	Should Be True    ${status}    msg="Schedule change is failed"