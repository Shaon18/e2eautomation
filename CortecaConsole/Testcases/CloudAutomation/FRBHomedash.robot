*** Settings ***
Library         QWeb
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource
Variables       ../../Locators/DeploymentreportLocators.py
Variables       ../../Locators/AdvancedSettings.py
Resource         ../../Resources/KeywordDefinition/AdvancedSettings.resource
Resource         ../../Resources/TestDatas.py
*** Variables ***

&{seen_classes}  # Dictionary to track seen Productclass values

*** Test Cases ***
prerequisite
    [Documentation]    Triggering this script will create a firmware file for the respective device given in argument file. new variables needed for this script are ${Root}[firmware_file_name_inDownloads], ${Root}[firmware_new_version], ${Ext1}[firmware_file_name_inDownloads] and ${Ext1}[firmware_new_version]
    Create Firmware file in campaign    ${Root}[Productclass]   ${Root}[firmware_file_name_inDownloads]   ${firmware_file_description}   ${Root}[firmware_new_version]
    FOR    ${i}    IN    @{meshNodes}
        ${product_class}=    Set Variable    ${i}[Productclass]
        IF    "${product_class}" not in ${seen_classes.keys()}
                 Create Firmware file in campaign    ${i}[Productclass]     ${i}[firmware_file_name_inDownloads]     ${firmware_file_description}      ${i}[firmware_new_version]
                 Set To Dictionary    ${seen_classes}    ${product_class}=${True}
        END

    END
BBDT-162652 NWCC_AIOC_HomeDashboard_Firmware_root
    [Documentation]    Triggering this script will Upgrade the Root build from settings page. new variables needed for this script are ${Root}[firmware_file_name_inDownloads] , ${Root}[firmware_new_version], ${Ext1}[firmware_file_name_inDownloads] and ${Ext1}[firmware_new_version]
    Upgrade Firmware From Settings  ${Root}[mac]   ${Root}[firmware_file_name_inDownloads]    ${settings_verify_upgrade_initiated_root}    ${settings_verify_upgrade_success_root}   ${meshNodescount}  ${Root}[firmware_new_version]

BBDT-162652 NWCC_AIOC_HomeDashboard_Firmware_ext
    [Documentation]    Triggering this script will Upgrade the Extender build from settings page. new variables needed for this script are ${Root}[firmware_file_name_inDownloads] , ${Root}[firmware_new_version], ${Ext1}[firmware_file_name_inDownloads] and ${Ext1}[firmware_new_version]
    FOR    ${i}    IN    @{meshNodes}
           Upgrade Firmware From Settings  ${i}[mac]   ${i}[firmware_file_name_inDownloads]    ${settings_verify_upgrade_initiated_root}    ${settings_verify_upgrade_success_root}   ${meshNodescount}  ${i}[firmware_new_version]
    END
BBDT-162652 NWCC_AIOC_HomeDashboard_Firmware_backup
    [Documentation]    Triggering this script will backup the device from setting page.After backup It will change timezone and create an SSID via console to check if restore is proper, trigger this case before restore.
    LoginTobrowserqweb
    Click Text   Home troubleshooting
    SearchSetupConsole   ${Root}[mac]
    Sleep   30s
    Click Element   ${home_settings_button}
    Click Text   Backup
    IF  '${DeviceStream}'=='USP'
        Click Text   deviceDB
        Click Text   Fetch Backup
    ELSE
        Click Text   Fetch Backup
    END
    Click Text   Backup    anchor= proceed
    Verify All   Device Backup Initiated successfully
    Verify All   Device Backup is successful    timeout=300s
    SSHExecute   ${ChangeDeviceTimezoneCli}
    Create SSID via console

BBDT-162652 NWCC_AIOC_HomeDashboard_Firmware_restore
    [Documentation]    Triggering this script will Restore the device config. It will also check if the Timezone and ssid are reverted back.
    LoginTobrowserqweb
    Click Text   Home troubleshooting
    SearchSetupConsole   ${Root}[mac]
    Verify All    ${DefPortalTimezonechange}   timeout=300s
    Sleep   30s
    Click Element   ${home_settings_button}
    Click Text    Restore   timeout= 60s
    Click Text    ${restore_version}
    Click Element    ${firmware_upgrade_button}
    Click Text    Restore  anchor= Cancel
    Click Element   ${network_history_page_nav}
    Verify Text      Root WiFi point is offline.    timeout= 300s
    Verify No Text   Root WiFi point is offline.      timeout= 600s
    Click Element   ${overview_page_nav}
    Click Element   ${network_history_page_nav}
    Verify All    	Restore initiated     timeout=60s
    Verify All      Restore success    timeout=160s
    Click Element   ${overview_page_nav}
    Verify All    ${DefPortaTimezone}   timeout=300s

    Check SSID in console     false

