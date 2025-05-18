*** Settings ***
Library         String
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Resource        ../Resources/TestSpecificProcedures/NetworkHistoryKeywords.resource
Resource        ../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource        ../Resources/TestSpecificProcedures/ContainerAppKeyword.resource

*** Test Cases ***

BBDT-176393_NWCC_AIOC_TroubleshootingDashboard_21
    [Documentation]    Testcase Name: NWCC_AIOC_TroubleshootingDashboard_21
    ...    Title: Verify Network History page options
    ...    Objective:
    ...    Check if the Network History page has the below Tabs and fields respectively:
    ...    Network History, Alarms, Events, DFS Statistics and Non Nokia Wi-Fi Point Onboarding(for 3rd party GW only)
    ...    1. Calendar with Date and Time select
    ...    2. Events drop down menu
    ...    3. Devices drop down menu - Beacons & STA's
    ...    4. Table with Date, Event Type and Description
    ...    5. Pagination
    [Tags]
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Check the tabs and fields in Network History Page
    
BBDT-176394_NWCC_AIOC_TroubleshootingDashboard_22
    [Documentation]    Testcase Name: NWCC_AIOC_TroubleshootingDashboard_22
    ...    Title: Verify History Events listed according to user Time zone
    ...    Objective:
    ...    Check if the timestamp of the Events listed inline to the User's Time zone and not the system time.
    ...    Change the Time zone of the user and check if the events are aligned accordingly.
    [Tags]
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Check Events aligned with Timezone

BBDT-176395_NWCC_AIOC_TroubleshootingDashboard_23
    [Documentation]    Testcase Name: NWCC_AIOC_TroubleshootingDashboard_23
    ...    Title: Verify Calendar, Search and Pagination option for Events in Network History table
    ...    Objective:
    ...    Check if the Date, Time can be selected in calendar for listing the respective events during tat time period.
    ...    Check upon selecting the Event Type and Devices from the drop down menu it should list only the corresponding events in the table.
    ...    Check if the table exceeds the maximum limit, it should log the events in next page and Pagination should be enabled.
    ...    Events should be listed in the table based on the recent timestamp first and in decreasing order thereby
    [Tags]
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Select Event Type and check the list table
    