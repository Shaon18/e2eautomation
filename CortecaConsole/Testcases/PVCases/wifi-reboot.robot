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
Resource        ../../Resources/TestSpecificProcedures/WIFI_REBOOT.resource




*** Test Cases ***

BBDT-176379_NWCC_AIOC_TroubleshootingDashboard_07_2 Verify Wi-Fi Reboot option for Extenders
    [Documentation]    NWCC_AIOC_TroubleshootingDashboard_07_2 Verify Wi-Fi Reboot option for Extenders
    ...                Tigger reboot for extenders
    ...                check success msg
    ...                check in network history
    ...                check core logs
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Check Wifi Reboot For Exts

 
 
BBDT-176379_NWCC_AIOC_TroubleshootingDashboard_07_1 Verify Wi-Fi Reboot option for Root
    [Documentation]    NWCC_AIOC_TroubleshootingDashboard_07_1 Verify Wi-Fi Reboot option for Root
    ...                Tigger reboot for root
    ...                check success msg
    ...                check in network history
    ...                check if the root is online
    ...                check core logs
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Check Wifi Reboot For Root
    



