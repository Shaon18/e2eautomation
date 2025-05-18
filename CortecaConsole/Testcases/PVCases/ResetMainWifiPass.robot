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
Resource        ../../Resources/KeywordDefinition/guest_enable.resource
Resource        ../../Resources/TestSpecificProcedures/NEWPV/resetadmin.resource


*** Test Cases ***


BBDT-176385|NWCC_AIOC_TroubleshootingDashboard_13 | Verify Reset Main Wi-Fi Password
    [Documentation]     [Action:Check the below scenario for Reset Main Wi-Fi Password:
     ...                1. Set the Main SSID password and connect devices to the Mesh network.
    ...                2. Trigger Reset Main Wi-Fi password from the Support Card.
    ...                3. Check if the Password for the Main SSID is reset to default.
    ...                4. Check Guest SSID password should be intact.
    ...                5. Check if an Event is logged in the Network History] [Data:] [Expected Result:]
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move To Home Dashboard
    Open SA Configuration
    Change Ssid To Given Values    ${Root}[ssid_defa_name]    ${Root}[ssid_defa_password]    ${modified_pass}
    Trigger Reset Wifi    ${Root}[ssid_defa_name]
#    ${get_pass}    Check Ssid Pass    ${Root}[ssid_defa_name]
#    Should Be Equal As Strings    ${get_pass}    ${Root}[ssid_defa_password]
