*** Settings ***
Library         QWeb
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource
Variables       ../../Locators/DeploymentreportLocators.py
Variables       ../../Locators/AdvancedSettings.py
Variables       ../../Resources/JavaScriptCodes/cloudautomationJavaScriptCode.py
*** Keywords ***
Create SSID via console
    Click Text    Wireless 2.4 GHz   timeout=60s
    Verify All    WPA Key   timeout=300s
    Click Element    ${ssid_input_index}
    Click Text    4   anchor= SSID Index
    Click Element    ${ssid_enable_slider}
    Click Element    ${ssid_config_save}
    Verify All    Success    timeout=120s

Check SSID in console
    [Arguments]      ${exists}
    IF    '${exists}' == 'true'
         Click Element   ${home_settings_button}
         Click Text    Wireless 2.4 GHz   timeout=60s
         Verify All    WPA Key   timeout=300s
         Click Element    ${ssid_input_index}
         Click Text    4   anchor= SSID Index
         ${status} =    Qw.ExecuteJavaScript    [0].checked    ${validate_enable_ssid_slider}
         Should Be True    ${status}
    ELSE
         Click Element   ${home_settings_button}
         Click Text    Wireless 2.4 GHz   timeout=60s
         Verify All    WPA Key   timeout=300s
         Click Element    ${ssid_input_index}
         Click Text    4   anchor= SSID Index
         ${status} =    Qw.ExecuteJavaScript    [0].checked    ${validate_enable_ssid_slider}
         Should not Be True    ${status}
    END

Upgrade Firmware From Settings
    [Arguments]      ${device_name}   ${firmware_file_name}    ${verify_initiated_text}    ${verify_success_text}   ${mesh_check}  ${firmware_version}
    LoginTobrowserqweb
    Click Text   Home troubleshooting
    SearchSetupConsole   ${Root}[mac]
    Sleep   30s
    QWeb.Click Element   ${home_settings_button}
    Click Text   Firmware Update
    QWeb.Click Element    ${firmware_upgrade_dropdown}
    Click Text    ${device_name}
    Sleep   30s
    Click Text   ${firmware_file_name}
    QWeb.Click Element   ${firmware_upgrade_button}
    Click Text   Upgrade
    QWeb.Click Element   ${network_history_page_nav}
    Verify All   ${verify_initiated_text}    timeout=60s
    Verify Text      Root WiFi point is offline.    timeout= 300s
    Verify No Text   Root WiFi point is offline.      timeout= 600s
    QWeb.Click Element   ${overview_page_nav}
    QWeb.Click Element   ${network_history_page_nav}
    Verify All   ${verify_success_text}    timeout=60s
    QWeb.Click Element    ${network_page_nav}
    Verify Text Count    Online   ${mesh_check}    timeout=20s
    Click Text    ${device_name}
    Verify All    ${firmware_version}

Create Firmware file in campaign
   [Arguments]      ${device_name}   ${firmware_file_name}   ${firmware_description}   ${firmware_version}
   LoginTobrowserqweb
   Click Text   Admin
   Click Text    Campaigns
   Click Text    Firmware versions
   sleep   5s
   QWeb.Click Element    ${add_new_firmware}
   sleep   5s
   Type Text    ${add_new_firmware_name_input}    ${firmware_file_name}
   Type Text    ${add_new_firmware_description_input}    ${firmware_description}
   QWeb.Click Element    ${add_new_firmware_hardware}
   Click Text    ${device_name}   anchor=Hardware model
   Type Text    ${add_new_firmware_version}    ${firmware_version}
   Upload File   Choose File  ${firmware_file_name}   anchor= Firmware image
   sleep   5s
   Click Text    SAVE  anchor=Choose File
   Verify Text    Success      timeout= 300s
   QWeb.closebrowser