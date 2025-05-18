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
Variables            ../../TestDatas.py
Variables        ../../../Locators/WebguiLocatorUnified.py
Resource    ../../../Resources/KeywordDefinition/WebguiAccessQWEB.resource


*** Keywords ***





trigger reset admin
    Move To Home Dashboard
    Open SA Configuration
    Log Screenshot
    Log    click reset admin from corteca console
    Qwebelement.clicktext    Reset Admin Password
    Log Screenshot
    Qwebelement.clicktext    Reset Password
    Log    Check if the admin password change request has been iniated 
    Log Screenshot
    Run Keyword And Continue On Failure    VerifyText    Success Processing the request to reset the admin password
    Log Screenshot
    Log    Check if the the admin password has been reset
    Run Keyword And Continue On Failure    VerifyText    Success The admin password has been reset
    Log    check even history
    Move To Event History
    Sleep     30s
    Run Keyword And Continue On Failure    VerifyText    Web GUI admin/Mobile APP local account password has been reset for ${Root}[udefi_frn_name]

trigger reset wifi
    [Arguments]    ${name}
    Move To Home Dashboard
    Open SA Configuration
    Log Screenshot
    Log    click reset main wifi from corteca console
    IF    '${DeviceStream}'=='HA'
        Qwebelement.clicktext    Reset Main WiFi Password
        Run Keyword And Continue On Failure    VerifyText    This will reset the password on the default network to the password that is on the sticker of the root WiFi point.
    ELSE
        Qwebelement.clicktext    Reset WiFi Password
        Run Keyword And Continue On Failure    VerifyText    This will reset the password of the Selected WiFi network
        ClickElement     ${selectwifinetwork}
        Qwebelement.clicktext        ${name}
    END
    Log Screenshot
    Qwebelement.clicktext    Reset Password
    Log    Check if the main wifi password change request has been iniated
    Log    Check if the the main wifi password has been reset
    Log Screenshot
    IF    '${DeviceStream}'=='HA'
        Run Keyword And Continue On Failure    VerifyText    Success Processing the request to reset the main WiFi password.
        LogScreenshot
        Run Keyword And Continue On Failure    VerifyText    Success The main WiFi password has been reset    60s
        LogScreenshot
    ELSE
        Run Keyword And Continue On Failure    VerifyText    Notification Your WiFi network ${name} reset initiated
        Log Screenshot
        Run Keyword And Continue On Failure    VerifyText    Success Your Wifi Network ${name} has been reset    60s
        LogScreenshot
    END
    Move To Home Dashboard
    Log    check even history
    Move To Event History
    IF    '${DeviceStream}'=='HA'
       Run Keyword And Continue On Failure     VerifyText    Main SSID password was reset for ${Root}[udefi_frn_name]
    ELSE
        Run Keyword And Continue On Failure    VerifyText    SSID ${name} password was reset for ${Root}[udefi_frn_name]
    END

