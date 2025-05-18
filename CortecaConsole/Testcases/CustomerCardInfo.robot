*** Settings ***
Library         String
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Resource        ../Resources/TestSpecificProcedures/DataModelBrowserKeyword.resource
Resource        ../Resources/TestSpecificProcedures/LoginPageProcedures.robot

*** Test Cases ***

BBDT-162608_NWCC_AIOC_HomeDashboard_10
    [Documentation]    Testcase Name: NWCC_AIOC_HomeDashboard_10
    ...    Title: \ Verify Customer Info card in Overview Page
    ...    Objective:
    ...    1.Check in the Customer Info Tab the Name, Email, Time Zone, Associated MAC, Customer ID fields are present with relevant info.
    [Tags]
    [Teardown]    Logout From Corteca Console
    Login To Corteca Console
    Open Corteca Console Home Page
    ${CustomerInfocardDict}=    Run Keyword    Get Customer Card Info
    Log    ${CustomerInfocardDict}
    Run Keyword And Continue On Failure    Should Be Equal    ${CustomerInfocardDict}[Name]    ${Account}[FirstName]
    Run Keyword And Continue On Failure    Should Be Equal    ${CustomerInfocardDict}[Email]    ${Account}[Email]
    Run Keyword And Continue On Failure    Should Be Equal    ${CustomerInfocardDict}[Associated MAC]    ${Root}[mac1]
    Run Keyword And Continue On Failure    Should Be Equal    ${CustomerInfocardDict}[Timezone]    ${DefPortaTimezone}
    Sleep    ${sleepMin}

BBDT-43542_NWCC_L1_Timezone_01
    [Documentation]    Testcase Name: NWCC_L1_Timezone_01
    ...    Title: \ imezone in L1 console
    ...    Objective:
    ...    1.Check Default Timezone while login to Console
    ...    2.Change the Timezone and check the Portal, Timezone intacted in Portal.
    ...    3.Check Event HIstory page for the Timezone change event received.
    [Tags]
    [Teardown]    Logout From Corteca Console
    Log    \n Check Default Timezone while login to Console
    Login To Corteca Console
    Open Corteca Console Home Page
    Log    \n Change Timezone \n
    ${changeTimezone}    SSHExecute    ${ChangeDeviceTimezoneCli}    ${Root}[ip]    ${Root}[telnet_vtysh]
    Sleep    ${sleepMax}
    Capture Page Screenshot
    Log    \n Check timezone value is intact after change in Portal.
    ${Timezonevaluechange}=    String.Split String    ${Timezonevaluechange}    -
    ${customerInfo}    Get Customer Card Info
    Sleep    ${sleepMax}
    Run Keyword And Continue On Failure    Should contain    ${customerInfo}[Timezone]    ${Timezonevaluechange}[1]
    Log    \nNavigate to Event History Page \n
    Run Keyword And Continue On Failure    Press Click Element    ${networkhistory}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Run Keyword And Continue On Failure     Page Should Contain    Timezone has been changed
    sleep    ${sleepMin}
    Log    \n Revert back to default Timezone.
    ${changeTimezone}    SSHExecute    ${ChangeDeviceTimezoneClidefault}    ${Root}[ip]    ${Root}[telnet_vtysh]
    Sleep    ${sleepMin}
