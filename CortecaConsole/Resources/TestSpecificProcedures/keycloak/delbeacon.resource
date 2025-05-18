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
Resource        ../../KeywordDefinition/ApiRequest.resource
Variables            ../../TestDatas.py
Variables        ../../../Locators/WebguiLocatorUnified.py
Resource     ../../KeywordDefinition/WebguiAccessQWEB.resource



*** Keywords ***

get topo api
    [Arguments]    ${pay}=${User_Credentials}
    ${online_url}    Set Variable    /homehub/networks/${Root}[mac]/topology?skip_virtual_node=true
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token    ${pay}
    &{headers}=    Create Dictionary    Authorization=${auth_token}   X-Service-Type=${NewUser_Credentials1}[X-ServiceType]    Content-Type=${NewUser_Credentials1}[Content-Type]
    ${RetResponse}=    Get On Session       ${session_id}    ${online_url}    headers=${headers}
    Status Should Be    200    ${RetResponse}
    ${Ret}=  Set Variable     ${RetResponse.json()}
    ${Ret}    Convert Json To String    ${Ret}
    Should Contain    ${Ret}    ${${meshNodes}[0]}[mac]


delete beacon
    [Arguments]    ${pay}=${User_Credentials}    ${ext}=Ext1
    ${online_url}    Set Variable    /subscribers/subscribers/${Root}[customerid]/devices/${${ext}}[mac]?force=true&factory_reset=false
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=${NewUser_Credentials1}[X-ServiceType]    Content-Type=${NewUser_Credentials1}[Content-Type]
    ${RetResponse}=    DELETE On Session           ${session_id}    ${online_url}    headers=${headers}
    Status Should Be    200    ${RetResponse}


verifytopo deleted time
    [Arguments]    ${ext}=Ext1
    LogScreenshot
    ClickText    Network    Event history
    VerifyText    ${${ext}}[serial_num]
    LogScreenshot
    Get Topo Api
    Delete Beacon
    LoginTobrowserqweb
    Qwebelement.clicktext         Home troubleshooting
    ClickElement    ${subssearch}
    Qwebelement.typetext    ${ext}[mac]     ${subssearch}
    Qwebelement.clicktext    Search
    LogScreenshot
    Run Keyword And Continue On Failure    VerifyText    No data available
    LoginTobrowserqweb    ${keycloak_tenant3}    chrome    tenant3keycloak    tenant3keycloak
    Qwebelement.clicktext    Users
    Qwebelement.clicktext    ${searchuser}
    Qwebelement.typetext    tenant3user    ${searchuser}
    ClickElement    xpath=//button[contains(@aria-label,'Search')]
    ClickText    tenant3user    Username
    Qwebelement.clicktext    Attributes
    VerifyNoText    topologydeletedtime



add back
    Qw.closebrowser
    Sleep    300s
    Open Pureview WebGui
    ClickText    WiFi    Devices
    Sleep    3s
    LogScreenshot
    Qwebelement.clicktext    Network Map
    Sleep    3s
    LogScreenshot
    VerifyText    Add WiFi point    100s
    Qwebelement.clicktext    Add WiFi point
    Sleep    3s
    LogScreenshot
    Qwebelement.clicktext    Continue with Web GUI
    Sleep    3s
    LogScreenshot
    Qwebelement.typetext    ${${meshNodes}[0]}[serial_num]    xpath=//input[contains(@placeholder,'')]
    LogScreenshot
    Qwebelement.clicktext    Add
    Qwebelement.clicktext    Network Map
    Sleep     5s
    LogScreenshot

