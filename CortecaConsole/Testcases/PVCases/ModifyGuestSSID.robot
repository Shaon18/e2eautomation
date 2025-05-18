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


BBDT-176384|NWCC_AIOC_TroubleshootingDashboard_12|Verify Modify Wi-Fi Network for Guest SSID
    [Documentation]    Modify Guest SSID
    ...                Go to Troubleshooting Dashboard
    ...                Enable guest SSID
    ...                Click Modify Network
    ...                Choose    Guest SSID 
    ...                Get Guest SSID pass and name
    ...                Change it with alternate values
    ...                Wait for Success text
    ...                Check in network history
    ...                Change it back to original value
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Guest_Enable_Disable_API    1
    Sleep   50s
    Move To Home Dashboard
    Open SA Configuration
    Change SSID    ${Root}[guest_ssid_name]    ${Root}[guest_ssid_pass]    ${Root}[guest_ssid_changed_name]    ${modified_pass}









