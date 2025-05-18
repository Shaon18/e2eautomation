*** Settings ***
Library         Process
Library         String
Library         Collections
Library         SeleniumLibrary
Resource     ../KeywordDefinition/CommonKeywords.robot
Variables    ../JavaScriptCodes/executeJavaScriptCodeCorteca.py
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/WebguiLocatorUnified.py
Variables    ../TestDatas.py

*** Keywords ***
Open Pureview WebGui
    [Arguments]   ${url}=${Root}[gui_url]    ${browser}=${browserOption}    ${username}=${Root}[gui_username]    ${paswd}=${Root}[gui_password]    ${textToCheck}=Overview
    Open Portal   ${url}    ${browser}
    Run Keyword And Ignore Error    Click Element    ${httpsAdvanced}
    Run Keyword And Ignore Error    Click Element    ${httpsProceed}
    Enter Value    ${InputUsername}   ${username}    timeout=60s
    Enter Value    ${InputPassword}   ${paswd}    timeout=60s
    Press Click Button    ${LoginBtn}
    Wait Until Page Contains     ${textToCheck}    timeout=60s
    Page Should Contain    ${textToCheck}
    Capture Page Screenshot    ${saveScreenShotPath}/WebGUIloginPage.png
    Sleep    ${sleepMin}

EnableAccessControl
    [Arguments]   ${url}=${Root}[gui_url]    ${browser}=${browserOption}    ${username}=${Root}[gui_username]    ${paswd}=${Root}[gui_password]    ${textToCheck}=Overview
    [Teardown]    Close All Browsers
    Open Pureview WebGui
    Click Element    ${SecurityTab}
    Sleep    ${sleepMin}
    Click Element    ${AccessControl}
    Sleep    ${sleepMin}
    Click Element    ${LANTab}
    Wait Until Page Contains    Telnet
    Click Element    ${Telnet}
    Sleep    ${sleepMin}
    Click Element    ${AllowTelnet}
    Sleep    ${sleepMin}
    #Run Keyword And Continue On Failure    Click Element    ${Confirmbtn}
    Run Keyword And Warn On Failure    Click Element    ${Confirmbtn}
    Sleep    ${sleepMin}
    Click Element    ${SSH}
    Sleep    ${sleepMin}
    Click Element    ${AllowSSH}
    Sleep    ${sleepMin}
    #Run Keyword And Continue On Failure    Click Element    ${Confirmbtn}
    Run Keyword And Warn On Failure    Click Element    ${Confirmbtn}
    Sleep    ${sleepMin}
    Click Element    ${HTTP}
    Sleep    ${sleepMin}
    Click Element    ${AllowHTTP}
    Sleep    ${sleepMin}
    #Run Keyword And Continue On Failure    Click Element    ${Confirmbtn}
    Run Keyword And Warn On Failure    Click Element    ${Confirmbtn}
    Capture Page Screenshot    ${saveScreenShotPath}/AccessControl.png
    Sleep    ${sleepMin}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Click Button    ${Savebtn}
    Sleep    ${sleepMin}

SoftwareUpgradeViaWebgui
    [Arguments]   ${filePath}    ${url}=${Root}[gui_url]    ${browser}=${browserOption}    ${username}=${Root}[gui_username]    ${paswd}=${Root}[gui_password]    ${textToCheck}=Overview
    [Teardown]    Close All Browsers
    Open Pureview WebGui
    Scroll Element Into View    ${MaintenanceTab}
    Click Element    ${MaintenanceTab}
    Sleep    2s
    Scroll Element Into View    ${TroubleshootingTab}
    Click Element    ${UpgradeTab}
    Sleep    2s
    Choose File    ${UploadeChooseTab}    ${filePath}
    Sleep    2s
    Click Button    ${WebguiSoftwareUploadButton}
    Sleep    90s


