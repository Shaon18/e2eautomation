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
Resource         caregaent.resource
Variables            ../../TestDatas.py



*** Keywords ***

Verify corteca elements for HDM
    LogScreenshot
    Verifytext    Home troubleshooting
    Set Permission Allowed    ${payload_hdmgeneral}
    Run Keyword And Continue On Failure    Check the device is online in L1 and L2
    Login To QWEB Browser For Keycloak    ${payload_hdmgeneral}
    Qwebelement.clicktext    select
    LogScreenshot
    VerifyText    Home Device Manager
    VerifyText    Management Console
    VerifyText    Campaign Manager
    Qwebelement.clicktext        Management Console
    SwitchWindow    NEW
    LogScreenshot
    ${url2}=    GetUrl
    Should Contain        ${url2}      ${hdm_main}
    SwitchWindow    1
    LogScreenshot
    Qwebelement.clicktext        Campaign Manager
    SwitchWindow    NEW
    LogScreenshot
     ${url1}=    GetUrl
    Should Be Equal As Strings    ${url1}   ${hdm_campaign}
