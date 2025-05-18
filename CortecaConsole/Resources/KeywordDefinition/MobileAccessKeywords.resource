*** Settings ***
Library    Process
Library    AppiumLibrary
Library    OperatingSystem
Library    Collections
Library    String
*** Keywords ***
Start Appium Server
#    OperatingSystem.Run    cmd /c start appium    # Start the Appium server
    Start Process    appium    shell=True    stdout=appium_log.txt    stderr=appium_err.txt    alias=appium
    Sleep    5s

Stop Appium Server
#    OperatingSystem.Run    taskkill /F /IM node.exe    # For Windows users to stop Appium server
    Terminate All Processes
       
Open Appium Session
    [Arguments]    ${appiumServer}    ${platformName}    ${deviceUUID}    ${devicePlatformVersion}    ${appPackage}    ${appActivity}    ${automationName}=UiAutomator2
    Log To Console    Open application
    Open Application    ${appiumServer}    platformName=${platformName}    deviceName=${deviceUUID}    platformVersion=${devicePlatformVersion}    appPackage=${appPackage}    appActivity=${appActivity}    automationName=${automationName}

Open Wi-Fi Settings In SamsungM325
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='Connections']    10s
    Click Element    xpath=//android.widget.TextView[@text='Connections']
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='Wi-Fi']   10s
    Click Element    xpath=//*[@resource-id="android:id/title"]

Connect To Wi-Fi In SamsungM325
    [Arguments]    ${ssid}    ${password}
    Open Wi-Fi Settings In SamsungM325
    Sleep    5s
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='${ssid}']    10s
    Click Element    xpath=//android.widget.TextView[@text='${ssid}']
    Run Keyword And Ignore Error    Hide Keyboard
    Sleep    2s
#    Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id='com.android.settings:id/input_password']    10s
#    Click Element    xpath=//*[@resource-id='com.android.settings:id/input_password']
    Input Text    xpath=//*[@resource-id='com.android.settings:id/input_password']    ${password}
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='View more']    10s
    Click Element    xpath=//android.widget.TextView[@text='View more']
    Hide Keyboard
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='MAC address type']    10s
    Click Element    xpath=//android.widget.TextView[@text='MAC address type']
    Sleep    2s
    Wait Until Page Contains Element    xpath=//android.widget.CheckedTextView[@text='Phone MAC']    10s
    Click Element    xpath=//android.widget.CheckedTextView[@text='Phone MAC']
    Click Element    xpath=//android.widget.Button[@text='Connect']

DisconnectReconnect From Wi-Fi In SamsungM325
    [Arguments]    ${enableStatus}
    Open Wi-Fi Settings In SamsungM325
    Sleep    2s
    ${enableStatus}    Convert To String    ${enableStatus}
    ${enableStatus}    Convert To Lower Case    ${enableStatus}
    ${status}=    Get Element Attribute    xpath=//android.widget.Switch[contains(@resource-id, 'switch_widget')]    checked
    ${status}    Convert To Lower Case    ${status}
    Return From Keyword If    '${status}'=='${enableStatus}'
    Run Keyword If    '${enableStatus}'=='true'    Enable WiFi In SamsungM325    ELSE    Disable WiFi In SamsungM325
    ${status}=    Get Element Attribute    xpath=//android.widget.Switch[contains(@resource-id, 'switch_widget')]    checked
    ${status}    Convert To Lower Case    ${status}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${status}    ${enableStatus}
    
Enable WiFi In SamsungM325
    Wait Until Page Contains Element    xpath=//android.widget.Switch[@text='Off']    10s
    Click Element    xpath=//android.widget.Switch[@text='Off']    # Turn on Wi-Fi

Disable WiFi In SamsungM325
    Wait Until Page Contains Element    xpath=//android.widget.Switch[@text='On']    10s
    Click Element    xpath=//android.widget.Switch[@text='On']    # Turn OFF Wi-Fi
   