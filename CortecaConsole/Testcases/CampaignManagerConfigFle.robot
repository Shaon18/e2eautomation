*** Settings ***
Resource    ../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource    ../Resources/TestSpecificProcedures/CampaignManager/CampaignManagerCommonKeywords.robot
Resource    ../Resources/TestSpecificProcedures/CampaignManager/CampaignManagerConfigFileKeyword.robot
Variables    ../Resources/TestDatas.py
Library    Collections


*** Test Cases ***
BBDT-280323 NWCC_AIOC_USP_AdminDashboard_02
    [Documentation]    BBDT-280323	NWCC_AIOC_USP_AdminDashboard_02 | Verify Add & Delete of Config file scheduler
    ...                ${\n}Check if the Config file can be handled as below
    ...                ${\n}1: Add Config file - Name, Version, Hardware Model, Config file browse and upload option.
    ...                ${\n}2. Add a Config file using the above options.
    ...                ${\n}3. Check if the added file is listed in the table.
    ...                ${\n}4. Delete the config file from the table and check if it is removed from the table list.
    [Tags]    USP
    Log To Console    1. Add Config file - Name, Version, Hardware Model, Config file browse and upload option. 2. Add a Config file using the above options. 3. Check if the added file is listed in the table.
    Add A New Config File    ${campaignManagerConfigFileDict}
    Sleep    ${sleepMin}
    Log To Console    4. Delete the config file from the table and check if it is removed from the table list.
    Delete A Config File    ${campaignManagerConfigFileDict}[Name]

BBDT-280330 NWCC_AIOC_USP_AdminDashboard_09
    [Documentation]    BBDT-280330 NWCC_AIOC_USP_AdminDashboard_09 | Verify Delete Rule for Config file scheduler
    ...     ${\n}1. Check upon DELETE rule, the created scheduler must be removed from the Configurations file Rule list
    [Tags]    USP
    Log To Console    **** Add Config file - Name, Version, Hardware Model, Config file browse and upload option. 2. Add a Config file using the above options. 3. Check if the added file is listed in the table. ****
    Add A New Config File    ${campaignManagerConfigFileDummy}
    Sleep    ${sleepMin}
    Log To Console    **** Creating the CSV file based on Mesh ****
    ${csvFilePath}    Create CSV File    csvWithRootAndExtender
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    FOR    ${extender}    IN    @{meshNodes}
         ${extMac}    Set Variable    ${${extender}}[mac1]
         Log    ${extMac}
         Append To File  ${csvFilePath}  \n${extMac}
    END
    Log To Console    **** Creating the Rule ****
    ${rulename}    Create A New Rule For Campaign ConfigFile    ${campaignManagerConfigFileDummy}[Name]    ${BBDT280324_NWCC_AIOC_USP_AdminDashboard_03}    ${csvFilePath}
    Log To Console    **** Deleting the config file group ****
    Delete A Config File    ${campaignManagerConfigFileDummy}[Name]
    Log To Console    **** Add Config file ****
    Add A New Config File    ${campaignManagerConfigFileDummy}
    Log To Console    **** Creating the Rule ****
    ${rulename}    Create A New Rule For Campaign ConfigFile    ${campaignManagerConfigFileDummy}[Name]    ${BBDT280324_NWCC_AIOC_USP_AdminDashboard_03}    ${csvFilePath}
    Log To Console    **** Delete the Rule ****
    Delete Rule    ${campaignManagerConfigFileDummy}[Name]    ${rulename}
    Log To Console    **** Deleting the config file group ****
    Delete A Config File    ${campaignManagerConfigFileDummy}[Name]

BBDT-280328 NWCC_AIOC_USP_AdminDashboard_07
    [Documentation]    BBDT-280328 NWCC_AIOC_USP_AdminDashboard_07 | Verify Edit Rule for Config File scheduler
    ...     ${\n} Check if the created Rule for Config File can be EDITED for changes in Name, MAC List, frequency, Applicable Firmware versions fields.Also should be able to toggle the 'Perform action on Boot' button.New Edited Rule should be listed in the Configurations file table.
    [Tags]    USP
    Log To Console    **** Add Config file - Name, Version, Hardware Model, Config file browse and upload option. 2. Add a Config file using the above options. 3. Check if the added file is listed in the table. ****
    Add A New Config File    ${campaignManagerConfigFileDummy}
    Sleep    ${sleepMin}
    Log To Console    **** Creating the Rule ****
    ${rulename}    Create A New Rule For Campaign ConfigFile    ${campaignManagerConfigFileDummy}[Name]    ${BBDT280324_NWCC_AIOC_USP_AdminDashboard_03}    ${ConfigRuleEditCheckFile1}
    Log To Console    ****  Created Rule for Config File can be EDITED for changes in Name, MAC List, frequency, Applicable Firmware versions fields.Also should be able to toggle the 'Perform action on Boot' button.New Edited Rule should be listed in the Configurations file table. ****
    Verify The Edit Configs    ${campaignManagerConfigFileDummy}[Name]    ${rulename}
    Run Keyword And Continue On Failure    Delete A Config File    ${campaignManagerConfigFileDummy}[Name]

BBDT-280324 NWCC_AIOC_USP_AdminDashboard_03
    [Documentation]    BBDT-280324	NWCC_AIOC_USP_AdminDashboard_03 | Verify Create Rule & Functionality for Config file scheduler
    ...     ${\n}1. Add rules - Name, Configuration file & Status toggle button.
    ...     ${\n}2. Target devices - Hardware model, List of MAC address & From Firmware version
    ...     ${\n}3. Scheduler - Frequency, Duration Time Zone & Perform action also in Boot toggle buttonHardware Mode
    ...     ${\n}4: Rule must be created, enabled and Config File must be installed to all the beacons based on the hardware model selected
    ...     ${\n}5: Check if the created config file rule is listed in the configurations file table.
    ...     ${\n}6: Check after the Config file Rule is executed and upon Reboot/Software upgrade the Rule should again not be applied.
    ...     ${\n}	List of MAC Address:Rule must be created, enabled and Config File must be installed to ONLY the specific beacon MAC's provided in the csv file.
    ...     ${\n}	Check if the created config file rule is listed in the configurations file table.
    ...     ${\n}	If any MAC which doesn't match the Hardware model type, Error must thrown and Rule creation must be denied.
    ...     ${\n}	Config file Rule must NOT be applied to EXT Beacons in either of the above cases.
    [Tags]    USP
    [Teardown]    Apply Default Config File    ${campaignManagerConfigFileDict}
    Log To Console    **** Add Config file - Name, Version, Hardware Model, Config file browse and upload option. 2. Add a Config file using the above options. 3. Check if the added file is listed in the table. ****
    Add A New Config File    ${campaignManagerConfigFileDict}
    Sleep    ${sleepMin}
    Log To Console    **** Validating If any MAC which doesn't match the Hardware model type, Error must thrown and Rule creation must be denied. ****
    Run Keyword And Continue On Failure    Validate Rule Creation With Wrong Model MAC    csvWrongModel     ${campaignManagerConfigFileDict}[Name]    ${BBDT280324_NWCC_AIOC_USP_AdminDashboard_03}
    Log To Console    **** Generating CSV file with MESH MACs ****
    ${ExtCount}    Get Length    ${meshNodes}
    ${csvFilePath}    Create CSV File    csvWithRootAndExtender
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    FOR    ${extender}    IN    @{meshNodes}
         ${extMac}    Set Variable    ${${extender}}[mac1]
         Log    ${extMac}
         Append To File  ${csvFilePath}  \n${extMac}
    END
    Log To Console    **** Creating Rule ****
    ${rulename}    Create A New Rule For Campaign ConfigFile    ${campaignManagerConfigFileDict}[Name]    ${BBDT280324_NWCC_AIOC_USP_AdminDashboard_03}    ${csvFilePath}
    Log To Console    **** check webgui configs before applying config file ****
    Verify Applied ConfigFile Webgui Changes    afterApply=${False}
    Log To Console    **** check Portal configs after applying config file
    Verify Applied ConfigFile Portal Changes    ${configFileName}    afterApply=${False}
    #Log    Sleep for 1.5 hr
    #Sleep    5400
    ${getSleepCount}    Get The Next Quad Wait Time
    Log To Console    ${getSleepCount}
    Log To Console    "Wait until next schedule triggered"
   # ${sleepTime}    Evaluate    ${getSleepCount}
    Sleep    ${getSleepCount}
    Log To Console    **** Check in rule -> rule trends graph after config applies ****
    Run Keyword And Continue On Failure    Rule Trend Validation ConfigFile    ${campaignManagerConfigFileDict}[Name]    ${rulename}    ruleUsingCSV=${True}    extenderCheck=${True}
    Log To Console    **** Check in rule report -> Config file Rule must NOT be applied to EXT Beacons ****
    Run Keyword And Continue On Failure    Rule Report Validation ConfigFile    ${campaignManagerConfigFileDict}[Name]    ${RuleName}    extenderCheck=${True}
    Log To Console    **** check webgui configs after applying config file
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Webgui Changes    afterApply=${True}
    Log To Console    **** check Portal configs after applying config file
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Portal Changes    ${configFileName}    afterApply=${True}
    Run Keyword And Continue On Failure    Validate Config Campaign After Reboot    ${campaignManagerConfigFileDict}[Name]    ${rulename}
    Run Keyword And Continue On Failure    Delete A Config File    ${campaignManagerConfigFileDict}[Name]

BBDT-280327 NWCC_AIOC_USP_AdminDashboard_06
    [Documentation]    BBDT-280327 NWCC_AIOC_USP_AdminDashboard_06 | Verify Config File Rule for Apply on Boot upon Factory Reset
    ...     ${\n} Check if the Config file Rule is executed when Apply on Boot is enabled and Beacon is 'Factory Reset'Check the Config file Rule is Not applied if Rebooted, after Factory Reset.
    [Tags]    USP
    [Teardown]    Apply Default Config File    ${campaignManagerConfigFileDict}
    Log To Console    **** Add Config file - Name, Version, Hardware Model, Config file browse and upload option. 2. Add a Config file using the above options. 3. Check if the added file is listed in the table. ****
    Add A New Config File    ${campaignManagerConfigFileDict}
    Sleep    ${sleepMin}
    Log To Console    **** Generating CSV file with MESH MACs ****
    ${ExtCount}    Get Length    ${meshNodes}
    ${csvFilePath}    Create CSV File    csvFactoryReset
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    Log To Console    **** Creating Rule  ****
    ${rulename}    Create A New Rule For Campaign ConfigFile    ${campaignManagerConfigFileDict}[Name]    ${BBDT280327_NWCC_AIOC_USP_AdminDashboard_06}    ${csvFilePath}
    Log To Console    **** check webgui configs before applying config file ****
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Webgui Changes    afterApply=${False}
    Log To Console    **** check Portal configs after applying config file ****
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Portal Changes    ${configFileName}    afterApply=${False}
    Log To Console    **** Going for Factory reset ****
    Perform Factory Reset In USP
    Log To Console    Wait for 5 min after factory reset
    Sleep    300s
    Log To Console    **** Check in rule -> rule trends graph after Factory reset and verify config applied ****
    Run Keyword And Continue On Failure    Rule Trend Validation ConfigFile    ${campaignManagerConfigFileDict}[Name]    ${rulename}    ruleUsingCSV=${True}
    Log To Console    **** Check in rule report -> after Factory reset and verify config applied for root and Rule must NOT be applied to EXT Beacons ****
    Run Keyword And Continue On Failure    Rule Report Validation ConfigFile    ${campaignManagerConfigFileDict}[Name]    ${RuleName}
    Log To Console    **** check webgui configs after applying config file ****
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Webgui Changes    afterApply=${True}
    Log To Console    **** check Portal configs after applying config file ****
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Portal Changes    ${configFileName}    afterApply=${True}
    Log To Console    **** Deleting config file ****
    Run Keyword And Continue On Failure    Delete A Config File    ${campaignManagerConfigFileDict}[Name]

BBDT-280326 NWCC_AIOC_USP_AdminDashboard_05
    [Documentation]    BBDT-280326 NWCC_AIOC_USP_AdminDashboard_05 | Verify Config File Rule for Apply on Boot upon Software Upgrade
    ...     ${\n} Check if the Config file Rule is executed when Apply on Boot is enabled and Beacon is 'Software Upgraded'Check the Rule doesn’t push the Config file again if Rebooted subsequent times after Software Upgrade.
    [Tags]    USP
    [Teardown]    Apply Default Config File    ${campaignManagerConfigFileDict}
    Log To Console    **** Add Config file - Name, Version, Hardware Model, Config file browse and upload option. 2. Add a Config file using the above options. 3. Check if the added file is listed in the table. ****
    Add A New Config File    ${campaignManagerConfigFileDict}
    Sleep    ${sleepMin}
    Log To Console    **** Generating CSV file with MESH MACs ****
    ${ExtCount}    Get Length    ${meshNodes}
    ${csvFilePath}    Create CSV File    csvSoftwareUpgrade
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    Log To Console    **** Creating Rule  ****
    ${rulename}    Create A New Rule For Campaign ConfigFile    ${campaignManagerConfigFileDict}[Name]    ${BBDT280326_NWCC_AIOC_USP_AdminDashboard_05}    ${csvFilePath}
    Log To Console    **** check webgui configs before applying config file ****
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Webgui Changes    afterApply=${False}
    Log To Console    **** check Portal configs after applying config file ****
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Portal Changes    ${configFileName}    afterApply=${False}
    Log To Console    **** Going for Software upgrade ****
    Perform Software Upgrade In USP    ${campaignManagerConfigFileDict}[softwareUpgradeImagePath]
    Sleep    10s
    Log To Console    **** Check in rule -> rule trends graph after Factory reset and verify config applied ****
    Run Keyword And Continue On Failure    Rule Trend Validation ConfigFile    ${campaignManagerConfigFileDict}[Name]    ${rulename}    ruleUsingCSV=${True}
    Log To Console    **** Check in rule report -> after Factory reset and verify config applied for root and Rule must NOT be applied to EXT Beacons ****
    Run Keyword And Continue On Failure    Rule Report Validation ConfigFile    ${campaignManagerConfigFileDict}[Name]    ${RuleName}
    Log To Console    **** check webgui configs after applying config file ****
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Webgui Changes    afterApply=${True}
    Log To Console    **** check Portal configs after applying config file ****
    Run Keyword And Continue On Failure    Verify Applied ConfigFile Portal Changes    ${configFileName}    afterApply=${True}
    Log To Console    **** Deleting config file ****
    Run Keyword And Continue On Failure    Delete A Config File    ${campaignManagerConfigFileDict}[Name]

BBDT-280329 NWCC_AIOC_USP_AdminDashboard_08
    [Documentation]    BBDT-280329 NWCC_AIOC_USP_AdminDashboard_08 | Verify Config File Rule for Offline WiFi points
    ...     ${\n} Check the scenario for OFFLINE WiFi Points in Config file scheduler rule
    ...                ${\n}1. Create a Scheduler Rule for a WiFi Point when Online.
    ...                ${\n}2. Turn Off the WiFi Point and make it Offline.
    ...                ${\n}3. Check the Rule will be added to the Queue.
    ...                ${\n}4. Turn On the WiFi Point and check if Online.
    ...                ${\n}5. Rule will be applied to the WiFi point once device is Online.
    [Tags]    USP
    [Teardown]    Apply Default Config File    ${campaignManagerConfigFileDict}
    Log To Console    **** Add Config file - Name, Version, Hardware Model, Config file browse and upload option. 2. Add a Config file using the above options. 3. Check if the added file is listed in the table. ****
    Add A New Config File    ${campaignManagerConfigFileDict}
    Sleep    ${sleepMin}
    Log To Console    **** Generating CSV file with MESH MACs ****
    ${csvFilePath}    Create CSV File    csvWanDown
    Append to CSV    ${csvFilePath}    MAC
    Append to CSV    ${csvFilePath}    \n${Root}[mac1]
    Log To Console    **** Creating Rule  ****
    ${rulename}    Create A New Rule For Campaign ConfigFile    ${campaignManagerConfigFileDict}[Name]    ${BBDT280324_NWCC_AIOC_USP_AdminDashboard_03}    ${csvFilePath}
    Log To Console    **** Turn Off the WiFi Point and make it Offline by WAN down and Check the Rule will be added to the Queue ****
    Run Keyword And Continue On Failure    Verify Config Campaign Based On Device Status    false    ${False}    ${campaignManagerConfigFileDict}[Name]    ${rulename}
    Log To Console    **** Turn On the WiFi Point by making WAN Up and check Rule applied to the WiFi point once device is Online ****
    Run Keyword And Continue On Failure    Verify Config Campaign Based On Device Status    true    ${True}    ${campaignManagerConfigFileDict}[Name]    ${rulename}
    Run Keyword And Continue On Failure    Delete A Config File    ${campaignManagerConfigFileDict}[Name]
