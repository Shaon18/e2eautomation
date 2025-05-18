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






*** Test Cases ***


BBDT-176383 NWCC_AIOC_TroubleshootingDashboard_11 | Verify Modify Wi-Fi Network for Main SSID
    [Documentation]    Modify the mentioned SSID
    ...                Click Modify Network
    ...                Choose    Main SSID 
    ...                Get Main SSID pass and name
    ...                If pass value is empty return fail
    ...                Change it with alternate values
    ...                Wait for Success text
    ...                Check in network history
    ...                Change it back to original value
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move To Home Dashboard
    Open SA Configuration
    Change SSID    ${Root}[ssid_defa_name]    ${Root}[ssid_defa_password]     ${Root}[ssid_defa_changed_name]    ${modified_pass}

