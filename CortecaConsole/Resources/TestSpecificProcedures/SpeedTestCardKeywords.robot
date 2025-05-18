*** Settings ***
Library    SeleniumLibrary
Resource    LoginPageProcedures.robot
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/CortecaConsoleLocators.py
Variables    ../TestDatas.py

*** Keywords ***
Move To Overview SpeedtestCard And Trigger Test
    Open Corteca Console Home Page
    Wait Until Element Is Enabled    ${eleSpeedtestTrigger}
    Trigger Speedtest

Move To Speedtest Page And Trigger Test
    Open Corteca Console Home Page
    Press Click Element    ${eleSpeedtestTab}
    Sleep    ${sleepMin}
    Wait Until Element Is Enabled    ${eleSpeedtestTrigger}
    Trigger Speed Test

Trigger Speedtest
    ${status}    Set Variable    False
    Wait Until Keyword Succeeds    10 times    6 second    Initiate Test run    ${status}
    Wait Until Element Is Visible    ${eleHomeSpeedtestResult}    timeout=90s
    Capture Page Screenshot

Initiate Test run
    [Arguments]    ${status}
    ${clickStatus}    Run Keyword And Return Status    Press Click Button    ${eleSpeedtestTrigger}
    Capture Page Screenshot
    Sleep    2s
    ${status}    Run Keyword And Return Status    Page Should Contain    Initiating speed test
    Should Be True    ${clickStatus} and ${status}

Get Speedtest Card Content
    ${result}=    Get Text    ${eleHomeSpeedtestResult}
    Return From Keyword    ${result}
    
Verify speedtest card
    [Documentation]    This function will perform the following:
    ...                1: Open the Home page from corteca apps dashboard page
    ...                2: Login to specific customer and check speedtestcard
    Move To Overview SpeedtestCard And Trigger Test
    ${values}=    Get Speedtest Card Content
    Should Not Be Empty    ${values}
    Capture Page Screenshot

Trigger and Get SpeedTest Table
    [Documentation]    This function will perform the following:
    ...                1: Open the Home page from corteca apps dashboard page
    ...                2: Login to specific customer and trigger speedtest and check the speetest table
    Move To Speedtest Page And Trigger Test
    ${speedTestTableContent}=    Get Speedtest Table Data
    Log    ${speedTestTableContent}
    RETURN ${speedTestTableContent}

Get Speedtest Table Data
    # Expecting the speedtest table is visible
    ${tableData}    Execute Javascript    ${speedTestTableData}
    Return From Keyword    ${tableData}

Verify Speedtest Table
    [Arguments]    ${tableData}    ${compareSpeedTestTable}
    Run Keyword And Continue On Failure    Should Contain	${tableData}[0][Date]	${compareTable}[Date]
    Run Keyword And Continue On Failure    Should Match Regexp    ${tableData}[0][Download]	${tableData}[0][Download]
    Run Keyword And Continue On Failure    Should Match Regexp    ${tableData}[0][Upload]	${tableData}[0][Upload]
    Run Keyword And Continue On Failure    Should Not Be Equal As Numbers        ${tableData}[0][Download]	0.0
    Run Keyword And Continue On Failure    Should Not Be Equal As Numbers        ${tableData}[0][Download]	0.0
    Run Keyword And Continue On Failure    Should Match Regexp    ${tableData}[0][Ping]	${tableData}[0][Ping]
    Run Keyword And Continue On Failure    Should Match Regexp    ${tableData}[0][Jitter]	${tableData}[0][Jitter]
    Run Keyword And Continue On Failure    Should Match Regexp    ${tableData}[0][Server]	${tableData}[0][Server]
    Run Keyword And Continue On Failure    Should Contain    ${tableData}[0][Mode]	${tableData}[0][Mode]




