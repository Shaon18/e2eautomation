*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Variables        ../../../Locators/CortecaConsoleLocators.py
Resource        ../../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../../Resources/KeywordDefinition/Sshkeywords.resource
Resource     ../../../Resources/TestSpecificProcedures/keycloak/AdminReadOnly.resource
Resource    ../../../Resources/TestSpecificProcedures/ConfigureBoengSSH.resource
Resource    ../../../Resources/KeywordDefinition/WebguiAccessQWEB.resource




*** Keywords ***

trigger factory reset from portal
    Run Keyword And Continue On Failure    factory reset for extenders
    Run Keyword And Continue On Failure    factory reset for root

factory reset for root
    Move To Home Dashboard
    Open SA Network Device
    Qwebelement.clicktext    Factory reset modem or Gateway
    ClickText         Factory Reset   Cancel
    Run Keyword And Continue On Failure   VerifyText    Success
    Run Keyword And Continue On Failure    VerifyText    Root WiFi point is offline    150s
    Sleep    300s
    Run Keyword And Continue On Failure    Adding Back Root
    Move To Home Dashboard
    Run Keyword And Continue On Failure    Check the device is online in L1 and L2
    FOR    ${extenders}    IN     @{meshNodes}
         Move To Home Dashboard
         Run Keyword And Continue On Failure    Check the device is online in L1 and L2    ${${extenders}}[udefi_frn_name]    No
     END

factory reset for extenders
    Move To Home Dashboard
     FOR    ${extenders}    IN     @{meshNodes}
           Open SA Network Device
           Qwebelement.clicktext         Factory Reset WiFi Point
           ClickElement                ${selectnetworkdevice}    timeout=20s
           Run Keyword And Continue On Failure    Qwebelement.clicktext          ${${extenders}}[udefi_frn_name]
           Run Keyword And Continue On Failure     ClickText         Factory Reset   Cancel
           Sleep    5s
           Run Keyword And Continue On Failure    VerifyText     Success Factory reset request successful for ${${extenders}}[udefi_frn_name]
           LogScreenshot
           Run Keyword And Continue On Failure    VerifyNoElement     ${errormsg}
     END
     Sleep  30s
     Move To Event History
     FOR    ${extenders}    IN     @{meshNodes}
          Run Keyword And Continue On Failure     VerifyText    ${${extenders}}[udefi_frn_name] has been reset to factory default          30s
          LogScreenshot
     END
     Sleep  300s
     FOR    ${extenders}    IN     @{meshNodes}
         Move To Home Dashboard
         Check the device is online in L1 and L2    ${${extenders}}[udefi_frn_name]    No
     END

adding back root
    IF    '${Root_Web_GUI_Type}'=='Pureview'
        Run Keyword And Continue On Failure    EnableAccessControl
    END
    IF    '${Root}[Type]'=='AONT'
        Run Keyword And Continue On Failure    WAN Config In ONT
    END
    IF    '${DeviceStream}'=='HA'
       Run Keyword And Continue On Failure     HA_Configuration
    ELSE
       Run Keyword And Continue On Failure     ConfigureBoeng
    END
