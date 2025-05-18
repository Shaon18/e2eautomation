*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Telnet
Library    Process
Library    Collections
Library    JSONLibrary
Library    HttpLibrary.HTTP
Resource    LoginPageProcedures.robot
Resource     ../KeywordDefinition/CommonKeywords.robot
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/CortecaConsoleLocators.py
Variables    ../TestDatas.py
Variables    ../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py

*** Keywords ***

Move To AdvancedMetrics Tab
    Log To Console    Click the Advanced Metrics Tab
#    Run Keyword If    ${HomeTroubleshooting}    Press Click Element    ${eleNewPortal}    300s
    ${Check}=    Wait Until Element Is Enabled    ${eleTroubleshootingAdvancedMetricsTab}
    Press Click Element    ${eleTroubleshootingAdvancedMetricsTab}
    Sleep    20s

Validate Advanced Metrics Page for Root and Extenders
    AdvancedMetricsTab    ${Root}[udefi_frn_name]
    Run Keyword And Continue On Failure    AdvancedMetricsPageValidation    ${Root}[model_L2]    Online    ${Root_bconType}
    FOR    ${extender}    IN    @{meshNodes}
         ${extFriendlyName}    Set Variable    ${${extender}}[udefi_frn_name]
         Log    ${extFriendlyName}
         AdvancedMetricsTab    ${extFriendlyName}
         Sleep    ${sleepMin}
         Run Keyword And Continue On Failure    AdvancedMetricsPageValidation    ${${extender}}[model_L2]    Online    ${${extender}_bconType}
     END

AdvancedMetricsTab
    [Arguments]    ${deviceFriendlyName}
    Log To Console    Move to ${deviceFriendlyName}
    ${locator}    Replace String    ${eleTroubleshootingAdvancedMetricsDeviceTab}    INDEX    ${deviceFriendlyName}
#    ${status}    Run Keyword And Return Status    Press Click Element    ${locator}
#    Run Keyword If    not ${status}    Click Element    ${eleCustomerInfoCardExpand}
#    Sleep    ${sleepMin}
    ${status}    Run Keyword And Return Status    Press Click Element    ${locator}
#    Run Keyword If    not ${status}    Click Element    ${eleTroubleshootingExpand}
#    Sleep    ${sleepMin}
#    Run Keyword If    not ${status}    Click Element    ${eleTroubleshootingAdvancedMetricsTab}}
#    ${status}    Run Keyword And Return Status    Press Click Element    ${locator}
    Sleep    ${sleepMin}
#    Run Keyword If    not ${status}    Press Click Element    ${locator}
#    Sleep    ${sleepMax}
    Capture Page Screenshot

AdvancedMetricsPageValidation
    [Arguments]    ${deviceName}    ${status}    ${bconType}
    Log    Advanced Metric Page validation for ${deviceName}
    ${name}    Get Text    ${eleTroubleshootingAdvancedMetricsDeviceName}
    ${deviceStatus}    Get Text    ${eleTroubleshootingAdvancedMetricsDeviceStatus}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${deviceName}    ${name}    ignore_case=${True}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${status}    ${deviceStatus}    ignore_case=${True}
    Capture Page Screenshot
    Check Bandwise AdvancedMetricsPage Validation    ${bconType}

Check Bandwise AdvancedMetricsPage Validation
    [Arguments]    ${bconType}
    ${WifiBandsList}=    Get the wifi band details    ${bconType}
    ${Count}=    Get Length    ${WifiBandsList}
    Log    ${Count}
    ${Count}=    Convert To String    ${Count}
    FOR    ${i}   IN RANGE   1    ${Count}
        ${i}=    Convert To String    ${i}
        ${locator}    Replace String    ${eleTroubleshootingAdvancedMetricsBand}    INDEX    ${i}
        Run Keyword And Continue On Failure    Check Element     ${locator}
        Capture Page Screenshot
        Run Keyword And Continue On Failure    Click Element    ${locator}
        sleep    ${sleepMin}
        Run Keyword And Continue On Failure    Check Element    ${eleTroubleshootingAdvancedMetricsLastReport}
        Run Keyword And Continue On Failure    Check Element    ${eleTroubleshootingAdvancedMetricsDevices}
        Run Keyword And Continue On Failure    Check Element    ${eleTroubleshootingAdvancedMetricsDownloadAverage}
        Run Keyword And Continue On Failure    Check Element    ${eleTroubleshootingAdvancedMetricsUploadAverage}
        Capture Page Screenshot
        sleep    ${sleepMin}
        ${Count}=    Get Length    ${AdvancedMetricsGraphHeader}
        Log    ${Count}
        ${Count}    Evaluate    ${Count} - 1
        FOR    ${i}    IN RANGE    0    ${Count}
            Check Graph header    ${AdvancedMetricsGraphHeader}[${i}]   ${AdvancedMetricsGraphlocater}[${i}]
            sleep    ${sleepMin}
        END
    END

Check Graph Header
    [Arguments]    ${header}    ${locator}
    Log    Advanced Metrics Page Graph Header Validation
    Run Keyword And Continue On Failure    Check Element    ${eleTroubleshootingAdvancedMetrics${locator}}
    ${Text}=    Run Keyword And Continue On Failure    Get Text    ${eleTroubleshootingAdvancedMetrics${locator}}
    Run Keyword And Continue On Failure    Should Be Equal As Strings        ${Text}    ${header}
    Capture Page Screenshot

Validate Advanced Metrics Page Graph for Root and Extenders
    AdvancedMetricsTab    ${Root}[udefi_frn_name]
    Run Keyword And Continue On Failure    AdvancedMetricsPageGraphValidation    ${Root}[model_L2]    Online    ${Root_bconType}
    FOR    ${extender}    IN    @{meshNodes}
         ${extFriendlyName}    Set Variable    ${${extender}}[udefi_frn_name]
         AdvancedMetricsTab    ${extFriendlyName}
         Sleep    ${sleepMin}
         Run Keyword And Continue On Failure    AdvancedMetricsPageGraphValidation    ${${extender}}[model_L2]    Online    ${${extender}_bconType}
    END

AdvancedMetricsPageGraphValidation
    [Arguments]    ${deviceName}    ${status}    ${bconType}
    Log    Advanced Metrics Page Graph validation for ${deviceName}
    ${WifiBandsList}=    Get the wifi band details    ${bconType}
    ${Count}=    Get Length    ${WifiBandsList}
    ${Count}=    Evaluate    ${Count} + 1
    Log    ${Count}
    ${Count}=    Convert To String    ${Count}
    Log    Advanced Metrics Page Graph validation for each Band
    FOR    ${i}   IN RANGE    1    ${Count}
        ${i}=    Convert To String    ${i}
        ${locator}    Replace String    ${eleTroubleshootingAdvancedMetricsBand}    INDEX    ${i}
        Run Keyword And Continue On Failure    Check Element     ${locator}
        Capture Page Screenshot
        Run Keyword And Continue On Failure    Click Element    ${locator}
        sleep    ${sleepMin}
        Capture Page Screenshot
        ${Count}=    Get Length    ${AdvancedMetricsGraphHeader}
        ${Count}=    Evaluate    ${Count} + 1
        Log    ${Count}
        ${Count}=    Convert To String    ${Count}
        Log    Advanced Metrics Page Graph validation plot check
        FOR    ${i}    IN RANGE   1    ${Count}
            ${i}=    Convert To String    ${i}
            ${locator}    Replace String    ${eleAdvancedMetricsGraphHighChart}    INDEX    ${i}
            ${locator1}    Replace String    ${eleAdvancedMetricsGraphTooltip}    INDEX    ${i}
            ${GraphValues}=    Fetch SVG Graph Values from Advanced Metrics    ${locator}    ${locator1}
            Log    ${GraphValues}
            ${GraphValues1}=    Run Keyword And Continue On Failure    Remove values from list    ${GraphValues}    None
            Log    ${GraphValues}
            Run Keyword And Continue On Failure    Should Not Be Empty    ${GraphValues}
            Capture Page Screenshot
            sleep    ${sleepMin}
        END
        Log    Advanced Metrics Page Graph Y - axis metrics measurement check
        Check Y-axis metric measurement
        Sleep    ${sleepMin}
        Log    Advanced Metrics Page Download CSV file
        #Download CSV file
    END

Check Y-axis metric measurement
    ${Count}=    Get Length    ${AdvancedMetricsGraphHeader}
    Log    ${Count}
    ${Count}=    Convert To String    ${Count}
    Log    Check Advanced Metrics Graph Yaxis metric for each parameter
    FOR    ${i}    IN RANGE   1    ${Count}
        ${i}=    Convert To String    ${i}
        ${locator}    Replace String    ${eleAdvancedMetricsYAxisMeasurement}    INDEX    ${i}
        ${YaxisMeasurement}=    Run Keyword    Get Text    ${locator}
        ${val}=    Evaluate    ${i}-1
        Run Keyword And Continue On Failure    Should Contain    ${YaxisMeasurement}    ${AdvancedMetricsMeasurementYAxis}[${val}]
        sleep    ${sleepMin}
    END

Download CSV file
    Log    Download the CSV file from Advanced Metrics Page.
    Run Keyword    Click Element    ${eleAdvancedMetricsDownloadCSVButton}
    sleep    ${sleepMin}
    ${check}=    Run Keyword And Continue On Failure    Check Element    ${eleAdvancedMetricsDownloadCSVpopup}
    ${ExportFile}=    Run Keyword If    ${check}    Run Keyword    ${eleAdvancedMetricsDownloadCSVExport}
    sleep    ${sleepMin}
    Should Be True    ${ExportFile}