*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Telnet
Library    Collections
Library    JSONLibrary
Library    HttpLibrary.HTTP
Resource    LoginPageProcedures.robot
Resource     ../KeywordDefinition/CommonKeywords.robot
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/CortecaConsoleLocators.py
Variables    ../TestDatas.py
Variables    ../JavaScriptCodes/executeJavaScriptCodeCorteca.py

*** Keywords ***

Check Ping Test Functionality
    Move To Pingtest Page
    Check default server and trigger test
    FOR    ${url}    IN    @{ListofPingUrls}
        Trigger Ping and Validate    ${url}
    END

Move To Pingtest Page
    Open Corteca Console Home Page
#    Press Click Element     ${eleNewPortal}
    Press Click Element    ${eleSpeedtestTab}
    Sleep    ${sleepMin}
    Wait Until Element Is Enabled    ${eleNewPingTest}   timeout= 120s
    Run Keyword    Page Should Contain Element    ${elePingTestCardHdr}
    Capture Page Screenshot

Check default server and trigger test
    ${result}=    SeleniumLibrary.Get Value    ${elePingURL}
    ${status}    Run Keyword And Return Status    Page Should Contain    ${Testnotruntext}
    Run Keyword If    ${status}    should contain    ${result}    ${defaultserverurl}
    Trigger Ping and Validate    ${defaultserverurl}

Trigger Pingtest
    ${status}    Set Variable    False
    Wait Until Keyword Succeeds    0.05s    6 second    Initiate Ping Test run    ${status}
    Wait Until Element Is Visible    ${eleNewPingTest}    timeout=90s
    Capture Page Screenshot

Initiate Ping Test run
    [Arguments]    ${status}
    ${clickStatus}    Run Keyword And Return Status    Press Click Button    ${eleNewPingTest}
    Capture Page Screenshot
    ${status}    Run Keyword And Return Status    Page Should Contain    Initiating ping test
    Sleep    ${sleepMax}
    Should Be True    ${clickStatus} and ${status}

Verify Pingtest card
    [Documentation]    This function will perform the following:
    ...                1: Open the Home page from corteca apps dashboard page
    ...                2: Login to specific customer and check speedtestcard
    ${result}=    Get Text    ${eleHomePingtestResult}
    Should Not Be Empty    ${result}
    Capture Page Screenshot

Ping Test Data
    [Arguments]    ${url}
    Enter Value    ${eleInputPingUrl}    ${url}
    Trigger Pingtest
    Verify Pingtest card
    Log    Get the ping test data
    ${Average}=    Get Text    ${eleAveragepingval}
    ${Minimum}=    Get Text    ${eleMinimumpingval}
    ${Maximum}=    Get Text    ${eleMaximumpingval}
    ${PingTestdatainCard}=    Create Dictionary
    Set To Dictionary    ${PingTestdatainCard}    Average ms    ${Average}    Minimum ms    ${Minimum}    Maximum ms    ${Maximum}
    Log    ${PingTestdatainCard}
    Set Global Variable    ${PingTestdatainCard}

Ping History Data
    ${tableData}    Execute Javascript    ${PingTestTableData}
    Return From Keyword    ${tableData}

Ping Validate
    [Arguments]    ${tableData}    ${PingTestdatainCard}
    ${Comparedict}=    Run Keyword And Return Status    Dictionary Should Contain Sub Dictionary    ${PingTestdatainCard}    ${tableData}
    ${Comparedict}=    Convert To String    ${Comparedict}
    Log    ${Comparedict}
    Run Keyword And Continue On Failure     Should Be Equal    ${Comparedict}    True

Ping Check in HA
    [Arguments]    ${tableData}    ${PingTestdatainCard}
    Run Keyword And Continue On Failure     should contain    ${tableData}[Minimum ms]    NA
    Run Keyword And Continue On Failure     should contain    ${tableData}[Maximum ms]    NA
    Run Keyword And Continue On Failure     should contain    ${PingTestdatainCard}[Minimum ms]    NA
    Run Keyword And Continue On Failure     should contain    ${PingTestdatainCard}[Maximum ms]    NA

Ping Check in USP
    [Arguments]    ${tableData}    ${PingTestdatainCard}
    Run Keyword And Continue On Failure    should not contain    ${tableData}[Minimum ms]    NA
    Run Keyword And Continue On Failure    should not contain    ${tableData}[Maximum ms]    NA
    Run Keyword And Continue On Failure    should not contain    ${PingTestdatainCard}[Minimum ms]    NA
    Run Keyword And Continue On Failure    should not contain    ${PingTestdatainCard}[Maximum ms]    NA
    ${Value}=    Convert To String    ${PingTestdatainCard}[Minimum ms]
    Run Keyword And Continue On Failure    Should Match Regexp   ${Value}   ^[0-9]*\\d
    ${Value}=    Convert To String    ${PingTestdatainCard}[Maximum ms]
    Run Keyword And Continue On Failure    Should Match Regexp   ${Value}   ^[0-9]*\\d

Trigger Ping and Validate
    [Arguments]    ${url}
    Ping Test Data    ${url}
    sleep    ${sleepMin}
    ${tableData}=    Ping History Data
    sleep    ${sleepMin}
    Ping Validate    ${PingTestdatainCard}    ${tableData}
    Run Keyword And Continue On Failure    Should Contain	${url}	${tableData}[Server]
    Run Keyword If    '${DeviceStream}'=='HA'    Ping Check in HA   ${PingTestdatainCard}    ${tableData}
    Run Keyword If    '${DeviceStream}'=='USP'    Ping Check in USP   ${PingTestdatainCard}    ${tableData}
    sleep    ${sleepMin}

Trigger Ping test for 30 times
    ${status}    Set Variable    False
    FOR    ${i}    IN RANGE    1    30
        Wait Until Keyword Succeeds    280s    6 second    Initiate Ping Test run    ${status}
        sleep    ${sleepMin}
    END
    Wait Until Element Is Visible    ${eleNewPingTest}    timeout=90s
    Capture Page Screenshot
    Log    Click page dropdown to 30
    Run Keyword And Continue On Failure    Click Element     ${elePingPagedropdown}
    sleep    ${sleepMin}
    Run Keyword And Continue On Failure    Click Element     ${elePingPagedropdown30}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Check last 30 ping test in Table

Check last 30 ping test in Table
    ${tableDataCount}    Execute Javascript    ${PingTestTableData1}
    ${Value}=    Convert To String    ${tableDataCount}
    Run Keyword    Should Be Equal    ${Value}    ${RowCount}

Check pagination in ping test history table
    ${locator}    Replace String    ${PingCustomerPagePagination}    SELECTOR    "${elePingCustomerPagePagination}"
    ${locator1}    Replace String    ${PingCustomerPagePaginationArrow}    SELECTOR    "${elePingCustomerPagePaginationArrow}"
    ${Total}    Execute Javascript    ${locator}
    Run Keyword and Continue on failure    Should Contain    ${Total}    1 - 30 of
    ${Total}    Fetch from right    ${Total}    of
    Strip String    ${Total}
    Log    Pagination count: ${Total}
    ${val}    Evaluate    ${Total}/30
    ${val}    Convert to String    ${val}
    Log    ${val}
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
    ${locator2}    Replace String    ${locator1}    INDEX    3
    ${sub_status}=    Execute Javascript    ${locator2}
    Run Keyword and continue on failure    Should Not Be Equal    ${sub_status}    true
