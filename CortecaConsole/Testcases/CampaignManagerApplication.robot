*** Settings ***
Resource    ../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource    ../Resources/TestSpecificProcedures/CampaignManager/CampaignManagerCommonKeywords.robot
Resource    ../Resources/TestSpecificProcedures/CampaignManager/CampaignManagerApplicationKeyword.robot
Variables    ../Resources/TestDatas.py
Library    Collections


*** Test Cases ***
BBDT-255203 NWCC_L1_Campaign_Applications_03_Scenario1
    [Documentation]    BBDT-255203 NWCC_L1_Campaign_Applications_03 | Scheduler Rule - "Install" Operations
    ...    Go to admin Dashboard --> Campaigns --> Select a container application:
    ...	\n Scenario 1: Install - Based on hardware model without specific Firmware selection & Rule triggered during Scheduled time
    ...	        \n 1.Install a container app by selecting a hardware model without firmware version selected.
    ...	        \n 2.Select the application version to install
    ...	        \n 3.Select the Scheduler option & Apply on Boot toggle
    ...	        \n 4.Enter the scheduler time/Duration & Timezone
    ...	        \n 5.Save the scheduler rule
    ...	        \n Once above scenarios are completed when the timer hits:
    ...	        \n  
    ...	        \n 1.Check for all the devices in that particular model the application is installed and running.
    ...	        \n 2.From the particular subscribers page check the app is installed properly under the "Installed applications" section.
    ...	        \n 3.History events are updated properly in applications page with Time/appname/event name
    ...	        \n 4.App deployment report has the corresponding entry
    ...	        \n 5.Trends chart is incremented with the install count for the success
    ...	        \n 6.Download the Trends report and check the corresponding action is updated properly
    ...	        \n 7.In the campaigns page, "install" count is incremented accordingly in the Trends page with the install count against the specific app version with source as NWCC
    ...	        \n 8."Enabled license" under campaign gets incremented based on the number of installations
    ...	\n Note:
    ...	\n For Fsecure Supported board, once the container app is installed/activated check after 300 secs, Router ID (Router manifest key) is created for the subscriber using the API:
    ...	\n Station Profiles - Advanced Parental Control
    ...	\n GET
    ...	\n /subscribers/{subscriber_id}/secure/subscription
    ...	\n And "Nokia WiFi App" shows the Fsecure Network security feature in the Home Dashboard page & Content filtering feature under profiles section.
    ...	\n For Nokia Fingerprint supported boards, check the FING server URL/Password/Key is pushed to the Root device as part of POST INSTALLATION flow.
    ...     tr181 -G X_ALU-COM_FPEngine.
    [Tags]    USP
    [Teardown]    Campaign Application Teardown    ${campaignManagerApplication}    ${appsCampaignRuleDict}
    ${csvFilePath}    Create CSV File    csvWithRootAndExtender
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    Log To Console    **** PreReq: Uninstalling Apps from portal if any ****
    Run Keyword And Continue On Failure    Campaign Application SuiteSetup    ${campaignManagerApplication}    action=Uninstall
    Log To Console    **** Scenario 1: Install - Based on hardware model without specific Firmware selection & Rule triggered during Scheduled time ****
    Log To Console    **** Creating Rule For Scenario 1 ****
    Create Application Campaign Rule    ${campaignManagerApplication}    ${BBDT255203_NWCC_L1_Campaign_Applications_03_Scenario1}    Install    ${csvFilePath}
    Log To Console    **** Rule validation For Scenario 1 ****
    Campaign Applications Operation Rule Validation    ${appsCampaignRuleDict}    ${BBDT255203_NWCC_L1_Campaign_Applications_03_Scenario1}[durationTimeDownload]    ${campaignManagerApplication}

BBDT-255203 NWCC_L1_Campaign_Applications_03_Scenario2
    [Documentation]    BBDT-255203 NWCC_L1_Campaign_Applications_03 | Scheduler Rule - "Install" Operations
    ...    Go to admin Dashboard --> Campaigns --> Select a container application:
    ...	\n Scenario 2:
    ...    Install -- Based on hardware model with specific Firmware selection & Rule triggered during "Apply on Boot"
    ...	    \n 1.Install a container app by selecting a hardware model with a specific firmware version selected.
    ...	    \n 2.Select the application version to install
    ...	    \n 3.Select the Scheduler option & Apply on Boot toggle
    ...	    \n 4.Enter the scheduler time/Duration & Timezone
    ...	    \n 5.Save the scheduler rule
    ...	    \n 6.Reboot the device (or) schedule firmware upgrade before the application schedule time hits.
    ...	    \n
    ...	    \n Check after receiving the "BOOT" event,
    ...	    \n 1.For all the devices in that particular model the application is installed and running.
    ...	    \n 2.From the particular subscribers page check the app is installed properly under the "Installed applications" section.
    ...	    \n 3.History events are updated properly in applications page with Time/appname/event name
    ...	    \n 4.App deployment report has the corresponding entry
    ...	    \n 5.Trends chart is incremented with the install count for the success
    ...	    \n 6.Download the Trends report and check the corresponding action is updated properly
    ...	    \n 7.In the campaigns page, "install" count is incremented accordingly in the Trends page with the install count against the specific app version with source as NWCC
    ...	    \n 8."Enabled license" under campaign gets incremented based on the number of installations
    ...	\n Note:
    ...	\n For Fsecure Supported board, once the container app is installed/activated check after 300 secs, Router ID (Router manifest key) is created for the subscriber using the API:
    ...	\n Station Profiles - Advanced Parental Control
    ...	\n GET
    ...	\n /subscribers/{subscriber_id}/secure/subscription
    ...	\n And "Nokia WiFi App" shows the Fsecure Network security feature in the Home Dashboard page & Content filtering feature under profiles section.
    ...	\n For Nokia Fingerprint supported boards, check the FING server URL/Password/Key is pushed to the Root device as part of POST INSTALLATION flow.
    ...     tr181 -G X_ALU-COM_FPEngine.
    [Tags]    USP
    [Teardown]    Campaign Application Teardown    ${campaignManagerApplication}    ${appsCampaignRuleDict}
    ${csvFilePath}    Create CSV File    csvWithRootAndExtender
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    Log To Console    **** PreReq: Uninstalling Apps from portal if any ****
    Run Keyword And Continue On Failure    Campaign Application SuiteSetup    ${campaignManagerApplication}    action=Uninstal

    Log To Console    **** Scenario 2: Install - Based on hardware model with specific Firmware selection & Rule triggered during "Apply on Boot" ****
    Log To Console    **** Creating Rule For Scenario 2 ****
    Create Application Campaign Rule    ${campaignManagerApplication}    ${BBDT255203_NWCC_L1_Campaign_Applications_03_Scenario2}    Install    ${csvFilePath}
    Log To Console    **** Rule  validation For Scenario 2 ****
    Campaign Applications Operation Rule Validation    ${appsCampaignRuleDict}    ${BBDT255203_NWCC_L1_Campaign_Applications_03_Scenario2}[durationTimeDownload]    ${campaignManagerApplication}    reboot=${True}

BBDT-255207 NWCC_L1_Campaign_Applications_07_Scenario1
    [Documentation]    BBDT-255207 NWCC_L1_Campaign_Applications_07 | Scheduler Rule - "UnInstall" Operations
    ...    Go to admin Dashboard --> Campaigns --> Select a container application:
    ...	\n Scenario 1: UnInstall - without specific Firmware selection & Rule triggered during Scheduled time
    ...    \n 1.UnInstall a container app by selecting a hardware model without firmware version selected.
    ...    \n 2.Select the application version to uninstall
    ...    \n 3.Select the Scheduler option alone
    ...    \n 4.Enter the scheduler time/Duration & Timezone
    ...    \n 5.Save the scheduler rule
    ...    \n Once above scenarios are completed when the timer hits:
    ...    \n 1.Check for all the devices in that particular model the application is removed.
    ...    \n 2.History events are updated properly in applications page
    ...    \n 3.App deployment report clears the corresponding entry that is created already during Installation
    ...    \n 4.Trends chart is incremented properly for the Success
    ...    \n Download the Trends report and check the corresponding action is updated properly for uninstall
    ...    \n 5.In the campaigns page, "uninstall" count is incremented accordingly in the Trends page with the uninstall count against the specific app version with source as NWCC
    ...    \n 6.Enabled license count is decremented accordingly
    ...    \n Note:
    ...        ${\n} For Fsecure Supported board, once the container app is uninstalled/deactivated check Router ID (Router manifest key) is removed for the subscriber using the API:
    ...        ${\n} Station Profiles - Advanced Parental Control
    ...        ${\n} GET-  /subscribers/{subscriber_id}/secure/subscription
    ...        ${\n} And "Nokia WiFi App" doesn't show the Fsecure Network security feature in the Home Dashboard page & Content filtering feature under profiles section.
    ...        ${\n} For Nokia Fingerprint supported boards, check the FING Key pushed to the Root device gets removed now.
    ...        ${\n} Device.X_ALU-COM_FPEngine.Key
    [Teardown]    Campaign Application Teardown    ${campaignManagerApplication}    ${appsCampaignRuleDict}
    ${csvFilePath}    Create CSV File    csvWithRootAndExtender
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    Log To Console    **** PreReq: Installing Apps ****
    Run Keyword And Continue On Failure    Campaign Application SuiteSetup    ${campaignManagerApplication}    action=Install
    Log To Console    **** Scenario 1: UnInstall - without specific Firmware selection & Rule triggered during Scheduled time ****
    Log To Console    **** Creating Rule For Scenario 1 ****
    Create Application Campaign Rule    ${campaignManagerApplication}    ${BBDT255207_NWCC_L1_Campaign_Applications_07_Scenario1}    Uninstall    ${csvFilePath}
    Log To Console    **** Rule  validation For Scenario 1 ****
    Campaign Applications Operation Rule Validation    ${appsCampaignRuleDict}    ${BBDT255207_NWCC_L1_Campaign_Applications_07_Scenario1}[durationTimeDownload]    ${campaignManagerApplication}    action=Uninstall

BBDT-255207 NWCC_L1_Campaign_Applications_07_Scenario2
    [Documentation]    BBDT-255207 NWCC_L1_Campaign_Applications_07 | Scheduler Rule - "UnInstall" Operations
    ...    Go to admin Dashboard --> Campaigns --> Select a container application:
    ...	\n Scenario 2: UnInstall - with specific Firmware selection & Rule triggered during "Apply on Boot"
    ...    ${\n}    1.UnInstall a container app by selecting a hardware model without firmware version selected.
    ...    ${\n}    2.Select the application version to uninstall
    ...    ${\n}    3.Select the "Apply on boot" option alone
    ...    ${\n}    4. Save the scheduler rule
    ...    ${\n}    5.Reboot the device (or) schedule firmware upgrade
    ...    ${\n}    Check after receiving the "BOOT" event:
    ...    ${\n}    1.Check for all the respective devices the application is removed.
    ...    ${\n}    2.History events are updated properly in applications page for uninstallation
    ...    ${\n}    3.App deployment report clears the corresponding entry that is created already during Installation
    ...    ${\n}    4.Trends chart is incremented properly for the Success
    ...    ${\n}    5.Download the Trends report and check the corresponding action is updated properly for uninstall
    ...    ${\n}    6.In the campaigns page, "uninstall" count is incremented accordingly in the Trends page with the uninstall count against the specific app version with source as NWCC
    ...    ${\n}    7.Enabled license count is decremented accordingly    ...    ${\n}    
    ...    \n Note:
    ...        ${\n} For Fsecure Supported board, once the container app is uninstalled/deactivated check Router ID (Router manifest key) is removed for the subscriber using the API:
    ...        ${\n} Station Profiles - Advanced Parental Control
    ...        ${\n} GET-  /subscribers/{subscriber_id}/secure/subscription
    ...        ${\n} And "Nokia WiFi App" doesn't show the Fsecure Network security feature in the Home Dashboard page & Content filtering feature under profiles section.
    ...        ${\n} For Nokia Fingerprint supported boards, check the FING Key pushed to the Root device gets removed now.
    ...        ${\n} Device.X_ALU-COM_FPEngine.Key
    [Teardown]    Campaign Application Teardown    ${campaignManagerApplication}    ${appsCampaignRuleDict}
    ${csvFilePath}    Create CSV File    csvWithRootAndExtender
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    Log To Console    **** PreReq: Installing Apps ****
    Run Keyword And Continue On Failure    Campaign Application SuiteSetup    ${campaignManagerApplication}    action=Install
    Log To Console    **** Scenario 2: UnInstall - with specific Firmware selection & Rule triggered during "Apply on Boot" ****
    Log To Console    **** Creating Rule For Scenario 2 ****
    Create Application Campaign Rule    ${campaignManagerApplication}    ${BBDT255207_NWCC_L1_Campaign_Applications_07_Scenario2}    Uninstall    ${csvFilePath}
    Log To Console    **** Rule  validation For Scenario 2 ****
    Campaign Applications Operation Rule Validation    ${appsCampaignRuleDict}    ${BBDT255207_NWCC_L1_Campaign_Applications_07_Scenario2}[durationTimeDownload]    ${campaignManagerApplication}    reboot=${True}    action=Uninstall

BBDT-255209 NWCC_L1_Campaign_Applications_09
    [Documentation]    BBDT-255209 NWCC_L1_Campaign_Applications_09 | Scheduler Rule - "Idle" & "Active" Operations
    ...    ${\n}Continuing to Test case: BBDT-255206
    ...    ${\n}Scenario 1: Stop the Container Application (Using csv/selecting a particular hardware model) during the scheduled time the rule gets triggerred and check below:
    ...    ${\n}1.Check for all the devices in that particular model the application is stopped and in Idle state.
    ...    ${\n}2.From the particular subscribers page check the app is stopped properly under the "Installed applications" section.
    ...    ${\n}3.History events will be updated in applications page for the stopped operation
    ...    ${\n}4.App deployment report still has the corresponding entry
    ...    ${\n}5.Trends chart is incremented with the count for the success
    ...    ${\n}6.Download the Trends report and check the corresponding action is updated properly
    ...    ${\n}7."Enabled License" should not have any impact

    ...    ${\n}Scenario 2: Start the Container Application (Using csv/selecting a particular hardware model) during the scheduled time the rule gets triggered and check below:
    ...    ${\n}1.Check for all the devices in that particular model the application is started and in "Active" state.
    ...    ${\n}2.From the particular subscribers page check the app is in running status under the "Installed applications" section.
    ...    ${\n}3.History events will be updated in applications page for the started operation
    ...    ${\n}4.App deployment report still has the corresponding entry
    ...    ${\n}5.Trends chart is incremented with the count for the success
    ...    ${\n}6.Download the Trends report and check the corresponding action is updated properly
    ...    ${\n}7."Enabled License" should not have any impact
    [Teardown]    Campaign Application Teardown    ${campaignManagerApplication}    ${appsCampaignRuleDict}
    ${csvFilePath}    Create CSV File    csvWithRootAndExtender
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    Log To Console    **** PreReq: Installing Apps ****
    Run Keyword And Continue On Failure    Campaign Application SuiteSetup    ${campaignManagerApplication}    action=Install
    Log To Console    **** Scenario 1: Stop the Container Application (Using csv/selecting a particular hardware model) during the scheduled time the rule gets triggerred ****
    Log To Console    **** Creating Rule For Scenario 1 ****
    Create Application Campaign Rule    ${campaignManagerApplication}    ${BBDT255209_NWCC_L1_Campaign_Applications_09_Scenario1}    Idle    ${csvFilePath}
    Log To Console    **** Rule  validation For Scenario 1 ****
    Campaign Applications Operation Rule Validation    ${appsCampaignRuleDict}    ${BBDT255209_NWCC_L1_Campaign_Applications_09_Scenario1}[durationTimeDownload]    ${campaignManagerApplication}    reboot=${False}    action=Idle
    Run Keyword And Continue On Failure    Delete Application Rules   ${appsCampaignRuleDict}

    Log To Console    **** Creating Rule For Scenario 2 ****
    Create Application Campaign Rule    ${campaignManagerApplication}    ${BBDT255209_NWCC_L1_Campaign_Applications_09_Scenario2}    Active    ${csvFilePath}
    Log To Console    **** Rule  validation For Scenario 1 ****
    Campaign Applications Operation Rule Validation    ${appsCampaignRuleDict}    ${BBDT255209_NWCC_L1_Campaign_Applications_09_Scenario2}[durationTimeDownload]    ${campaignManagerApplication}    reboot=${True}    action=Active

BBDT-255206 NWCC_L1_Campaign_Applications_06
    [Documentation]    BBDT-255206 NWCC_L1_Campaign_Applications_06 | Scheduler Rule - "Update" Operations
    ...    ${\n} Continuing to Test case BBDT-255203:
    ...    ${\n} Go to admin Dashboard --> Campaigns --> Select a container application to upgrade (there will not be separate option for Upgrade. Select the version to Install)
    ...    ${\n} Scenario : Install - Based on hardware model/using csv method with specific Firmware selection &  Rule triggered during Scheduled time
    ...    ${\n} 1.Install a container app by selecting a hardware model with a specific firmware version selected.
    ...    ${\n} 2.Select the application version to install
    ...    ${\n} 3.Select the Scheduler option & Apply on Boot toggle
    ...    ${\n} 4.Enter the scheduler time/Duration & Timezone
    ...    ${\n} 5.Save the scheduler rule
    ...    ${\n} Once above scenarios are completed when the timer hits:
    ...    ${\n} 1.Check for all the devices in that particular model the application got updated and running.
    ...    ${\n} 2.History events are updated properly in applications page for the update operation.
    ...    ${\n} 3.App deployment report has the corresponding entry with the updated version
    ...    ${\n} 4.Trends chart is incremented with the install count for the success
    ...    ${\n} 5.Download the Trends report and check the corresponding action is updated properly with proper version details
    ...    ${\n} 6.In the campaigns page, "install" count is incremented accordingly in the Trends page with the install count against the specific app version with source as NWCC
    ...    ${\n} 7."Enabled license" under campaign should not get incremented since it is Update operation
    [Teardown]    Campaign Application Teardown    ${campaignManagerApplication}    ${appsCampaignRuleDict}    action=Update
    ${csvFilePath}    Create CSV File    csvWithRootAndExtender
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    Log To Console    **** PreReq: Installing Apps ****
    Run Keyword And Continue On Failure    Campaign Application SuiteSetup    ${campaignManagerApplication}    action=Install
    Log To Console    **** Creating Rule for Update ****
    Create Application Campaign Rule    ${campaignManagerApplication}    ${BBDT255206_NWCC_L1_Campaign_Applications_06}    Install    ${csvFilePath}    update=${True}
    Log To Console    **** Rule  validation For Update ****
    Campaign Applications Operation Rule Validation    ${appsCampaignRuleDict}    ${BBDT255206_NWCC_L1_Campaign_Applications_06}[durationTimeDownload]    ${campaignManagerApplication}    reboot=${True}    action=Update

BBDT-255213_NWCC_L1_Campaign_Applications_13
    [Documentation]    BBDT-255213_NWCC_L1_Campaign_Applications_13 | Scheduler rules management
    ...    ${\n} 1.Check for the Campaign applications main UI screen
    ...    ${\n}      a. View rules --> redirects to the created rule
    ...    ${\n}      b. Add rules --> redirects to create a rule
    ...    ${\n} 2.Rules can be created with the supported characters
    ...    ${\n} 3.Rule status can be enabled/disabled by disabling & enabling the scheduler in the Main page and check the rule doesn't apply in the scheduled time [Check this case when the scheduler is running also]
    ...    ${\n} 4.Rules can be edited (Edit Action - action & container version not editable. Other fields can be edited) and check for the functionality as well
    ...    ${\n} 5.Check the Scheduler rules can deleted
    ...    ${\n} 6.Check for the rules can be created without enabling the scheduler as well- > covered as part of BBDT255207_NWCC_L1_Campaign_Applications_07_Scenario2
    ...    ${\n} 7.Check maximum scheduler creation can be defined as env at tenant level and on exceeding the count during scheduler rule creation, will throw an error [BE have to check both enabled & disabled rules as well]
    ...    ${\n} 8.Duplicate rule creation - When a scheduler rule is created with same name, L1 BE should validate and throw error
    ...    ${\n}
    [Teardown]    Run Keywords    Delete App Rule    ${appName}    ${newRuleName}    AND    Uninstall The Application And History Validation    ${appName}    ${appVersion}
    ${csvFilePath}    Create CSV File    csvWithRoot
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    ${action}    Set Variable    Install
    ${appName}    Set Variable    ${campaignManagerApplication}[0][Application]
    ${appVersion}    Set Variable    ${campaignManagerApplication}[0][AppVersion]
    ${appSelect}    Replace String    ${eleCortecaAdminCampaignApplicationSelect}    APPLICATION    ${appName}
    ${rulename}    Set Variable    ${campaignManagerApplication}[0][Name]_Install
    ${newRuleName}    Set Variable    $FP_Rule@!""&/;\*[Auto]{}<123>>

    Log To Console    **** PreReq: Uninstalling Apps from portal if any ****
    Run Keyword And Continue On Failure    Uninstall The Application And History Validation    ${appName}    ${appVersion}

    Log To Console    **** Rule Creation ****
    Run Keyword And Continue On Failure    Create Application Rule    ${rulename}    ${action}    ${campaignManagerApplication}[0][HwModel]    ${campaignManagerApplication}[0][FirmwareVersions]    ${appVersion}    ${csvFilePath}    ${BBDT255213_NWCC_L1_Campaign_Applications_13}    neg=${False}    errMsg=''    application=${appName}    appRuleStatus=False

    Log To Console    **** Duplicate rule creation - When a scheduler rule is created with same name, L1 BE should validate and throw error ****
    Run Keyword And Continue On Failure    Create Application Rule    ${rulename}    ${action}    ${campaignManagerApplication}[0][HwModel]    ${campaignManagerApplication}[0][FirmwareVersions]    ${appVersion}    ${csvFilePath}    ${BBDT255213_NWCC_L1_Campaign_Applications_13}    neg=${True}    errMsg=Schedule with same name already exists    application=${appName}

    Log To Console    **** Rule status disabling the scheduler in the Main page and check the rule doesn't apply in the scheduled time [Check this case when the scheduler is running also] ****
    Reboot Root Device
    Sleep    180s
    ${statusTrend}    Run Keyword And Return Status    Rule Trend Validation Application    ${appName}    ${ruleName}
    ${statusReport}    Run Keyword And Return Status    Rule Report Validation Application    ${appName}    ${ruleName}
    Run Keyword And Continue On Failure    Should Not Be True    ${statusTrend} or ${statusReport}

    Log To Console    **** Edit Rule ****
    Edit Created Rule    ${appName}    ${ruleName}    ${newRuleName}    ${BBDT255213_NWCC_L1_Campaign_Applications_13_Edit}[hourGapDownload]    ${BBDT255213_NWCC_L1_Campaign_Applications_13_Edit}[durationTimeDownload]

    Log To Console    **** Rule status Enabling the scheduler in the Main page and check the rule doesn't apply in the scheduled time [Check this case when the scheduler is running also] ****
    EnableDisable The Campaign Rule    ${appName}    ${newRuleName}    True
    Log To Console    **** Waiting until next schedule time ****
    ${getSleepCount}    Get The Next Quad Wait Time
    ${sleepTime}    Evaluate    ${getSleepCount}+420
    Sleep    ${sleepTime}

    Log To Console    **** campaign rule validation after schedule ****
    Run Keyword And Continue On Failure    Rule Trend Validation Application    ${appName}    ${newRuleName}
    Run Keyword And Continue On Failure    Rule Report Validation Application    ${appName}    ${newRuleName}