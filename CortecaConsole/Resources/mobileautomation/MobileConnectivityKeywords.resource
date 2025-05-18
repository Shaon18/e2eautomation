*** Settings ***
Resource    ../../Resources/KeywordDefinition/MobileAccessKeywords.resource
Variables    ../../InputFiles/EnvironmentInput.py

*** Keywords ***

Connect To Wi-Fi SSID
    [Arguments]    ${platformName}    ${deviceUUID}    ${devicePlatformVersion}    ${model}    ${ssid}    ${password}
    Start Appium Server
    Open Appium Session    ${appiumServer}    ${platformName}    ${deviceUUID}    ${devicePlatformVersion}    ${wifiSettingPackage}    ${wifiSettingPackageActivity}    ${automationName}
    Log    Connect To Wi-Fi In ${model}
    Run Keyword    Connect To Wi-Fi in ${model}    ${ssid}    ${password}
    [Teardown]    Stop Appium Server

Connect Disconnect WiFi
    [Arguments]    ${platformName}    ${deviceUUID}    ${devicePlatformVersion}    ${model}     ${enableStatus}=${True}
    Start Appium Server
    Open Appium Session    ${appiumServer}    ${platformName}    ${deviceUUID}    ${devicePlatformVersion}    ${wifiSettingPackage}    ${wifiSettingPackageActivity}    ${automationName}
    Log    DisconnectReconnect From Wi-Fi In ${model}
    Run Keyword    DisconnectReconnect From Wi-Fi In ${model}     ${enableStatus}
    [Teardown]    Stop Appium Server