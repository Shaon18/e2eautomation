*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Variables        ../../Locators/CortecaConsoleLocators.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource




*** Keywords ***


clearing hazelcast cache
    ${br}    Set Variable        https://admin:fonfonfon@edge.stg.homewifi.nokia.com:9443/boot-admin/wallboard
    ${result}=    Run Process    python    ${currentdirectoryfolder}\auto_installer_chrome.py
    Log To Console    open the browser
    OpenBrowser      ${br}      chrome
    # set config delay executing keywords by 1.5 seconds
    SetConfig    Delay    0.5s
    # Open Browser    ${browserUrl}    Chrome
    SetConfig    RetryInterval    2s
    Maximize Window
    Qwebelement.clicktext    HOME-HUB
    ClickElement    xpath=(//span[@class='text-sm italic'])[1]
    Qwebelement.clicktext    Caches
    Qwebelement.typetext    homehub-mesh-network-v2    xpath=//input[contains(@id,'filter')]
    ClickElement    xpath=//button[@class='btn relative px-3 py-2 button'][contains(.,'Clear')]
    VerifyText    Cleared



set mesh live true
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=${NewUser_Credentials1}[X-ServiceType]    Content-Type=${NewUser_Credentials1}[Content-Type]
    ${RetResponse}=    GET On Session       ${session_id}   /homehub/networks/38-A0-67-92-6D-E1/mesh?live=true     headers=${headers}
    Status Should Be    200    ${RetResponse}
    ${RetResponse}=   Set To Dictionary       ${RetResponse.json()}
    Log To Console      ${RetResponse}
    
    
check logs if subscription present for mlo and non mlo
    [Arguments]    ${bool}=False
    