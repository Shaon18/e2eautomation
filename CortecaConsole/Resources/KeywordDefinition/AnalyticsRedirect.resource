*** Settings ***
Library         QWeb
Library         ../../Resources/commonPythonKeywords/checktable.py
Variables       ../../Locators/AnalyticsWifipointLocators.py

*** Keywords ***
Check_analytics_redirect
    Click Element    ${mac_link}
    Sleep  10s
    Verify Text     Device information   timeout=20s
    Verify Text     Connectivity information   timeout=20s
    Verify Text     Firmware  timeout=20s
