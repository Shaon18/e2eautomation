*** Settings ***
Library         QWeb
Library         String
Library         Collections
Library         ../../Resources/commonPythonKeywords/libwrap.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/KeywordDefinition/ApiRequest.resource
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource
Resource        ../../Resources/KeywordDefinition/ApiRequest.resource
Resource         ../../Resources/KeywordDefinition/AdvancedSettings.resource
Variables       ../../InputFiles/sampleSetupFileFormat_G-2425-GA.py
Variables       ../../Resources/JavaScriptCodes/cloudautomationJavaScriptCode.py
Variables       ../../Locators/DeploymentreportLocators.py

*** Test Cases ***
NWCC_L1_NWCC_specificfeature_Admin_Deploymentreport_01
     LoginTobrowserqweb
     Log To Console    moving to admin page
     Qwebelement.clicktext    Admin
     Click Element     ${deployment_report_page_link}
     sleep    5s
     Click Element    ${deployment_report_download_button}
     Sleep    10s
     ${res}=    Macpresentdeployment
     Should Be Equal    ${res}     False
     
     
NWCC_L1_NWCC_specificfeature_Admin_Deploymentreport_02
     LoginTobrowserqweb
     Log To Console    moving to admin page
     Qwebelement.clicktext    Admin
     Click Element    ${deployment_report_page_link}
     sleep    5s
     Click Element    ${model_input_dropdown}
     Scroll To      ${campaignManagerFirmware}[HwModel]       ${model_scroll}       scroll_length=100
     Click Text    ${campaignManagerFirmware}[HwModel]
     Click Element    ${deployment_report_download_button}
     Sleep    5s
     ${res}=    Macpresentdeployment
     Should Be Equal    ${res}     False
     Click Element    ${sw_input_dropdown}
     Click Text    ${campaignManagerFirmware}[Name]
     Click Element    ${deployment_report_download_button}
     Sleep    5s
     ${res}=    Macpresentdeployment
     Should Be Equal    ${res}    False

NWCC_L1_NWCC_specificfeature_Admin_Deploymentreport_04
     LoginTobrowserqweb
     Log To Console    moving to admin page
     Qwebelement.clicktext    Admin
     Click Element    ${deployment_report_page_link}
     sleep    5s
     Click Element    ${status_input_dropdown}
     Click Text    Online
     Click Element    ${deployment_report_download_button}
     Sleep    5s
     ${res}=    Macpresentdeployment
     Should Be Equal    ${res}    False
     Click Element      ${model_input_dropdown}
     Scroll To      ${campaignManagerFirmware}[HwModel]       ${model_scroll}       scroll_length=100
     Click Text    ${campaignManagerFirmware}[HwModel]
     Click Element    ${deployment_report_download_button}
     Sleep    5s
     ${res}=    Macpresentdeployment
     Should Be Equal    ${res}     False

NWCC_L1_NWCC_specificfeature_Admin_Deploymentreport_07
     LoginTobrowserqweb
     Log To Console    moving to admin page
     Qwebelement.clicktext    Admin
     Log To Console    moving to device ranking page
     Click Element    ${deployment_report_page_link}
     sleep    5s
     Click Element    ${status_input_dropdown}
     Click Text    Offline
     Click Element    ${deployment_report_download_button}
     Sleep    5s
     ${res}=    Macpresentdeployment
     Should Be Equal    ${res}    False
     Click Element     ${model_input_dropdown}
     Scroll To      ${campaignManagerFirmware}[HwModel]       ${model_scroll}       scroll_length=100
     Click Text    ${campaignManagerFirmware}[HwModel]
     Click Element    ${deployment_report_download_button}
     Sleep    5s
     ${res}=    Macpresentdeployment
     Should Be Equal    ${res}     False
     Click Element    ${sw_input_dropdown}
     Click Text    ${campaignManagerFirmware}[Name]
     Click Element    ${deployment_report_download_button}
     Sleep    5s
     ${res}=    Macpresentdeployment
     Should Be Equal    ${res}    False

NWCC_L1_NWCC_specificfeature_Admin_Deploymentreport_10 | Provision device but dont connect to cloud
     LoginTobrowserqweb
     Log To Console    moving to admin page
     Qwebelement.clicktext    Admin
     wifipoint_provision_API    ${Root}[mac1]      ${Root}[ssid_defa_password]
     Click Element    ${deployment_report_page_link}
     sleep    5s
     Click Element    ${status_input_dropdown}
     Click Text     Never
     Click Element    ${deployment_report_download_button}
     Sleep    5s
     ${res}=    Macpresent   ${Root}[mac1]
     Should Be Equal    ${res}    True

NWCC_L1_NWCC_specificfeature_Admin_Deploymentreport_11
     wifipoint_provision_API    ${Root}[mac1]       ${Root}[ssid_defa_password]
     cloud_account_create     ${Root}[mac1]
     LoginTobrowserqweb
     Log To Console    moving to admin page
     Qwebelement.clicktext    Admin
     Click Element    ${deployment_report_page_link}
     sleep    5s
     Click Element     ${deployment_report_download_button}
     Sleep    5s
     ${res}=    Macpresent    ${Root}[mac1]
     Should Be Equal    ${res}    True



#add check the reboot time is ==  current date
#particular device offline and online
#never connected -->  cloud cleanup --> delete provisioin> provsio> check mac in nver> bringup> no mac present

NWCC_L1_NWCC_specificfeature_Admin_Deploymentreport_reboot_device_date
     SSHExecute     ${Root}[ip]   ${Root}[telnet_vtysh]    reboot
     sleep  600s
     LoginTobrowserqweb
     Log To Console    moving to admin page
     Qwebelement.clicktext    Admin
     Log To Console    moving to deployment report page
     Click Element     ${deployment_report_page_link}
     sleep    5s
     Click Element    ${deployment_report_download_button}
     Sleep    10s
     ${res}=    check_deployment_reboot_date    ${Root}[mac1]
     Should Be Equal    ${res}    True

NWCC_L1_NWCC_specificfeature_Admin_Deploymentreport_particular_device_status
     SSHExecute   ${Root}[ip]    ${Root}[telnet_vtysh]    reboot
     sleep  120s
     LoginTobrowserqweb
     Qwebelement.clicktext    Admin
     Log To Console    moving to deployment report page
     Click Element     ${deployment_report_page_link}
     sleep    5s
     Click Element    ${deployment_report_download_button}
     Sleep    10s
     check_deployment_mac_status     FALSE

NWCC_L1_NWCC_specificfeature_Admin_Deploymentreport_neverconnected
     delete_mac_provision  ${Root}[mac]
     SSHExecute   ${Root}[ip]    ${Root}[telnet_vtysh]    cfgcli -rall
     LoginTobrowserqweb
     Log To Console    moving to admin page
     Qwebelement.clicktext    Admin
     Log To Console    moving to deployment report page
     Click Element     ${deployment_report_page_link}
     sleep    5s
     Click Element    ${status_input_dropdown}
     Click Text    Never Connected
     sleep    5s
     Click Element    ${deployment_report_download_button}
     Macpresent    ${Root}[mac]
     sleep  600s





