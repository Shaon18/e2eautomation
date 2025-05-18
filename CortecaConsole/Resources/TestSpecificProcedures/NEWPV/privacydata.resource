*** Settings ***
Library         String
Library         Collections
Library         QWeb
Library         Process
Library         DateTime
Library         RequestsLibrary
Variables       ../../../Locators/CortecaConsoleLocators.py
Variables       ../../../InputFiles/EnvironmentInput.py
Resource        ../../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../../Resources/KeywordDefinition/Sshkeywords.resource
Resource      ../../../Resources/KeywordDefinition/ApiRequest.resource





*** Keywords ***

put privacy data value
    [Arguments]    ${state}=false
    ${online_url}    Set Variable    https://l1api.stg.homewifi.nokia.com/homehub/networks/${Root}[mac]/privacy_data/status
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}      Content-Type=${NewUser_Credentials1}[Content-Type]
    ${data}=    Set Variable      {"privacy_data_enable": ${state}}
    ${RetResponse}=    Put On Session           ${session_id}    ${online_url}    headers=${headers}     data=${data}
    Run Keyword And Continue On Failure    Status Should Be    200    ${RetResponse}
    
    
    
get privacy data value
    ${online_url}    Set Variable    https://l1api.stg.homewifi.nokia.com/homehub/networks/${Root}[mac]/privacy_data/status
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=${NewUser_Credentials1}[X-ServiceType]    Content-Type=${NewUser_Credentials1}[Content-Type]
    ${result}=    Get On Session           ${session_id}    ${online_url}    headers=${headers}
    ${re}    Set Variable    ${result.json()}[privacy_data_enable]
    RETURN    ${re}



set true
     Put Privacy Data Value    true
     ${r1}    Get Privacy Data Value
     Run Keyword And Continue On Failure    Should Be Equal As Strings        ${r1}    True
     ${result1}    SSHExecute    obuspa -c show database
     FOR  ${i}   IN RANGE    1    10
        Run Keyword And Continue On Failure    Should Contain    ${result1}    Device.LocalAgent.Subscription.${i}
     END


set data false
    Put Privacy Data Value    true
    ${result}    SSHExecute    obuspa -c show database
    FOR  ${i}   IN RANGE    1    10
        Run Keyword And Continue On Failure    Should Contain    ${result}    Device.LocalAgent.Subscription.${i}
    END
    ${r}    Get Privacy Data Value
    Run Keyword And Continue On Failure    Run Keyword If    '${r}' == 'False'    Fail
    Put Privacy Data Value    false
     ${r1}    Get Privacy Data Value
    Run Keyword And Continue On Failure    Should Be Equal As Strings        ${r1}    False
    ${result1}    SSHExecute    obuspa -c show database
    Run Keyword And Continue On Failure    Should Not Contain    ${result1}    Device.LocalAgent.Subscription.2
    Support Session Enabled    False


set data true when false
    Set Data False
    ${r}    Get Privacy Data Value
    ${result}    SSHExecute    obuspa -c show database
    Should Not Contain    ${result}    Device.LocalAgent.Subscription.2
    Run Keyword If    '${r}' == 'False'    Set True


support session enabled
    [Arguments]    ${bool}
    LoginTobrowserqweb
    Qwebelement.clicktext         Home troubleshooting
    QWeb.ClickElement    ${subssearch}
    Qwebelement.typetext     ${subMac}    ${subssearch}
    Qwebelement.clicktext    Search
    QWeb.ClickElement            ${clickfirstresult}
    Sleep  5s
    LogScreenshot
    IF    '${bool}'=='False'
        VerifyText    The Home Console is not available on this account because data collection is turned off due to user privacy settings    20s
    ELSE
        VerifyNoText    The Home Console is not available on this account because data collection is turned off due to user privacy settings    20s
        Run Keyword And Continue On Failure     VerifyText             Repeat diagnostic    300s
        Run Keyword And Continue On Failure  VerifyText    ${timeZone}
        LogScreenshot
        ClickElement  ${eleCustomerCard}
        ${s}    Replace String    ${timezonecheck}    timezone    ${timeZone}
        Run Keyword And Continue On Failure    VerifyElement  ${s}
        LogScreenshot
        ${status}    Run Keyword And Return Status    VerifyText    Radio management
        Run Keyword If    '${status}'=='False'    Press Click Element    ${eleNewPortal}
    END

