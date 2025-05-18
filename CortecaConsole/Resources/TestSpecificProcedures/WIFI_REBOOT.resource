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


check wifi reboot for exts
    Move To Home Dashboard
    Sleep     120s
    FOR    ${i}    IN     @{meshNodes}
           Open SA Network Device
           Qwebelement.clicktext         Reboot network device
           ClickElement                ${selectnetworkdevice}    timeout=20s
           Run Keyword And Continue On Failure    Qwebelement.clicktext          ${${i}}[udefi_frn_name]
           Run Keyword And Continue On Failure     ClickText         Reboot network device    Cancel
           Sleep    5s
           Run Keyword And Continue On Failure    VerifyText     Success
           LogScreenshot
           Run Keyword And Continue On Failure    VerifyNoElement     ${errormsg}
    END
    Sleep  300s
    Move To Event History
#    ClickElement            ${networkhistorytable}
    FOR    ${j}    IN     @{meshNodes}
          ${checkroot2}    Set Variable    ${${j}}[udefi_frn_name] was rebooted
          Log    ${checkroot2}
          Run Keyword And Continue On Failure     VerifyText            ${checkroot2}    30s
    END
    LogScreenshot



check wifi reboot for root
    Move To Home Dashboard
    Open SA Network Device
    Qwebelement.clicktext         Reboot network device
    Run Keyword And Continue On Failure    ClickElement                ${selectnetworkdevice}    timeout=20s
    Qwebelement.clicktext          ${Root}[udefi_frn_name]
    Run Keyword And Continue On Failure    ClickText         Reboot network device    Cancel
    Sleep    5s
    Run Keyword And Continue On Failure    VerifyText     Success
    LogScreenshot
    Run Keyword And Continue On Failure    VerifyNoElement     ${errormsg}
    Sleep  300s
    Run Keyword And Continue On Failure    Check Core Logs
    Move To Event History
    ${checkroot}    Set Variable    ${Root}[udefi_frn_name] was rebooted
    Log    ${checkroot}
    Run Keyword And Continue On Failure    VerifyText              ${checkroot}    30s
    Run Keyword And Continue On Failure    Check Core Logs
    LogScreenshot
    Sleep    120s
    
    
check core logs
    ${result}   SSHExecute    ${core}
    Run Keyword And Continue On Failure    Should Contain    ${result}    No such file or directory
