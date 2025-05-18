*** Settings ***
Library         String
Library         Collections
Library         QWeb
Library         Process
Library         DateTime
Variables       ../../../Locators/keycloak.py
Variables       ../../../Locators/CortecaConsoleLocators.py
Variables       ../../../InputFiles/EnvironmentInput.py
Resource        ../../KeywordDefinition/Qtwebkeywords.resource
Resource        FullAccess.resource
Resource        AdminReadOnly.resource
Resource        ../../KeywordDefinition/Keycloakresources.resource
Resource        ../../KeywordDefinition/ApiRequest.resource
Variables            ../../TestDatas.py



*** Keywords ***


set permission not allowed
    [Arguments]    ${pl}=${payload_fmcadmin}
    Qwebelement.clicktext         Home troubleshooting
    ClickElement    ${subssearch}
    Qwebelement.typetext     ${subMac}    ${subssearch}
    Qwebelement.clicktext    Search
    ClickElement            ${clickfirstresult}
    Sleep    5s
    LogScreenshot
    VerifyText    This account has read-only permissions    20s
    Qwebelement.clicktext    Close
    LogScreenshot
    VerifyAny            Repeat diagnostic,Recommendations   300s
    Click Text         Speed Test      Settings
    Sleep    10s
    LogScreenshot
    VerifyNoText         New speed test       10s
    Get Live Status    ${pl}





Verify corteca elements for careagent readonly
    LogScreenshot
    Verifytext    Home troubleshooting
    Set Permission Not Allowed    ${payload_carereadonly}
    
    
Verify corteca elements for careagent admin
    LogScreenshot
    Verifytext    Home troubleshooting
    VerifyText    WiFi Optimization
    Set Permission Allowed    ${payload_carefullaccess}
    VerifyAny            Repeat diagnostic,Recommendations   300s
    Click Text         Speed Test      Settings
    Sleep    10s
    LogScreenshot
    VerifyText         New speed test       10s
    Qwebelement.clicktext    New speed test
    Run Keyword And Continue On Failure    Check the device is online in L1 and L2
    Move To Page     WiFi Optimization
    Wifi Optmization Check For Fullaccess


set permission allowed
    [Arguments]    ${pl}=${payload_fmcadmin}
    Qwebelement.clicktext         Home troubleshooting
    ClickElement    ${subssearch}
    Qwebelement.typetext     ${subMac}    ${subssearch}
    Qwebelement.clicktext    Search
    ClickElement            ${clickfirstresult}
    Sleep    10s
    LogScreenshot
    VerifyNoText    This account has read-only permissions    20s
    Get Live Status    ${pl}
    
    
get live status
    [Arguments]    ${pay}
    ${online_url}    Set Variable    /station-profiles/networks/${Root}[mac]/member_profiles?page=0&size=200&force=false&refresh=true
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token    ${pay}
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=${NewUser_Credentials1}[X-ServiceType]    Content-Type=${NewUser_Credentials1}[Content-Type]
    ${RetResponse}=    Get On Session       ${session_id}    ${online_url}    headers=${headers}
    Status Should Be    200    ${RetResponse}