*** Settings ***
Library         String
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Resource        ../../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource        ../../Resources/TestSpecificProcedures/DeviceUsage.resource
Variables       ../../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py







*** Test Cases ***
BBDT162638_NWCC_AIOC_HomeDashboard_45 Verify Device Vs Speed Graph
    [Documentation]    NWCC_AIOC_HomeDashboard_45 Verify Device Vs Speed Graph
    ...                Moves to the device usage tab
    ...                Move to Device Vs Speed tab
    ...                Does API validation to check if the client mac matches or not and the Tx rate and Rx rate are not Zero
    ...                Check if the dropdown containing the client list is present
    ...                Checks if the card showing canvas image of the graph is present or not by checking if no "No data available" prompt is present.
    ...                Check after 30s if the graph is changing or not
    [Tags]    Both    smoke   pvcase
    [Teardown]    Logout From Corteca Console
    ${clientsthatareshown}    Create List    
    Set Test Variable    ${clientsthatareshown}    ${clientsthatareshown}
    Log To Console    Opening device usage tab
    Move To Device Usage
    Log To Console    Move to Device Vs Speed tab
    Run Keyword And Continue On Failure    Click Element    ${drpDown}
    Run Keyword And Continue On Failure    Click Element    ${thirtyDays}
    Run Keyword And Continue On Failure    Click Element    ${devicevsspeed}
    Sleep    60s
    Log To Console    API validation to check if the client mac matches or not and the Tx rate and Rx rate are not Zero
    Run Keyword And Continue On Failure    Usage API Validation
    Log To Console    Checking Graph After One Minute
    Run Keyword And Continue On Failure    Checking Graph After One Minute
    Log To Console    Checking Client details
    Run Keyword And Continue On Failure    Checking List Of Clients In Dropdown Menu
    Sleep    10s
    Capture Page Screenshot    ${saveScreenShotPath}/DeviceUsage_NWCC_AIOC_HomeDashboard_45.png

BBDT162638_NWCC_AIOC_HomeDashboard_44 Verify Time vs Speed Graph
    [Documentation]    NWCC_AIOC_HomeDashboard_44 Verify Time vs Speed Graph
    ...                Moves to the device usage tab
    ...                Does API validation to check if the client mac matches or not and the Tx rate and Rx rate are not Zero
    ...                Check if the dropdown containing the client list is present
    ...                Check if the dropdown containing the Speed(Rx Vs Tx) is present
    ...                Checks if the card showing canvas image of the graph is present or not by checking if no "No data available" prompt is present.
    ...                Check after 30s if the graph is changing or not
    [Tags]    Both    smoke   pvcase
    [Teardown]    Logout From Corteca Console
    ${clientsthatareshown}    Create List
    Set Test Variable    ${clientsthatareshown}    ${clientsthatareshown}
    Log To Console    Opening device usage tab
    Move To Device Usage
    Log To Console    API validation to check if the client mac matches or not and the Tx rate and Rx rate are not Zero
    Run Keyword And Continue On Failure    Usage API Validation
    Log To Console    Checking Graph After One Minute
    Run Keyword And Continue On Failure    Checking Graph After One Minute
    Log To Console    Checking Client details
    Run Keyword And Continue On Failure    Checking List Of Clients In Dropdown Menu
    Run Keyword And Continue On Failure    Click Element    ${txVSrx}
    Run Keyword And Continue On Failure    Page Should Not Contain Element       ${nodataavailable}
    Sleep    10s
    Capture Page Screenshot    ${saveScreenShotPath}/TimevsSpeed_NWCC_AIOC_HomeDashboard_44.png


BBDT162638_NWCC_AIOC_HomeDashboard_39 Verify Broadband usage Graph
    [Documentation]    NWCC_AIOC_HomeDashboard_39 Verify Broadband usage Graph
    ...                Moves to the Broadband usage tab
    ...                Does API validation to check if the client mac matches or not and the Tx rate and Rx rate are not Zero
    ...                check if the the graph is diplaying or not for 24 hours, 7days and 30 days.
    [Tags]    Both    smoke   pvcase
    [Teardown]    Logout From Corteca Console
    Log To Console    Opening device usage tab
    Move To Usage Tab
    Log To Console    Does API validation to check if the client mac matches or not and the Tx rate and Rx rate are not Zero
    Run Keyword And Continue On Failure    Usage API Validation
    Log To Console    Verify the gragh presence for 24hrs
    Run Keyword And Continue On Failure    Page Should Not Contain Element       ${nodataavailable}
    Capture Page Screenshot    ${saveScreenShotPath}/BroadbandUsage_NWCC_AIOC_HomeDashboard_39_24hr.png
    Run Keyword And Continue On Failure    Click Element     ${dropdown}
    Log To Console    Verify the gragh presence for 7 days
    Run Keyword And Continue On Failure    Click Element     ${brsevendays}
    Sleep  5s
    Run Keyword And Continue On Failure    Page Should Not Contain Element       ${nodataavailable}
    Capture Page Screenshot    ${saveScreenShotPath}/BroadbandUsage_NWCC_AIOC_HomeDashboard_39_7days.png
    Run Keyword And Continue On Failure    Click Element     ${dropdown}
    Log To Console    Verify the gragh presence for 30 days
    Run Keyword And Continue On Failure    Click Element     ${brthirtydays}
    Sleep  5s
    Run Keyword And Continue On Failure    Page Should Not Contain Element       ${nodataavailable}
    Sleep    10s
    Capture Page Screenshot    ${saveScreenShotPath}/BroadbandUsage_NWCC_AIOC_HomeDashboard_39_30days.png


BBDT162638_NWCC_AIOC_HomeDashboard_40
    [Documentation]    NWCC_AIOC_HomeDashboard_40 Verify Device Usage Graph
    ...                Moves to the device usage tab
    ...                Does API validation to check if the client mac matches or not and the Tx rate and Rx rate are not Zero
    ...                Checks if the card showing device usage is present or not for 24 days , 7 days, 30 days.
    ...                In api validation we check if the device mac list contains extender mac or not
    [Tags]    Both    smoke   pvcase
    [Teardown]    Logout From Corteca Console
    Log To Console    Opening device usage tab
    Move To Device Usage
    Log To Console    Does API validation to check if the client mac matches or not and the Tx rate and Rx rate are not Zero
    Run Keyword And Continue On Failure    Usage API Validation
    Log To Console    Verify the gragh presence for 24hrs
    Run Keyword And Continue On Failure    Page Should Contain Element        ${chartjsforusage}
    Run Keyword And Continue On Failure    Page Should Not Contain Element       ${nodataavailable}
    Capture Page Screenshot    ${saveScreenShotPath}/DeviceUsage_NWCC_AIOC_HomeDashboard_40_24hr.png
    Run Keyword And Continue On Failure    Click Element        ${dropdowndevice}
    Log To Console    Verify the gragh presence for 7 days
    Run Keyword And Continue On Failure    Click Element     ${brsevendays}
    Sleep  5s
    Run Keyword And Continue On Failure    Page Should Contain Element        ${chartjsforusage}
    Run Keyword And Continue On Failure    Page Should Not Contain Element       ${nodataavailable}
    Capture Page Screenshot    ${saveScreenShotPath}/DeviceUsage_NWCC_AIOC_HomeDashboard_40_7days.png
    Run Keyword And Continue On Failure    Click Element     ${dropdowndevice}
    Log To Console    Verify the gragh presence for 30 days
    Run Keyword And Continue On Failure    Click Element     ${brthirtydays}
    Sleep  5s
    Run Keyword And Continue On Failure    Page Should Contain Element        ${chartjsforusage}
    Run Keyword And Continue On Failure    Page Should Not Contain Element       ${nodataavailable}
    Capture Page Screenshot    ${saveScreenShotPath}/DeviceUsage_NWCC_AIOC_HomeDashboard_40_30days.png




