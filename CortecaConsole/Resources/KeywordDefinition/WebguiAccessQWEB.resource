*** Settings ***
Library         Process
Library         String
Library         Collections
Library         QWeb
Variables    ../JavaScriptCodes/executeJavaScriptCodeCorteca.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/WebguiLocatorUnified.py
Variables    ../../Locators/WebguiLocatorOld.py
Variables    ../TestDatas.py

*** Keywords ***
Open Pureview WebGui
    [Arguments]   ${url}=${Root}[gui_url]    ${browser}=${browserOption}    ${username}=${Root}[gui_username]    ${paswd}=${Root}[gui_password]    ${textToCheck}=Overview
    ${result}=    Run Process    python    ${currentdirectoryfolder}\auto_installer_chrome.py
    Log To Console    open the browser
    Open Browser       ${url}   ${browser}        --ignore-certificate-errors
    Maximize Window
    LogScreenshot
    qwebelement.typetext   ${username}    ${InputUsername}
    LogScreenshot
    qwebelement.typetext    ${paswd}    ${InputPassword}
    ClickElement    ${LoginBtn}
    Sleep    15s
    LogScreenshot
    VerifyText    ${texttoCheck}    100s
    Sleep    ${sleepMin}

EnableAccessControl
    [Arguments]   ${url}=${Root}[gui_url]    ${browser}=${browserOption}    ${username}=${Root}[gui_username]    ${paswd}=${Root}[gui_password]    ${textToCheck}=Overview
    [Teardown]    Close All Browsers
    Open Pureview WebGui
    Click Element    ${SecurityTab}
    Sleep    ${sleepMin}
    Qwebelement.clicktext    Access control
    Sleep    ${sleepMin}
    Sleep    ${sleepMin}
    ClickText    LAN   WAN connection list
    LogScreenshot
    Click Element    ${Telnet}
    Sleep    ${sleepMin}
    Click Element    ${AllowTelnet}
    Sleep    ${sleepMin}
    Run Keyword And Continue On Failure    Click Element    ${Confirmbtn}
    Sleep    ${sleepMin}
    Click Element    ${SSH}
    Sleep    ${sleepMin}
    Click Element    ${AllowSSH}
    Sleep    ${sleepMin}
    Click Element    ${HTTP}
    Sleep    ${sleepMin}
    Click Element    ${AllowHTTP}
    Sleep    ${sleepMin}
    Run Keyword And Continue On Failure    Click Element    ${Confirmbtn}
    LogScreenshot
    Sleep    ${sleepMin}
    Qwebelement.clicktext    Save
    Sleep    ${sleepMin}

Open Old WebGui
    [Arguments]   ${url}=${Root}[gui_url]    ${browser}=${browserOption}    ${username}=${Root}[gui_username]    ${paswd}=${Root}[gui_password]    ${textToCheck}=Overview
    ${result}=    Run Process    python    ${currentdirectoryfolder}\auto_installer_chrome.py
    Log To Console    open the browser
    Open Browser       ${url}   ${browser}        --ignore-certificate-errors
    Maximize Window
    LogScreenshot
    qwebelement.typetext   ${username}    ${usern}
    LogScreenshot
    qwebelement.typetext    ${paswd}    ${passwd}
    ClickElement    ${logbtn}
    Sleep    15s
    LogScreenshot
    VerifyText    ${texttoCheck}    100s
    Sleep    ${sleepMin}

open webgui
    [Arguments]    ${username}=${Root}[gui_username]    ${paswd}=${Root}[gui_password]
    IF    '${Root_Web_GUI_Type}'=='Pureview'
        Open Pureview WebGui    ${username}    ${paswd}
    ELSE
        Open Old WebGui    ${username}    ${paswd}
    END