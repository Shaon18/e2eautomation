*** Settings ***
Resource    ../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource    ../Resources/TestSpecificProcedures/RadioManagementKeywords.robot
Variables    ../Resources/TestDatas.py

*** Test Cases ***
BBDT-193888_NWCC_AIOC_TroubleshootingDashboard_58
    [Documentation]     Verify Radio Management Page options in Troubleshooting Dashboard.
     ...                Check if the Radio Management page as the below options in Root & EXT
     ...                1. Wi-Fi Point Icon with Friendly Name and Online/Offline status
     ...                2. Feature status card
     ...                3. Channel management
     ...                4. Connectivity Configuration
     ...                5. Home agent restart
     ...                6. Wi-Fi Point location
     ...                7. Wireless settings
     [Tags]    Both    smoke   pvcase
     [Teardown]    Logout From Corteca Console
     Login To Corteca Console
     Open Corteca Console Home Page
     Move To RadioManagement Tab
     Validate RadioManagement Page for Root and Extenders

BBDT-193892-NWCC_AIOC_TroubleshootingDashboard_62
    [Documentation]    Verify Wireless settings card in Radio Management page.
    ...                Check the Wireless settings card in the Radio Management page for below options
    ...                List the BSSID vs SSID per band supported info
    ...                Check the same for 2.4GHz, 5GHz High, 5GHz Low and 6GHz bands
    [Tags]    Both    smoke   pvcase
    [Teardown]    Logout From Corteca Console
     Login To Corteca Console
     Open Corteca Console Home Page
     Move To RadioManagement Tab
     Validate Wireless settings card in Radio Management page



