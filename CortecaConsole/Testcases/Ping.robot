*** Settings ***
Resource    ../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource    ../Resources/TestSpecificProcedures/PingKeywords.robot
Variables    ../Resources/TestDatas.py

*** Test Cases ***
BBDT-280312_NWCC_AIOC_USP_HomeDashboard_17
    [Documentation]    Verify Ping Test Functionality
    ...    Check the Ping Test functionality for
    ...    1. Default Server 'www.google.com'
    ...    2. User input web URL
    ...    3. Check for IPv4 Address input
    ...    4. Check for IPv6 Address input
    ...    5. Check if the speed values are properly logged in the Ping test card
    [Tags]    Both    smoke   pvcase
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Check Ping Test Functionality

BBDT-280313_NWCC_AIOC_USP_HomeDashboard_18
    [Documentation]    Verify Ping Test History Table
    ...    1. Check the Ping test History Table should update dynamically upon trigger and result is seen.
    ...    2. It should list the last 30 ping test values and support pagination in the table.
    [Tags]    Both
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Check Ping Test Functionality
    Trigger Ping test for 30 times
    Check pagination in ping test history table

BBDT-277857_NWCC_L1BE_USP_Phase11_TR143_noofconnection_01
    [Documentation]    Configure number of connections in TR143 speed test
    ...    Step1: Action: Configure number of connections to 4 for download and upload TR143 speed test via speed test API for a device - download_number_of_connections and upload_number_of_connections
    ...    Expected Result: API shoud be successful and update in cloud DB
    ...    Step2: Action: Trigger GET speed test configuration API
    ...    Expected Result: API response should have TR143 configuration with download_number_of_connections and upload_number_of_connections for configured device
    ...    Step3: Action: Connect root USP device to corteca controller
    ...    Expected Result: Device should be online in corteca controller
    ...    Step4: Action: Trigger TR143 speed test
    ...    Expected Result: Operate command for Upload diagnostics and Download diagnostics sent to device should have NumberofConnections value configured via API
    [Tags]    USP
    [Teardown]    Logout From Corteca Console
    Configure no of conn via speed test API
    Trigger GET speed test configuration API
    Trigger TR143 speed test via console
    