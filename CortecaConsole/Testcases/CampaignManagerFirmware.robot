*** Settings ***
Resource    ../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource    ../Resources/TestSpecificProcedures/CampaignManager/CampaignManagerFirmwareKeyword.robot
Variables    ../Resources/TestDatas.py
Library    Collections

*** Test Cases ***
BBDT-295181 NWCCL1BE_USP_Firmware_campaign_01
    [Documentation]    BBDT-295181 NWCC_L1BE_USP_Firmware_campaign_01 | Select Target WiFi point - root and extender same model - select any from firmware versions - download and activate same time - apply on boot disabled
    ...                ${\n}1: Action: In admin dashboard -> campaigns -> Firmware versions ,Create provision for model name by uploading the firmware Expected Result: Firmware uploaded
    ...                ${\n}2: Action: Click save  Expected Result: Provision is successful and should be listed. Group the list based on unique name and show
    ...                ${\n}3: Action: Create rule - Name, Select - Target WiFi point and select time zone ,Download firmware - frequency, duration , Activate firmware - Enable - Same Scheduler as download Expected Result: Rule created successfully
    ...                ${\n}4: Action: During scheduled time, extender should be get request for download and activate image 1st, followed by root Expected Result: Extender will get request 1st for activate and then root. Both root and extender should be upgraded     Check network history event for update status
    ...                ${\n}5: Check in rule -> rule trends - should show success count
    ...                ${\n}6: Download report -> both devices should be marked as completed and stage as activate
    [Tags]    USP  pvcase
    [Teardown]    Enable Disable Rule    ${campaignManagerFirmwareDict}[Name]    ${RuleName}    False
    Log    **** 1: In admin dashboard -> campaigns -> Firmware versions ****
    Login And Open Campaign Firmware Page
    Log    **** 2: Create provision for model name by uploading the firmware and Click save.Expected Result: Firmware uploaded ****
    Add A New Firmware Version    ${campaignManagerFirmwareDict}
    Log    **** 3: Create rule - Name, Select - Target WiFi point and select time zone,Download firmware - frequency, duration,Activate firmware - Enable - Same Scheduler as download ****
    ${RuleName}    Create A New Rule For Campaign Firmware    ${campaignManagerFirmwareDict}[Name]    ${NWCCL1BEUSPFirmwarecampaign01}
    Log    **** Created download schedule time as ${scheduleDownloadTime} and Activation time as same as download ****
    Log    **** Sleep for 2.5 hrs before validating the firmware upgrade success
    Sleep    9000
    Log    **** During scheduled time, extender should be get request for download and activate image 1st, followed by root Expected Result: Extender will get request 1st for activate and then root.Both root and extender should be upgraded (Checked using Kibana log timing) ****
    Run Keyword And Continue On Failure    Kibana Validation For Firmware Campaign    operation="download"
    Log    **** 5: Check in rule -> rule trends - should show success count ****
    Run Keyword And Continue On Failure    Rule Trend Validation Firmware    ${campaignManagerFirmwareDict}[Name]    ${RuleName}
    ${newFirmwareList}    Create List
    FOR    ${image}    IN    @{campaignManagerFirmwareDict}[GroupOfModel]
        Append To List    ${newFirmwareList}    ${image}[Firmware]
    END
    Log    ${newFirmwareList}
    Log    6: Download report -> both devices should be marked as completed and stage as activate
    Run Keyword And Continue On Failure    Rule Report Validation Firmware    ${campaignManagerFirmwareDict}[Name]    ${RuleName}    ${newFirmwareList}
