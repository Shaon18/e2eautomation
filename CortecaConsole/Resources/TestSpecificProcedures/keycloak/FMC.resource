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
Resource        caregaent.resource
Variables            ../../TestDatas.py



*** Keywords ***

Verify corteca elements for fmc
    LogScreenshot
    Verifytext    Home troubleshooting
    Set Permission Allowed    ${payload_fmcuser}
    Run Keyword And Continue On Failure    Check the device is online in L1 and L2
    Login To QWEB Browser For Keycloak    ${payload_fmcuser}
    Base Fmc

base fmc
    Qwebelement.clicktext    select
    LogScreenshot
    VerifyText    Fast-Mile Controller
    VerifyText    CPE browser
    Qwebelement.clicktext    CPE browser
    SwitchWindow    NEW
    LogScreenshot
    ${url}    GetUrl
    Should Contain       ${url}    ${fmcuser}

    
    
Verify corteca elements for fmc admin
    Verifytext    Home troubleshooting
    Set Permission Allowed    ${payload_fmcadmin}
    Run Keyword And Continue On Failure    Check the device is online in L1 and L2
    Login To QWEB Browser For Keycloak    ${payload_fmcadmin}
    Base Fmc
    SwitchWindow    1
    VerifyText    Radio Planner
    LogScreenshot
    Qwebelement.clicktext    Radio Planner
    SwitchWindow    NEW
    LogScreenshot
    ${url2}    GetUrl    
    Should Contain      ${url2}   ${fmcuser}

    