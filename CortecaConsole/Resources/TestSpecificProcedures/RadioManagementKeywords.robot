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
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource
Variables    ../../Locators/CortecaConsoleLocators.py
Variables    ../TestDatas.py
Variables    ../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py

*** Keywords ***
Move To RadioManagement Tab
    Log To Console    Click the radio management Tab
#    Wait Until Element Is Enabled    ${eleNewPortal}
#    Run Keyword If    ${HomeTroubleshooting}    Press Click Element    ${eleNewPortal}
    Wait Until Element Is Enabled    ${eleTroubleshootingRadioManagementTab}
    Press Click Element    ${eleTroubleshootingRadioManagementTab}
    Sleep    ${sleepMin}

Validate RadioManagement Page for Root and Extenders
    RadioManagementTab    ${Root}[udefi_frn_name]
    Run Keyword And Continue On Failure    RadioManagementPageValidation    ${Root}[model_L2]    Online    ${Root_bconType}
    FOR    ${extender}    IN    @{meshNodes}
         ${extFriendlyName}    Set Variable    ${${extender}}[udefi_frn_name]
         Log    ${extFriendlyName}
         RadioManagementTab    ${extFriendlyName}
         Sleep    ${sleepMin}
         Run Keyword And Continue On Failure    RadioManagementPageValidation    ${${extender}}[model_L2]    Online    ${${extender}_bconType}
     END

RadioManagementTab
    [Arguments]    ${deviceFriendlyName}
    Log To Console    Move to ${deviceFriendlyName}
    ${locator}    Replace String    ${eleTroubleshootingRadioManagementDeviceTab}    INDEX    ${deviceFriendlyName}
    ${status}    Run Keyword And Return Status    Press Click Element    ${locator}
    Capture Page Screenshot

RadioManagementPageValidation
    [Arguments]    ${deviceName}    ${status}    ${bconType}
    Log    Radio Management Page validation for ${deviceName}
    ${name}    Get Text    ${eleTroubleshootingRadioManagementDeviceName}
    ${deviceStatus}    Get Text    ${eleTroubleshootingRadioManagementDeviceStatus}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${deviceName}    ${name}    ignore_case=${True}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${status}    ${deviceStatus}    ignore_case=${True}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Check Element     ${eleTroubleshootingRadioManagementFeatureStatusCard}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Check Element    ${eleTroubleshootingRadioManagementCloudChannelManagement}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Check Element   ${eleTroubleshootingRadioManagementWiFiPointLocation}
    Capture Page Screenshot
    Check Wireless Settings Card in RadioManagementPage    ${bconType}
    Run Keyword If    '${DeviceStream}'=='HA'    Radio Management Card validation in HA    ${deviceName}
    Run Keyword If    '${DeviceStream}'=='USP'    Radio Management Card validation in USP    ${deviceName}


Radio Management Card validation in HA
    [Arguments]    ${deviceName}
    Log    Radio Management Page validation for ${deviceName}
    Run Keyword And Continue On Failure    Page Should Contain Element    ${eleTroubleshootingRadioManagementConnectivityConfiguration}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Page Should Contain Element    ${eleTroubleshootingRadioManagementHomeagentRestart}
    Capture Page Screenshot

Radio Management Card validation in USP
    [Arguments]    ${deviceName}
    Log    Radio Management Page validation for ${deviceName}
    Run Keyword And Continue On Failure    Page Should Not Contain Element    ${eleTroubleshootingRadioManagementConnectivityConfiguration}
    Run Keyword And Continue On Failure    Page Should Not Contain Element    ${eleTroubleshootingRadioManagementHomeagentRestart}
    Capture Page Screenshot

Check Wireless Settings Card in RadioManagementPage
    [Arguments]    ${bconType}
    ${WifiBandsList}=    Get the wifi band details    ${bconType}
    Log To Console    ${WifiBandsList}
    FOR    ${bands}    IN    @{WifiBandsList}
        Run Keyword And Continue On Failure    Check Element    ${eleTroubleshootingRadioManagementWireless${bands}Settings}
        Capture Page Screenshot
    END
    [Return]    ${WifiBandsList}

Validate Wireless settings card in Radio Management page
    Check Wireless Settings Card in RadioManagementPage    ${Root_bconType}
    Validate SSID Info in Portal and Device    ${Root_bconType}
    FOR    ${extender}    IN    @{meshNodes}
         Check Wireless Settings Card in RadioManagementPage    ${${extender}_bconType}
         Sleep    ${sleepMin}
         Run Keyword And Continue On Failure    Validate SSID Info in Portal and Device    ${${extender}_bconType}
    END

Validate SSID Info in Portal and Device
    [Arguments]    ${bconType}
    Get SSID Info from Portal    ${bconType}
    Get SSID Info from Device

Get SSID Info from Portal
    [Arguments]    ${bconType}
    ${BandList}=    Create List    24    5    5hb    6
    ${DeviceBand}=    Check wifi band    ${bconType}
    ${Band}=    Run Keyword If    '${DeviceBand}'=='Dual Band'    Set Variable    2
    ...    ELSE IF    '${DeviceBand}'=='Tri Band'    Set Variable    3
    ...    ELSE IF    '${DeviceBand}'=='Dual Band'    Set Variable    4
    FOR    ${i}    IN RANGE    ${Band}
        ${val}=    Run Keyword If    '${i}'=='2' and ('${bconType}'=='B10' or '${bconType}'=='B19')    Continue For Loop
        Run Keyword And Ignore Error	Check Element    css=ghz-settings[ghztype="ghz${${BandList}[${i}]}Setting"] form
        Capture Page Screenshot
        Log    GetSSIDDataPortal
        ${ReplacementString}    Replace String    "ghzINDEXSetting"  INDEX    ${BandList}[${i}]
        ${GetSSIDData}    Replace String    ${GetSSIDDataPortal}    INDEX    ${ReplacementString}
        ${SSIDDataPortal_${i}}    Execute Javascript    ${GetSSIDData}
        Log    ${SSIDDataPortal_${i}}
        Set Global Variable    ${SSIDDataPortal_${i}}
    END



Get SSID Info from Device
    Get Topology Data from Device




Get Topology Data from Device
    MeshElements
    ${output_socket}=    SSHExecute        ${curl}
    Log    ${output_socket}
    ${response}    Set Variable    ${output_socket}
    ${start_index}    Evaluate    """${response}""".find('{')
    ${json_data}    Get Substring    ${response}    ${start_index}
    ${regExMatch}    Set Variable If    '${Root_bconType}'=='B6'    root.*:.*#    \\[.*:.*#
    ${json_data}    Remove String Using Regexp    ${json_data}    ${regExMatch}
    ${topologyDict}    Convert String to JSON    ${json_data.strip()}
    Log    ${topologyDict}
    Set Test Variable    ${topologyDict}
    Return From Keyword    ${topologyDict}

    @{WifiBands}=    Create List
    Set Test Variable    @{WifiBands}
    @{WifiBands}    Set Variable    ${WifiBandList}[${DeviceBand}]
    Log    ${WifiBands}
    Return From Keyword    ${WifiBands}

    ${BandList}=    Create List    24    5    5hb    6
    ${DeviceBand}=    Check wifi band    ${bconType}
    ${Band}=    Run Keyword If    '${DeviceBand}'=='Dual Band'    Set Variable    2
    ...    ELSE IF    '${DeviceBand}'=='Tri Band'    Set Variable    3
    ...    ELSE IF    '${DeviceBand}'=='Dual Band'    Set Variable    4
    FOR    ${i}    IN RANGE    ${Band}
        ${val}=    Run Keyword If    '${i}'=='2' and ('${bconType}'=='B10' or '${bconType}'=='B19')    Continue For Loop
        Run Keyword And Ignore Error	Check Element    css=ghz-settings[ghztype="ghz${${BandList}[${i}]}Setting"] form
        Capture Page Screenshot
        Log    GetSSIDDataPortal
        ${GetSSIDData}    Replace String    ${GetSSIDDataPortal}    INDEX    "ghz${${BandList}[${i}]}Setting"
        ${SSIDDataPortal_${i}}    Execute Javascript    ${GetSSIDData}
        Log    ${SSIDDataPortal_${i}}
        Set Global Variable    ${SSIDDataPortal_${i}}
    END
