*** Settings ***
Library    Selenium
Library    String
Library    Telnet
Library    Process
Library    Collections
Library    JSONLibrary
Library    DateTime
Resource     ../KeywordDefinition/CommonKeywords.robot
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/CortecaConsoleLocators.py
Variables    ../TestDatas.py
Variables    ../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py
Resource        ../Resources/TestSpecificProcedures/DataModelBrowserKeyword.resource
Resource    LoginPageProcedures.robot
Variables    ../../Resources/TestDatas.py
Resource    ../Resources/TestSpecificProcedures/ContainerAppKeyword.resource

*** Keywords ***

Check the tabs and fields in Network History Page
    Open Corteca Console Home Page
    Move to EventHistoryPage
    Check defaultFields in EventHistoryPage
    Check Calendar with Date and Time
    Check Events dropdown Lists
    Check Devices dropdown Lists
    Check Event History Table Data
    Check Event History Pagination

Move to EventHistoryPage
    Log To Console    **** 1. Drag to Event History page ****\n
    Log    \n Move to Event History Page \n
    ${EventHistory}=    Press Click Element    ${networkhistory}
    Sleep    ${sleepMin}
    ${EventHistoryHdr}=    Get Text    ${eleHistoryhdr}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Should Be Equal    ${EventHistoryHdr}    Event history / L1 Events
    Sleep    ${sleepMin}

Check defaultFields in EventHistoryPage
    Log To Console    **** 1. Check default tabs in Page ****\n
    Log    \n Check default tabs in page \n
    ${Tabcount}    Execute Javascript    ${NetworkHistorytabcount}
    Capture Page Screenshot
    FOR    ${i}    IN RANGE    1    ${Tabcount}
        Run Keyword    Page Should Contain Element    ${eleHistoryPageTab${i}}
        Sleep    ${sleepMin}
    END

Check Calendar with Date and Time
    Log To Console    **** 1. Check Calendar with Date and Time in Page ****\n
    Log    \n Check Calendar with Date and Time in Page \n
    ${DeviceTime}    Get Device Time
    Log    ${DeviceTime}
    ${PortalCalendarData}=    Run Keyword    Get Value    ${eleEventHistoryCalendar}
    Log    ${PortalCalendarData}
    ${Status}    Compare portal and Device DateTime    ${DeviceTime}   ${PortalCalendarData}
    Run Keyword    Should Be True    ${Status}
    Run Keyword    Click Element    ${eleEventHistoryCalendar}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Page Should Contain Element    ${eleHistorycurrentDate}
    sleep    ${sleepMin}
    Run Keyword And Continue On Failure    Click Element        ${eleHistorycalendarCancel}

Get Device Time
    [Documentation]    Get the Device time and convert to epoc.Returns the epoc value
    ${currentTime}    SSHExecute    ${deviceTimezoneCli}    ${Root}[ip]    ${Root}[telnet_vtysh]
    ${historytime}    Fetch From Right    ${currentTime}    ${deviceTimezoneMatch}
    Log    ${historytime}
    ${dateVal2}    Convert Date    ${historytime}    result_format=%b %d, %Y %I:%M %p
    Log    ${dateVal2}
    RETURN    ${dateVal2}

Compare portal and Device DateTime
    [Arguments]    ${DeviceTime}   ${PortalCalendarData}
    Log    /n Split range
    ${start}=    Set Variable    ${PortalCalendarData.split(' - ')[0]}
    ${end}=      Set Variable    ${PortalCalendarData.split(' - ')[1]}
    Log    /nConvert to datetime objects
    ${start_dt}=    Convert Date    ${start}    date_format=%b %d, %Y %I:%M %p
    ${end_dt}=      Convert Date    ${end}      date_format=%b %d, %Y %I:%M %p
    ${target_dt}=   Convert Date    ${DeviceTime}   date_format=%b %d, %Y %I:%M %p
    Log    /nCompare with margin of 10 minutes
    ${end_plus_5}=    Add Time To Date    ${end_dt}    10 minutes
    ${Status}    Run Keyword If    '${target_dt}' >= '${start_dt}' and '${target_dt}' <= '${end_dt}'    Set Variable    True
                ...    ELSE IF     '${target_dt}' > '${end_dt}' and '${target_dt}' <= '${end_plus_5}'   Set Variable    True
                ...    ELSE IF     '${target_dt}' > '${end_plus_5}'    Set Variable    False
    Return From Keyword    ${Status}
    
Check Events dropdown Lists
    Log To Console    **** 1. Check Events dropdown Lists in Page ****\n
    Log    \n Check Events dropdown Lists in Page \n
    Run Keyword    Click Element    ${eleHistoryeventdrpdown}
    Capture Page Screenshot
    Sleep    ${sleepMin}
    Log    \n Check the fields in Events lists \n
    Run Keyword And Continue On Failure    Page Should Contain Element    ${eleHistoryeventAgent}
    Run Keyword And Continue On Failure    Page Should Contain Element    ${eleHistoryeventDevice}
    Run Keyword And Continue On Failure    Page Should Contain Element    ${eleHistoryeventInterference}
    Run Keyword And Continue On Failure    Page Should Contain Element    ${eleHistoryeventUser}
    Run Keyword And Continue On Failure    Page Should Contain Element    ${eleHistoryeventMeshNetwork}
    Run Keyword    Click Element    ${eleHistoryeventdrpdown}
    Capture Page Screenshot
    Sleep    ${sleepMin}

Check Devices dropdown Lists
    Log To Console    **** 1. Check Devices dropdown Lists in Page ****\n
    Log    \n Check Devices dropdown Lists in Page \n
    Run Keyword    Click Element    ${eleHistorydevicesdrpdown}
    Capture Page Screenshot
    Sleep    ${sleepMin}
    Log    \n Check the AP's List in Device dropdown\n
    ${DevicesList}=    Execute Javascript    ${NetworkHistoryDeviceList}
    Sleep    ${sleepMin}
    Run Keyword    Should Contain    ${DevicesList}    ${Root}[udefi_frn_name]
    FOR    ${extender}    IN    @{meshNodes}
         Run Keyword    Should Contain    ${DevicesList}    ${${extender}}[udefi_frn_name]
         Sleep    ${sleepMin}
    END         
    Log    \n Check the Station List in Device dropdown\n
    Run Keyword    Should Contain    ${DevicesList}    ${Root_Client1}[hostName]
    Sleep    ${sleepMin}
    Run Keyword    Click Element    ${eleHistorydevicesdrpdown}
    Capture Page Screenshot
    Sleep    ${sleepMin}

Check Event History Table Data
    Log To Console    **** 1. Check Event History Table Data ****\n
    Log    \n Check Event History Table Data \n
    Log    \n Check the fields in Events lists \n
    Run Keyword And Continue On Failure    Page Should Contain Element    ${eleHistoryTableTime}
    Run Keyword And Continue On Failure    Page Should Contain Element    ${eleHistoryTableEvent}
    Run Keyword And Continue On Failure    Page Should Contain Element    ${eleHistoryTableDescription}
    Capture Page Screenshot
    Sleep    ${sleepMin}
    Run Keyword    Page Should Not Contain    No data available

Check Event History Pagination
    Log To Console    **** 1. Check Pagination ****\n
    Log    \n Check Pagination \n
    ${locator}    Replace String    ${EventHistoryPagePagination}    SELECTOR    "${eleEventHistoryPagePagination}"
    ${locator1}    Replace String    ${EventHistoryPagePaginationArrow}    SELECTOR    "${eleEventHistoryPagePaginationArrow}"
    ${Total}    Execute Javascript    ${locator}
    Run Keyword and Continue on failure    Should Contain    ${Total}    1 - 25 of
    ${Total}    Fetch from right    ${Total}    of
    Strip String    ${Total}
    Log    Pagination count: ${Total}
    ${val}    Evaluate    ${Total}/25
    ${val}    Convert to String    ${val}
    Log    ${val}
    Log    \n Check the pagination Arror marks and enabled or not with the help of index number.
    ${val}    Fetch from left    ${val}    .
    ${locator2}    Replace String    ${locator1}    INDEX    0
    ${sub_status}=    Execute Javascript    ${locator2}
    Run Keyword and continue on failure    Should Be Equal    ${sub_status}    true
    ${locator2}    Replace String    ${locator1}    INDEX    1
    ${sub_status}=    Execute Javascript    ${locator2}
    Run Keyword and continue on failure    Should Be Equal    ${sub_status}    true
    ${locator2}    Replace String    ${locator1}    INDEX    2
    ${sub_status}=    Execute Javascript    ${locator2}
    Run Keyword and continue on failure    Should Not Be Equal    ${sub_status}    true
    Run Keyword and continue on failure    Click Element        ${elePaginationNextArrow}
    Sleep    ${sleepMin}
    Run Keyword    Page Should Not Contain    No data available
    Capture Page Screenshot
    ${locator2}    Replace String    ${locator1}    INDEX    3
    ${sub_status}=    Execute Javascript    ${locator2}
    Run Keyword and continue on failure    Should Not Be Equal    ${sub_status}    true
    Run Keyword and continue on failure    Click Element       ${elePaginationLastArrow}
    Sleep    ${sleepMin}
    Run Keyword    Page Should Not Contain    No data available
    Capture Page Screenshot

Check Events aligned with Timezone
    Open Corteca Console Home Page
    Move to EventHistoryPage
    Log To Console    **** 1. Check Events listed aligned with Timezone ****\n
    Log    \n Check Events listed aligned with Timezone \n
    Capture Page Screenshot
    ${PortalCalendarDataBeforetimezonechange}=    Run Keyword    Get Value    ${eleEventHistoryCalendar}
    Log    ${PortalCalendarDataBeforetimezonechange}
    Log    \n Change Timezone \n
    ${changeTimezone}    SSHExecute    ${ChangeDeviceTimezoneCli}    ${Root}[ip]    ${Root}[telnet_vtysh]
    Sleep    ${sleepMax}
    Capture Page Screenshot
    ${PortalCalendarDataAftertimezonechange}=    Run Keyword    Get Value    ${eleEventHistoryCalendar}
    Log    ${PortalCalendarDataAftertimezonechange}
    ${Status}    Compare portal DateTime    ${PortalCalendarDataBeforetimezonechange}   ${PortalCalendarDataAftertimezonechange}
    Run Keyword    Should not Be True    ${Status}
    Log    \n Change Timezone to default \n
    ${changeTimezone}    SSHExecute    ${ChangeDeviceTimezoneClidefault}    ${Root}[ip]    ${Root}[telnet_vtysh]
    
Compare portal DateTime
    [Arguments]    ${TimeBeforetimezonechange}   ${TimeAftertimezonechange}
    Log    \n Split range
    ${start1}=    Set Variable    ${TimeBeforetimezonechange.split(' - ')[0]}
    ${end1}=      Set Variable    ${TimeBeforetimezonechange.split(' - ')[1]}
    ${start2}=    Set Variable    ${TimeAftertimezonechange.split(' - ')[0]}
    ${end2}=      Set Variable    ${TimeAftertimezonechange.split(' - ')[1]}
    Log    \n Convert to datetime objects
    ${start_dt1}=    Convert Date    ${start1}    date_format=%b %d, %Y %I:%M %p
    ${end_dt1}=      Convert Date    ${end1}      date_format=%b %d, %Y %I:%M %p
    ${start_dt2}=    Convert Date    ${start2}    date_format=%b %d, %Y %I:%M %p
    ${end_dt2}=      Convert Date    ${end2}      date_format=%b %d, %Y %I:%M %p
    ${Status}    Run Keyword If    '${end_dt1}' <= '${end_dt2}'    Set Variable    False    ELSE    Set Variable    True
    Return From Keyword    ${Status}

Select Event Type and check the list table
    Open Corteca Console Home Page
    Move to EventHistoryPage
    Log    \n Check if the Date, Time can be selected in calendar for listing the respective events during tat time period.
    Date selection in Calendar
    Log    \n Check upon selecting the Event Type it should list only the corresponding events in the table.
    Log    \n Check Events dropdown Lists in Page \n
    Run Keyword    Click Element    ${eleHistoryeventdrpdown}
    Capture Page Screenshot
    Sleep    ${sleepMin}
    Log    \n Click the fields Agent and check the data\n
    Run Keyword And Continue On Failure    Click Element    ${eleHistoryeventSelectall}
    sleep    ${sleepMin}
    Run Keyword And Continue On Failure    Click Element    ${eleHistoryeventAgent}
    Sleep    ${sleepMin}
    Capture Page Screenshot
    Run Keyword    Page Should Not Contain    No data available
    ${EventList}=    Run Keyword    Execute Javascript    ${EventHistoryTable}
    Log    ${EventList}
    Run Keyword And Continue On Failure    List Should Not Contain Value    ${EventList}    Device
    Run Keyword And Continue On Failure    List Should Not Contain Value    ${EventList}    Interference
    Run Keyword And Continue On Failure    List Should Not Contain Value    ${EventList}    User
    Run Keyword And Continue On Failure    List Should Not Contain Value    ${EventList}    Mesh Network
    Log    \n Pagination should be enabled.
    Run Keyword And Continue On Failure    Click Element    ${eleHistoryeventSelectall}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Check Event History Pagination
    
Date selection in Calendar
    Log    \n Enable Event History table calendar
    Get Start Time Portal    30    2
    ${PortalDateTime}=    Run Keyword    Get End Time Portal    1
    Log    \n Enable calendar editable in EventHistory Page
    Run Keyword And Continue On Failure    Execute Javascript    ${EnableCalendardatetimeEdit}
    Sleep    ${sleepMin}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Execute Javascript    ${EventHistoryCalendar}
    Sleep    ${sleepMin}
    Capture Page Screenshot
    Log    \n Check for 2 days Events logged.
    ${locator}    Replace String    ${EditCalendardatetime}    SELECTOR    ${PortalDateTime}
    Sleep    ${sleepMin}
    Run Keyword    Execute Javascript    ${locator}
    Sleep    ${sleepMin}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Execute Javascript    ${EventCalendarApply}
    Sleep    ${sleepMin}
    Capture Page Screenshot
    Run Keyword    Page Should Not Contain    No data available


