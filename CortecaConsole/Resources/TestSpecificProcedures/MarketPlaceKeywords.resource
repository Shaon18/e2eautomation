*** Settings ***
Library     SeleniumLibrary
Library     Process
Library         RequestsLibrary
Variables       ../../InputFiles/EnvironmentInput.py
Variables       ../../InputFiles/Apirequest.py
Library         String
Library         JSONLibrary
Resource        ../KeywordDefinition/ApiRequest.resource
Resource        ../keywordDefinition/CommonKeywords.robot
Variables    ../../Locators/CortecaConsoleLocators.py
Variables    ../../Locators/CorteacaMarketPlaceLocators.py
Variables    ../../Locators/CortecaConsoleAdminLocators.py
Resource   ../TestSpecificProcedures/CampaignManager/CampaignManagerApplicationKeyword.robot

*** Keywords ***
Put New Tenant Json
    [Arguments]    ${tenantId}    ${uuidApp}    ${key}    ${scope}    ${max_allowed}    ${emailId}=${MarketPlace}[gmailId]
    ${jsonGet}    getTenantInfo
    ${updated_json}    Generate New Tenant Json    ${jsonGet}    ${tenantId}    ${uuidApp}    ${key}    ${scope}    ${max_allowed}    ${emailId}
    Log    ${updated_json}
    putTenantInfo    ${updated_json}
    ${jsonGet}    getTenantInfo
    Log    ${jsonGet}

Get Tenant Array
    [Arguments]    ${inputJson}    ${tenantId}
     ${tenantData}    Create Dictionary
     FOR    ${items}    IN    @{inputJson}
         Log    ${items}
         ${id}=    Get From Dictionary    ${items}    id
         IF    '${id}' == '${tenantId}'
            ${tenantData}    Copy Dictionary    ${items}
         END
     END
     Return From Keyword    ${tenantData}

Generate New Tenant Json
    [Arguments]    ${inputJson}    ${tenantId}    ${expectedUuid}    ${key}    ${scope}    ${max_installation}    ${emailNew}
    ${tenantData}    Get Tenant Array    ${inputJson}    ${tenantId}
    ${apps}=    Get From Dictionary    ${tenantData}    apps
    FOR    ${app}    IN    @{apps}
        ${uuid}=    Get From Dictionary    ${app}    uuid
        IF    '${uuid}' == '${expectedUuid}'
            Set To Dictionary    ${app}    scope=${scope}
            Set To Dictionary    ${app}    max_installation=${max_installation}
            Remove From Dictionary    ${app}    created_at
            Remove From Dictionary    ${app}    current_status
            Remove From Dictionary    ${app}    current_state
        END
    END
    # Add new email to email_list
    ${email_list}=    Get From Dictionary    ${tenantData}    email_list
    ${status}    Run Keyword And Return Status    List Should Not Contain Value    ${email_list}    ${emailNew}
    Run Keyword If    ${status}    Append To List    ${email_list}    ${emailNew}
    Set To Dictionary    ${tenantData}    email_list=${email_list}
    # Update key
    Set To Dictionary    ${tenantData}    key=${key}
    Return From Keyword    ${tenantData}
      
#Generate New Tenant Json
#    [Arguments]    ${inputJson}    ${tenantId}    ${expectedUuid}    ${key}    ${scope}    ${max_installation}    ${emailNew}
#     ${item}    Create Dictionary
#     FOR    ${items}    IN    @{inputJson}
#         Log    ${items}
#         ${id}=    Get From Dictionary    ${items}    id
#         IF    '${id}' == '${tenantId}'
#            ${item}    Copy Dictionary    ${items}
#            ${apps}=    Get From Dictionary    ${item}    apps
#            FOR    ${app}    IN    @{apps}
#                ${uuid}=    Get From Dictionary    ${app}    uuid
#                IF    '${uuid}' == '${expectedUuid}'
#                    Set To Dictionary    ${app}    scope=${scope}
#                    Set To Dictionary    ${app}    max_installation=${max_installation}
#                    Remove From Dictionary    ${app}    created_at
#                    Remove From Dictionary    ${app}    current_status
#                    Remove From Dictionary    ${app}    current_state
#                END
#            END
#            # Add new email to email_list
#            ${email_list}=    Get From Dictionary    ${item}    email_list
#            ${status}    Run Keyword And Return Status    List Should Not Contain Value    ${email_list}    ${emailNew}
#            Run Keyword If    ${status}    Append To List    ${email_list}    ${emailNew}
#            Set To Dictionary    ${item}    email_list=${email_list}
#            # Update key
#            Set To Dictionary    ${item}    key=${key}
#        END
#     END
#    Return From Keyword    ${item}



Open Market Place Portal
    [Arguments]    ${url}=${marketPlace}[cloudUrl]    ${uname}=${marketPlace}[uname]    ${password}=${marketPlace}[cloudPasssword]
    Login To Corteca Console    url=${url}    username=${uname}    paswd=${password}
    Press Click Element    ${eleCortecaMarketPlace}
    Wait Until Page Contains    Corteca Marketplace
    
Purchase App From Market Place
    [Arguments]    ${application}    ${workflow}    ${scope}    ${rulename}    ${csvFile}    ${MarketPlaceAndCampaignAppDict}=${MarketPlaceAndCampaignDictForTrial}
    [Teardown]    Close All Browsers
    Open Market Place Portal
    ${appPurchaseStatus}    Replace String    ${eleCortecaMarketPlaceAppPurchaseStatus}    APPSELECT    ${application}
    Scroll Element Into View    ${appPurchaseStatus}
    ${purchaseText}    Get Text    ${appPurchaseStatus}
    All Apps Page Purchase Status Check    ${workflow}    ${scope}    ${purchaseText}
    Run Keyword If    '${workflow}'=='Trial'    Purchase App For Trial    ${application}    ${rulename}    ${csvFile}    ${MarketPlaceAndCampaignAppDict}
    Run Keyword If    '${workflow}'=='Offline'    Purchase App For Offline    ${application}
    Run Keyword If    '${workflow}'=='Online'    Purchase App For Trial    ${application}    ${rulename}    ${csvFile}    ${MarketPlaceAndCampaignAppDict}

All Apps Page Purchase Status Check
    [Arguments]    ${workflow}    ${scope}    ${purchaseText}
    Run Keyword If    '${workflow}'=='Trial' and '${scope}'=='Install'    Should Be Equal As Strings    ${purchaseText}    Trial
    Run Keyword If    '${workflow}'=='Trial' and '${scope}'=='View'    Should Be Equal As Strings    ${purchaseText}    ${Empty}
    Run Keyword If    '${workflow}'=='Offline' and '${scope}'=='Install'    Should Be Equal As Strings    ${purchaseText}    Activated
    Run Keyword If    '${workflow}'=='Offline' and '${scope}'=='View'    Should Be Equal As Strings    ${purchaseText}    ${Empty}
    Run Keyword If    '${workflow}'=='Online' and '${scope}'=='Install'    Should Be Equal As Strings    ${purchaseText}    Activated
    Run Keyword If    '${workflow}'=='Online' and '${scope}'=='View'    Should Be Equal As Strings    ${purchaseText}    ${Empty}

Purchase App For Trial
    [Arguments]    ${application}    ${rulename}    ${csvFile}    ${MarketPlaceAndCampaignAppDict}=${MarketPlaceAndCampaignDictForTrial}
    ${appSelect}    Replace String    ${eleCortecaMarketPlaceAppSelect}    APPSELECT    ${application}
    Press Click Element    ${appSelect}
    Wait Until Element Is Visible    ${eleCortecaMarketPlaceAppDetailsPage}
    Sleep    2s
    Press Click Element    ${eleCortecaMarketPlaceAppDetailsGet}
    Wait Until Element Is Visible    ${eleCortecaMarketPlaceAppDetailsAgree}    timeout=60s
    Press Click Element    ${eleCortecaMarketPlaceAppDetailsAgree}
    Wait Until Element Is Visible    ${eleCortecaMarketPlaceAppDetailsSuccess}    timeout=60s
    Press Click Element    ${eleCortecaMarketPlaceAppDetailsAvailableApp}    timeout=60s
    Wait Until Page Contains    ${application}    timeout=60s
    Create Application Rule    ${rulename}    Install    ${MarketPlaceAndCampaignAppDict}[HwModel]    ${MarketPlaceAndCampaignAppDict}[FirmwareVersions]    ${MarketPlaceAndCampaignAppDict}[AppVersion]    ${csvFile}    ${MarketPlaceAndCampaignDictForRule}    neg=${False}    errMsg=''    application=${application}    appRuleStatus=True    marketPlace=${True}

Email Validation
    [Arguments]    ${emailId}    ${paswd}    ${textToCheck}    ${tenantID}    ${tenantUser}    ${appName}    ${appUuid}    ${browserUrl}=http://www.gmail.com    ${browser}=${browserOption}    ${emailSubject}=${emailSubjectTrial}
    [Teardown]    Close Browser
    Open Portal   ${browserUrl}    ${browser}
    Wait Until Element Is Visible    ${eleEmailInput}
    Enter Value    ${eleEmailInput}   ${emailId}
    Press Click Button    ${eleNextBtn}
    Wait Until Element Is Visible    ${eleEmailPaswd}
    Enter Value    ${eleEmailPaswd}   ${paswd}
    Press Click Button    ${elePaswdNextBtn}
    ${bodySelector}    Replace String    ${eleEmailBodyClick}    SUBJECT    ${emailSubject}
    Wait Until Element Is Visible    ${bodySelector}    timeout=10s
    Scroll Element Into View    ${bodySelector}
    Sleep    2s
    Press Click Element    ${bodySelector}
    Capture Page Screenshot        
    Run Keyword And Continue On Failure    Page Should Contain    ${textToCheck}
    Run Keyword And Continue On Failure    Page Should Contain    App Name: ${appName}
    Run Keyword And Continue On Failure    Page Should Contain    App UUID: ${appUuid}
    Run Keyword And Continue On Failure    Page Should Contain    Tenant ID: ${tenantID}
    Run Keyword And Continue On Failure    Page Should Contain    User:  ${tenantUser}

Validate TenantInfo After Purchase
    [Arguments]    ${tenantId}    ${expectedUuid}    ${scope}    ${maxInstallation}    ${currentState}    ${currentStatus}
    ${jsonGet}    getTenantInfo
    ${tenantData}    Get Tenant Array    ${jsonGet}    ${tenantId}
    ${apps}=    Get From Dictionary    ${tenantData}    apps
    FOR    ${app}    IN    @{apps}
        ${uuid}=    Get From Dictionary    ${app}    uuid
        IF    '${uuid}' == '${expectedUuid}'
            Log    ${app}
            Run Keyword And Continue On Failure    Should Be Equal As Strings    ${app}[scope]    ${scope}
            Run Keyword And Continue On Failure    Should Be Equal As Strings    ${app}[max_installation]    ${maxInstallation}
            Run Keyword And Continue On Failure    Should Be Equal As Strings    ${app}[current_state]    ${currentState}
            Run Keyword And Continue On Failure    Should Be Equal As Strings    ${app}[current_status]    ${currentStatus}
        END
    END

App Status From Market Place
    [Arguments]    ${application}    ${workflow}    ${scope}    ${purchaseText}
    [Teardown]    Close All Browsers
    Open Market Place Portal
    ${appPurchaseStatus}    Replace String    ${eleCortecaMarketPlaceAppPurchaseStatus}    APPSELECT    ${application}
    Wait Until Element Is Visible    ${appPurchaseStatus}    timeout=60s
    Scroll Element Into View    ${appPurchaseStatus}
    ${purchaseText}    Get Text    ${appPurchaseStatus}
    All Apps Page Purchase Status Check    ${workflow}    ${scope}    ${purchaseText}
    ${appSelect}    Replace String    ${eleCortecaMarketPlaceAppSelect}    APPSELECT    ${application}
    Press Click Element    ${appSelect}
    Wait Until Element Is Visible    ${eleCortecaMarketPlaceAppDetailsPage}
    Sleep    2s
    ${detailsPageStatus}    Get Text    ${eleCortecaMarketPlaceAppDetailsStatus}
    Should Match Regexp    ${detailsPageStatus}    ${purchaseText}

Setting Succes And Error Count
    [Arguments]    ${macsLength}
    #calculating success and error count
    ${successCount}    Set Variable    ${macsLength}
    ${ErrorCount}    Set Variable    0
    Return From Keyword    ${successCount}    ${ErrorCount}


Validate App Installation Trial
    [Arguments]    ${appName}    ${rulename}    ${maxAllowed}    ${MarketPlaceAppDict}=${MarketPlaceAndCampaignDictForTrial}
    ${appsList}    Create List    ${appName}
    ${action}    Set Variable    Install
    ${existingInstallCount}    Get Enabled License Count for App    ${appName}
    ${maxAllowed}    Evaluate    ${maxAllowed}-${existingInstallCount}
    #calculating success and error count
    ${macsLength}    Get Length    ${MarketPlaceAppDict}[HwMacs]
    ${successCount}    Run Keyword If    ${maxAllowed}<=${macsLength}    Set Variable    ${maxAllowed}
    ...    ELSE IF    ${maxAllowed}>${macsLength}    Set Variable    ${macsLength}
    ${ErrorCount}    Run Keyword If    ${maxAllowed}>=${macsLength}    Set Variable    0    ELSE    Evaluate    ${macsLength}-${maxAllowed}
    
    Validate Campaign Rule    ${appsList}    ${action}    ${successCount}    ${ErrorCount}    ${appName}    ${ruleName}    ${MarketPlaceAppDict}
#    Log To Console    "Checking values of license count and install/uninstall count for the apps before schedule"
#    ${campaignInstalledCountBeforeInstallUninstall}    Get Installed Campaign Count    ${appsList}    ${action}
#    ${campaignEnabledlicenseCountBeforeInstallUninstall}    Get Enabled license Campaign Count    ${appsList}
#    Log Many    ${campaignInstalledCountBeforeInstallUninstall}    ${campaignEnabledlicenseCountBeforeInstallUninstall}
#
#    ${getSleepCount}    Get The Next Quad Wait Time
#    ${sleepTime}    Evaluate    ${getSleepCount}+420
#    Sleep    ${getSleepCount}
#
#    Run Keyword And Continue On Failure    Rule Trend Graph Validation     ${appName}    ${ruleName}    ${successCount}    ${ErrorCount}
#    Run Keyword And Continue On Failure    Rule Report Validation    ${appName}    ${rulename}    ${MarketPlaceAppDict}[HwMacs]    ${successCount}    ${ErrorCount}
#    Run Keyword And Continue On Failure    Application Portal Validation    ${SuccessMacsList}    ${appName}    ${MarketPlaceAppDict}[AppVersion]    Install
#    Run Keyword And Continue On Failure    Validate Portal For Trial Failed Macs    ${ErrorMacsList}    ${appName}
#    Run Keyword And Continue On Failure    App Deployment Report Validation    ${appName}    ${MarketPlaceAppDict}[AppVersion]    ${SuccessMacsList}    ${MarketPlaceAppDict}[appUuid]    Install
#    Run Keyword And Continue On Failure    App Deployment Report Validation    ${appName}    ${MarketPlaceAppDict}[AppVersion]    ${ErrorMacsList}    ${MarketPlaceAppDict}[appUuid]    Uninstall
#
#    ${campaignInstalledCountAfterInstallUninstall}    Get Installed Campaign Count    ${appsList}    ${action}
#    ${campaignEnabledlicenseCountAfterInstallUninstall}    Get Enabled license Campaign Count    ${appsList}
#    Log Many    ${campaignInstalledCountAfterInstallUninstall}    ${campaignEnabledlicenseCountAfterInstallUninstall}
#    Run Keyword And Continue On Failure    License And Install/Uninstall Count    ${campaignInstalledCountBeforeInstallUninstall}[${appName}]    ${campaignEnabledlicenseCountBeforeInstallUninstall}[${appName}]    ${campaignInstalledCountAfterInstallUninstall}[${appName}]    ${campaignEnabledlicenseCountAfterInstallUninstall}[${appName}]    ${action}    installCountIncrement=${successCount}

Rule Trend Graph Validation
    [Arguments]    ${appName}    ${ruleName}    ${successCount}    ${ErrorCount}
    Log To Console    **** Verify Trends chart for ${appName} ****
    ${graphValue}    Get Rule Trend Graph    ${appName}    ${ruleName}
    ${errorCountFromGraph}    Get Match From Graph    ${graphValue}     .*License Error.*Limit reached or permissions not granted.*\\n\\d+
    ${succesCountFromGraph}    Get Match From Graph    ${graphValue}    .*Successes.*\\n\\d+
    Rule Success Failure Count Validation    ${succesCountFromGraph}    ${errorCountFromGraph}    ${successCount}    ${ErrorCount}

Rule Success Failure Count Validation
    [Arguments]    ${succesCountFromGraph}    ${errorCountFromGraph}    ${successCount}    ${ErrorCount}
    Log Many    ${errorCountFromGraph}    ${succesCountFromGraph}
    Run Keyword And Continue On Failure    Should Be True    ${errorCountFromGraph}>=${ErrorCount}    msg="Error count expected ${ErrorCount} not matching"
    Run Keyword And Continue On Failure    Should Be True    ${succesCountFromGraph}>=${successCount}    msg="Success count expected ${successCount} not matching"
#    Run Keyword And Continue On Failure    Should Be Equal As Integers    ${errorCountFromGraph}    ${ErrorCount}    msg="Error count expected ${ErrorCount} not matching"
#    Run Keyword And Continue On Failure    Should Be Equal As Integers    ${succesCountFromGraph}    ${successCount}    msg="Success count expected ${successCount} not matching"

Rule Report Validation
    [Arguments]    ${appName}    ${rulename}    ${macs}    ${successCount}    ${ErrorCount}
    Log To Console    **** Verify Rule Report for ${appName} ****
    ${reportData}    Rule Report Download    ${appName}    ${rulename}
    ${successMacs}    Create List
    ${errorMacs}   Create List
    ${notTriggered}    Create List
    FOR    ${mac}    IN    @{macs}
        ${attempts}    Run Keyword And Return Status    Should Be Empty    ${reportData}[${mac}][Attempts]
        Run Keyword If    ${attempts}    Append To List    ${notTriggered}    ${mac}   
        Continue For Loop If    ${attempts}
        ${matchStringValue}    Run Keyword And Return Status    Should Match Regexp    ${reportData}[${mac}][Attempts][0]    .*License Error.*Limit reached or permissions not granted..*
        Run Keyword If    ${matchStringValue}    Append To List    ${errorMacs}    ${mac}
        ...    ELSE    Append To List    ${successMacs}    ${mac}
    END
    Log Many    ${successMacs}    ${errorMacs}
    Set Test Variable    ${SuccessMacsList}    ${successMacs}
    Set Test Variable    ${ErrorMacsList}    ${errorMacs}
    ${successCountFromPortal}    Get Length    ${successMacs}
    ${ErrorCountFromPortal}    Get Length    ${errorMacs}
    Rule Success Failure Count Validation    ${successCountFromPortal}    ${ErrorCountFromPortal}    ${successCount}    ${ErrorCount}
    
Validate Portal For Trial Failed Macs
    [Arguments]    ${errorMacs}    ${appName}
    Log    **** Open application tab and verify the installed apps
    FOR    ${mac}    IN    @{errorMacs}
        Install Fail Check    ${appName}    ${mac}
        Sleep    2s
    END

Install Fail Check
    [Arguments]    ${appName}    ${mac}
    Open Application From Portal    ${mac}
    Sleep    ${sleepMax}
    ${appList}    Get Installed Application List From Portal
    Log    ${appList}
    ${statusEmpty}    Run Keyword And Return Status    Should Be Equal As Strings    ${appList}    []
    Return From Keyword If    ${statusEmpty}
    ${status}    Run Keyword And Return Status    Should Not Contain    ${appList}    ${appName}
    Should Be True    ${status}
    ${failEvent}    Get Text    ${eleApplicationEventTableRow1}
    Run Keyword And Continue On Failure    Should Match Regexp    ${failEvent}    ${appName}.*Installation.*failed
    Logout From Corteca Console

Purchase App For Offline
    [Arguments]    ${application}    ${MarketPlaceAndCampaignAppDict}=${MarketPlaceAndCampaignDictForTrial}
    ${appSelect}    Replace String    ${eleCortecaMarketPlaceAppSelect}    APPSELECT    ${application}
    Press Click Element    ${appSelect}
    Wait Until Element Is Visible    ${eleCortecaMarketPlaceAppDetailsPage}
    Sleep    2s
    Press Click Element    ${eleCortecaMarketPlaceAppDetailsGet}
    Wait Until Element Is Visible    ${eleCortecaMarketPlaceAppDetailsContactSales}    timeout=60s
    Press Click Element    ${eleCortecaMarketPlaceAppDetailsContactSales}
    Wait Until Element Is Visible    ${eleCortecaMarketPlaceAppDetailsSuccess}    timeout=60s

Generate Tenant Json For App Purchase Complete
    [Arguments]    ${inputJson}    ${tenantId}    ${expectedUuid}    ${key}    ${scope}    ${max_installation}    ${emailNew}
    ${tenantData}    Get Tenant Array    ${inputJson}    ${tenantId}
    Log    ${tenantData}
    ${apps}=    Get From Dictionary    ${tenantData}    apps
    FOR    ${app}    IN    @{apps}
        ${uuid}=    Get From Dictionary    ${app}    uuid
        IF    '${uuid}' == '${expectedUuid}'
            Set To Dictionary    ${app}    scope=${scope}
            Set To Dictionary    ${app}    max_installation=${max_installation}
            Set To Dictionary    ${app}    current_state=PURCHASE_COMPLETED
            Set To Dictionary    ${app}    current_status=COMPLETED
        END
    END
    # Add new email to email_list
    ${email_list}=    Get From Dictionary    ${tenantData}    email_list
    ${status}    Run Keyword And Return Status    List Should Not Contain Value    ${email_list}    ${emailNew}
    Run Keyword If    ${status}    Append To List    ${email_list}    ${emailNew}
    Set To Dictionary    ${tenantData}    email_list=${email_list}
    # Update key
    Set To Dictionary    ${tenantData}    key=${key}
    Return From Keyword    ${tenantData}

Complete Purchase For Apps
    [Arguments]    ${appName}    ${envDetails}=${MarketPlace}    ${appDetails}=${MarketPlaceAndCampaignDictForOffline}
    ${jsonGet}    getTenantInfo
    ${setData}    Generate Tenant Json For App Purchase Complete    ${jsonGet}    ${envDetails}[tenant]    ${appDetails}[appUuid]    ${appDetails}[key]    Install    ${appDetails}[max_allowed]    ${envDetails}[gmailId]
    Log    ${setData}
    putTenantInfo    ${setData}
    ${jsonGet}    getTenantInfo
    Log    ${jsonGet}

Validate Campaign Rule
    [Arguments]     ${appsList}    ${action}    ${successCount}    ${ErrorCount}    ${appName}    ${ruleName}    ${MarketPlaceAppDict}
    Log To Console    "Checking values of license count and install/uninstall count for the apps before schedule"
    ${campaignInstalledCountBeforeInstallUninstall}    Get Installed Campaign Count    ${appsList}    ${action}
    ${campaignEnabledlicenseCountBeforeInstallUninstall}    Get Enabled license Campaign Count    ${appsList}
    Log Many    ${campaignInstalledCountBeforeInstallUninstall}    ${campaignEnabledlicenseCountBeforeInstallUninstall}

    ${getSleepCount}    Get The Next Quad Wait Time
    ${sleepTime}    Evaluate    ${getSleepCount}+540
    Sleep    ${sleepTime}

    Run Keyword And Continue On Failure    Rule Trend Graph Validation     ${appName}    ${ruleName}    ${successCount}    ${ErrorCount}
    Run Keyword And Continue On Failure    Rule Report Validation    ${appName}    ${rulename}    ${MarketPlaceAppDict}[HwMacs]    ${successCount}    ${ErrorCount}
    Run Keyword And Continue On Failure    Application Portal Validation    ${SuccessMacsList}    ${appName}    ${MarketPlaceAppDict}[AppVersion]    Install
    Run Keyword And Continue On Failure    Validate Portal For Trial Failed Macs    ${ErrorMacsList}    ${appName}
    Run Keyword And Continue On Failure    App Deployment Report Validation    ${appName}    ${MarketPlaceAppDict}[AppVersion]    ${SuccessMacsList}    ${MarketPlaceAppDict}[appUuid]    Install
    Run Keyword And Continue On Failure    App Deployment Report Validation    ${appName}    ${MarketPlaceAppDict}[AppVersion]    ${ErrorMacsList}    ${MarketPlaceAppDict}[appUuid]    Uninstall

    ${campaignInstalledCountAfterInstallUninstall}    Get Installed Campaign Count    ${appsList}    ${action}
    ${campaignEnabledlicenseCountAfterInstallUninstall}    Get Enabled license Campaign Count    ${appsList}
    Log Many    ${campaignInstalledCountAfterInstallUninstall}    ${campaignEnabledlicenseCountAfterInstallUninstall}
    Run Keyword And Continue On Failure    License And Install/Uninstall Count    ${campaignInstalledCountBeforeInstallUninstall}[${appName}]    ${campaignEnabledlicenseCountBeforeInstallUninstall}[${appName}]    ${campaignInstalledCountAfterInstallUninstall}[${appName}]    ${campaignEnabledlicenseCountAfterInstallUninstall}[${appName}]    ${action}    installCountIncrement=${successCount}

Validate App Installation For Online Offline Workflow
    [Arguments]    ${appName}    ${rulename}    ${MarketPlaceAppDict}=${MarketPlaceAndCampaignDictForOffline}
    ${appsList}    Create List    ${appName}
    ${action}    Set Variable    Install
    #calculating success and error count
    ${macsLength}    Get Length    ${MarketPlaceAppDict}[HwMacs]
    ${successCount}    Set Variable    ${macsLength}
    ${ErrorCount}    Set Variable    0

    Validate Campaign Rule    ${appsList}    ${action}    ${successCount}    ${ErrorCount}    ${appName}    ${ruleName}    ${MarketPlaceAppDict}

Validate App Installation For Failed Macs    
    [Arguments]    ${SuccessMacsList}    ${ErrorMacsList}    ${appName}    ${appVersion}    ${maxAlowed}
    ${appsList}    Create List    ${appName}
    Log To Console    **** Check Install Failing from Portal as well for failed Macs ****
    FOR    ${mac}    IN    @{ErrorMacsList}
        ${status}    Run Keyword And Return Status    Install Container Application    ${appName}    ${appVersion}    mac=${mac}
        Run Keyword And Continue On Failure    Should Not Be True    ${status}
        Run Keyword And Continue On Failure    Install Fail Check    ${appName}    ${mac}
    END
    Log To Console    **** Uninstall Apps from the portal for success Macs ****
    FOR    ${mac}    IN    @{SuccessMacsList}
        ${status}    Run Keyword And Return Status    Uninstall The Application And History Validation    ${appName}    ${appVersion}    ${mac}
        Run Keyword And Continue On Failure    Should Be True    ${status}
    END

    Log To Console    Wait until license count decrease
    FOR    ${i}    IN RANGE    0    100
        ${licenseCount}    Get Enabled License Count for App    ${appName}
        Exit For Loop If    ${licenseCount}<${maxAlowed}
        Sleep    1s
    END

    Log To Console    **** Check Install Failing from Portal as well for failed Macs After uninstalling apps from success macs ****
    ${campaignInstalledCountBeforeInstallUninstall}    Get Installed Campaign Count    ${appsList}    Install
    ${campaignEnabledlicenseCountBeforeInstallUninstall}    Get Enabled license Campaign Count    ${appsList}
    Log Many    ${campaignInstalledCountBeforeInstallUninstall}    ${campaignEnabledlicenseCountBeforeInstallUninstall}
    ${status}    Run Keyword And Return Status    Install Container Application    ${appName}    ${appVersion}    mac=${ErrorMacsList}[0]
    Run Keyword And Continue On Failure    Should Be True    ${status}
    ${campaignInstalledCountAfterInstallUninstall}    Get Installed Campaign Count    ${appsList}    Install
    ${campaignEnabledlicenseCountAfterInstallUninstall}    Get Enabled license Campaign Count    ${appsList}
    Log Many    ${campaignInstalledCountAfterInstallUninstall}    ${campaignEnabledlicenseCountAfterInstallUninstall}
    Run Keyword And Continue On Failure    License And Install/Uninstall Count    ${campaignInstalledCountBeforeInstallUninstall}[${appName}]    ${campaignEnabledlicenseCountBeforeInstallUninstall}[${appName}]    ${campaignInstalledCountAfterInstallUninstall}[${appName}]    ${campaignEnabledlicenseCountAfterInstallUninstall}[${appName}]    Install    installCountIncrement=1

    ${reportData}    App Deployement Report Download    ${appName}
    Run Keyword And Continue On Failure    Dictionary Should Contain Key    ${reportData}    ${ErrorMacsList}[0]

Marketplace Teardown
    [Arguments]    ${appName}    ${rulename}    ${appVersion}    ${macs}
    Run Keyword And Continue On Failure    Delete App Rule    ${appName}    ${rulename}
    FOR    ${mac}    IN    @{macs}
        Run Keyword And Continue On Failure    Uninstall The Application And History Validation    ${appName}    ${appVersion}    ${mac}
    END
