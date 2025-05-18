*** Settings ***
Resource     ../../KeywordDefinition/CommonKeywords.robot
Variables    ../../JavaScriptCodes/executeJavaScriptCodeCorteca.py
Variables    ../../../InputFiles/EnvironmentInput.py
Variables    ../../../Locators/CortecaConsoleAdminLocators.py
Resource    ../KibanaKeywords.resource
Resource    ../LoginPageProcedures.robot
Library    DateTime
Library    OperatingSystem
Library    BuiltIn
Library    CSVLibrary

*** Keywords ***
Open Corteca Console Admin Page
    [Documentation]    This function will perform the following:
    ...                1: Open admin page and select the page and check the page contains the given text
    ...                Arguments:
    ...                 pageCheckText -> The text need to check after opening the given page
    ...                 tabSelection -> Which tab in admin page
    ...                     eg: Provisioning -> For opening Provisioning page
    ...                         Association -> For opening Association page
    ...                         DeploymentReport -> For opening Deployment Report page
    ...                         Campaign -> For opening Campaign page
    [Arguments]    ${pageCheckText}    ${tabSelection}=Provisioning
    Press Click Element    ${eleCortecaDashbordAdmin}
    Wait Until Page Contains    Admin
    ${tabSelector}=    Get Tab Selection For Admin    ${tabSelection}
    ${status}    Run Keyword And Return Status    Press Click Element    ${tabSelector}
    Run Keyword If    '${status}'=='False'    Press Click Element    ${eleNewPortal}
    Run Keyword If    '${status}'=='False'    Press Click Element    ${tabSelector}
    Wait Until Page Contains    ${pageCheckText}
    Page Should Contain    ${pageCheckText}
    
Get Tab Selection For Admin
    [Documentation]    This function return the selector for the given admin page selection:
    ...                Arguments:
    ...                 tabSelection -> Which tab in admin page
    ...                     eg: Provisioning -> For opening Provisioning page
    ...                         Association -> For opening Association page
    ...                         DeploymentReport -> For opening Deployment Report page
    ...                         Campaign -> For opening Campaign page
    ...                return :
    ...                    tabSelector-> the selector for the tabSelection
    [Arguments]    ${tabSelection}
    ${tabSelector}=    Set Variable    ''
    ${tabSelector}=    Run Keyword If    '${tabSelection}'=='Provisioning'    Set Variable    ${eleCortecaAdminProvisioning}
    ...    ELSE IF    '${tabSelection}'=='Association'    Set Variable    ${eleCortecaAdminAssociation}}
    ...    ELSE IF    '${tabSelection}'=='DeploymentReport'    Set Variable    ${eleCortecaAdminDeploymentReport}
    ...    ELSE IF    '${tabSelection}'=='Campaign'    Set Variable    ${eleCortecaAdminCampaign}
    ...    ELSE    ${tabSelection}
    Return From Keyword    ${tabSelector}

Open which Campaign
    [Documentation]    This function will open the given campaign page
    ...                Arguments:
    ...                 campaignType -> Which tab in campaign page
    ...                     eg: Firmware -> For opening Firmware campaign page
    ...                         Application -> For opening Application Campaign page
    ...                         ConfigFile -> For opening Configuration File Campaign page
    ...                         Reboot -> For opening Reboot Campaign page
    [Arguments]    ${campaignType}=Firmware
    ${tabSelector}=    Run Keyword If    '${campaignType}'=='Firmware'    Set Variable    ${eleCortecaAdminCampaignFirmware}
    ...    ELSE IF    '${campaignType}'=='Application'    Set Variable    ${eleCortecaAdminCampaignApplication}}
    ...    ELSE IF    '${campaignType}'=='ConfigFile'    Set Variable    ${eleCortecaAdminCampaignConfigFile}
    ...    ELSE IF    '${campaignType}'=='Reboot'    Set Variable    ${eleCortecaAdminCampaignReboot}
    ...    ELSE    ${tabSelection}
    Return From Keyword If    '${campaignType}'=='Application'
    Wait Until Page Contains Element    ${tabSelector}
    Press Click Element    ${tabSelector}

Login To CampaignManager
    [Documentation]    This function will perform the following:
    ...                1: Open the Corteca portal
    ...                2: login to corteca console
    ...                3: Open admin page and move to campaign
    ...                Arguments:
    ...                 campaignType -> Which campaign page need to open
    ...                     eg: Firmware -> For opening Firmware campaign page
    ...                         Application -> For opening Appliction campaign page
    ...                         ConfigFile -> For opening Configuration File campaign page
    ...                         Reboot -> For opening Reboot campaign page
    [Arguments]    ${campaignType}=Firmware
    Login To Corteca Console
    Open Corteca Console Admin Page    pageCheckText=Campaign    tabSelection=Campaign
    Capture Page Screenshot

Campaign Toaster validation
    [Documentation]    This function used to check the campaign toaster validation
    ...                Arguments:
    ...                 textCheck -> Text to check in toaster card
    ...                 timeout -> wait time for toaster
    [Arguments]    ${textCheck}    ${timeout}=240
    Verify the Toaster Message    ${textCheck}    timeout=${timeout}

Get Time For Setting Schedule
    [Documentation]    This function used to get the time need to schedule for download or activate
    ...                Arguments:
    ...                 timeGap -> Time gap needed between current time and schedule time
    [Arguments]    ${timeGap}
    ${currentTime}    SSHExecute    ${deviceTimezoneCli}
    ${historytime}    Fetch From Right    ${currentTime}    ${deviceTimezoneMatch}
    ${dateVal}    Get Regexp Matches    ${historytime}    (\\S.*)T\\S+
    ${dateVal}    Set Variable    ${dateVal}[0]
    ${deviceTime}    Convert Date    ${dateVal.strip()}    result_format=%Y-%m-%d %H:%M:%S    date_format=%Y-%m-%dT%H:%M:%S
    Log    ${deviceTime}
    ${time}    Add Time To Date    ${deviceTime}    ${timeGap} hours
    ${time}    Get Time    hour    ${time}
    ${time}    Convert To Integer    ${time}
    ${time}    Convert To String    ${time}
    Return From Keyword    ${time}

kibana Report Validation
    [Documentation]    This function used to do the kibana log validation
    ...                Arguments:
    ...                 operation -> serach key for the kibana filter
    [Arguments]    ${operation}
    Login To Kibana Page
    ${KibanaEpoctime}    Get Kibana Log Time    ${operation}
    Log    ${KibanaEpoctime}
    Close Browser
    Return From Keyword    ${KibanaEpoctime}
    
Remove Files From User Download Path
    [Documentation]    This function used remove specific files from the download path
    ...                Arguments:
    ...                 filename -> File name to remove
    [Arguments]    ${filename}
    ${usrPath}    Get Environment Variable    UserProfile
    ${sysDownloadPath}    Set Variable    ${usrPath}\\Downloads
    Run Keyword And Ignore Error    Remove Files    ${sysDownloadPath}\\${filename}

Get Rule Report File
    [Documentation]    This function used Get specific files from the download path
    ...                Arguments:
    ...                 filename -> File name to remove (csv files)
    ...                Return:  reportData -> Dictonary of datas based on the csv file
    [Arguments]    ${filename}    ${DictKeyIndex}=0
    ${reportData}    Set Variable    None
    Log    ${filename}
    ${usrPath}    Get Environment Variable    UserProfile
    ${sysDownloadPath}    Set Variable    ${usrPath}\\Downloads
    ${FILES}    OperatingSystem.List Files In Directory    ${sysDownloadPath}
    Log    ${FILES}
    ${fileName}    OperatingSystem.List Files In Directory    ${sysDownloadPath}    ${filename}
    ${file_content}    OperatingSystem.Get File    ${sysDownloadPath}\\${fileName}[0]    encoding=UTF-8
    @{lines}    Split To Lines    ${file_content}
    Log	${lines}				
    ${reportData}    Create Dictionary From Rule Report CSV    ${lines}    ${DictKeyIndex}
    Return From Keyword    ${reportData}

Get Files From User Download Path
    [Documentation]    This function used Get specific files from the download path
    ...                Arguments:
    ...                 filename -> File name to remove (csv files)
    ...                Return:  reportData -> Dictonary of datas based on the csv file
    [Arguments]    ${filename}    ${DictKeyIndex}=0
    ${reportData}    Set Variable    None
    Log    ${filename}
    ${usrPath}    Get Environment Variable    UserProfile
    ${sysDownloadPath}    Set Variable    ${usrPath}\\Downloads
    ${FILES}    OperatingSystem.List Files In Directory    ${sysDownloadPath}
    Log    ${FILES}
    ${fileName}    OperatingSystem.List Files In Directory    ${sysDownloadPath}    ${filename}
    ${file_content}    OperatingSystem.Get File    ${sysDownloadPath}\\${fileName}[0]    encoding=UTF-8
    @{lines}    Split To Lines    ${file_content}
    Log	${lines}
    ${reportData}    Create Dictionary From CSV    ${lines}    ${DictKeyIndex}
    Return From Keyword    ${reportData}
    
Target Device And Firmware Selection
    [Documentation]    keyword to select the timezone for rule creation
    ...                 Argument:
    ...                    fromfirmwareAny -> true/false to select from version as any
    ...                    targetViaCSV-> targets via csv file
    ...                    fromfirmwareList - list of from firmware versions
    [Arguments]    ${fromfirmwareAny}    ${targetViaCSV}    ${fromfirmwareList}=[]    ${campaignTargetDeviceFileCSV}=''
    Run Keyword If    ${targetViaCSV}    Target Device With CSV upload    ${campaignTargetDeviceFileCSV}
    Return From Keyword If    ${fromfirmwareAny}
     FOR    ${image}    IN    @{fromfirmwareList}
            ${targetFirmwareItemSelector}    Replace String    ${drpDwnMultiCampaignFirmwareNewRuleTargetFirmware}    FIRMWARE    ${image}
        Select From Dropdown Item    ${drpDwnMultiCampaignFirmwareNewRuleTargetFirmwareClick}    ${targetFirmwareItemSelector}
        Sleep    2s
    END

Target Device With CSV upload
    [Arguments]    ${campaignConfigFileCSV}
    log    csv upload
    Press Click Element    ${eleCSVFileSelect}
    Upload A File    ${eleCampaignManagerCSVUpload}    ${campaignConfigFileCSV}

Cron Tab Selection For Firmware Boot And Schedule
    [Documentation]    keyword to enable/disable crontabs
    ...                 Argument:
    ...                    enableBoot -> Boot enable/disable
    ...                    enableScheduler -> Scheduler enable/disable
    [Arguments]    ${enableBoot}    ${enableScheduler}
    Cron Tab Toggle    ${toggleCampaignManagerNewRuleEnableBoot}    ${toggleCampaignManagerNewRuleEnableBootClick}    ${enableBoot}
    Cron Tab Toggle    ${toggleCampaignManagerNewRuleEnableScheduler}    ${toggleCampaignManagerNewRuleEnableSchedulerClick}    ${enableScheduler}

Create Schedule For Download
    [Documentation]    keyword to create schedule for download Config file
    ...                 Argument:
    ...                    frequency -> Day/year etc
    ...                    downloadTime -> to set the download schedule time
    ...                    downloadRetryDuration -> to set the download retry duration
    [Arguments]    ${frequency}    ${downloadTime}    ${downloadRetryDuration}
    Run Keyword If    '${frequency}'=='Day'    Schedule ConfigFile Download For Day    ${downloadTime}    ${downloadRetryDuration}
    ...    ELSE IF    '${frequency}'=='Week'    Schedule ConfigFile Download For Week    ${downloadTime}    ${downloadRetryDuration}
    ...    ELSE IF    '${frequency}'=='Month'    Schedule ConfigFile Download For Month    ${downloadTime}    ${downloadRetryDuration}
    ...    ELSE IF    '${frequency}'=='Year'    Schedule ConfigFile Download For Year    ${downloadTime}    ${downloadRetryDuration}

Schedule ConfigFile Download For Day
    [Documentation]    keyword to schedule download for Frequency Day
    ...                 Argument:
    ...                    scheduleTimeGap -> current time and schedule time gap
    ...                    scheduleRetryDuration -> to set the download retry duration
    [Arguments]    ${scheduleTimeGap}    ${scheduleRetryDuration}
    Log    **** Select Frequency ****
    ${targetDownloadFreqency}    Replace String    ${eleCampaignManagerScheduleFrequency}    FREQUENCY    Day
    ${timeToSet}    Get Time For Setting Schedule    ${scheduleTimeGap}
    Set Test Variable    ${scheduleDownloadTime}    ${timeToSet}
    ${targetDownloadDuration}    Replace String    ${eleCampaignManagerScheduleDuration}    TIME    ${scheduleRetryDuration}
    ${targetDownloadScheduleTime}    Replace String    ${eleCampaignManagerScheduleTime}    TIME    ${timeToSet}
    Select From Dropdown Item    ${eleCampaignManagerScheduleFrequencyClick}    ${targetDownloadFreqency}
    Select From Dropdown Item    ${eleCampaignManagerScheduleTimeClick}    ${targetDownloadScheduleTime}
    Run Keyword If    '${scheduleRetryDuration}'!='1'    Select From Dropdown Item    ${eleCampaignManagerScheduleDurationClick}    ${targetDownloadDuration}
    Sleep    2s

Select Firmware Timezone
    [Documentation]    keyword to select the timezone for rule creation
    ...                 Argument:
    ...                    timezone -> timezone to set
    [Arguments]    ${timezone}
    ${timezoneSelector}    Replace String    ${drpDwnMultiCampaignFirmwareNewRuleTimezone}    TIMEZONE    ${timezone}
    Select From Dropdown Item    ${drpDwnMultiCampaignFirmwareNewRuleTimezoneClick}    ${timezoneSelector}

Get The Next Quad Wait Time
    ${QUARTERS}    Set Variable    ['00', '15', '30', '45']
    ${current_time}    Get Device Time
    Log    Current Time: ${current_time}
    ${hour}        Set Variable    ${current_time.split(':')[0]}
    ${minute}      Set Variable    ${current_time.split(':')[1]}
    ${second}      Set Variable    ${current_time.split(':')[2]}
    ${hour}    Run Keyword If    '${hour}' != '00'    Convert To Integer    ${hour.lstrip('0')}    ELSE    Set Variable    0
    ${minute}      Run Keyword If    '${minute}' != '00'    Convert To Integer    ${minute.lstrip('0')}    ELSE    Set Variable    0
    ${second}      Run Keyword If    '${second}' != '00'    Convert To Integer    ${second.lstrip('0')}    ELSE    Set Variable    0
    ${current_seconds}    Evaluate       (${minute} * 60) + ${second}

    ${next_quad_minute}    Evaluate    min([int(q) for q in ${QUARTERS} if int(q) > ${minute}], default=0)
    ${next_hour}           Evaluate       int(${hour}) + 1 if ${next_quad_minute} == 0 else ${hour}

    ${next_quad_seconds}   Evaluate       (${next_hour} * 3600) + (${next_quad_minute} * 60) - (${hour} * 3600 + ${current_seconds})
    Log    ${next_quad_seconds}
    Return From Keyword    ${next_quad_seconds}

Get Device Time
    ${currentTime}    SSHExecute    ${deviceTimezoneCli}
    ${historytime}    Fetch From Right    ${currentTime}    ${deviceTimezoneMatch}
    ${dateVal}    Get Regexp Matches    ${historytime}    (\\S.*)T\\S+
    ${dateVal}    Set Variable    ${dateVal}[0]
    ${deviceTime}    Convert Date    ${dateVal.strip()}    result_format=%H:%M:%S    date_format=%Y-%m-%dT%H:%M:%S
    Log    ${deviceTime}
    Return From Keyword    ${deviceTime}
    
Create Dictionary From Rule Report CSV
    [Documentation]    This function used to create a dictonary from csv
    ...                - Arguments:
    ...                    csvData-> csv file
    ...                    whichIndexAsKey -> dictonary key select from which index
    ...                - Return:
    ...                        dataDict -> Dictonary of csv
    [Arguments]    ${filename}
    ${reportData}    Set Variable    None
    Log    ${filename}
    ${usrPath}    Get Environment Variable    UserProfile
    ${sysDownloadPath}    Set Variable    ${usrPath}\\Downloads
    ${FILES}    OperatingSystem.List Files In Directory    ${sysDownloadPath}
    Log    ${FILES}
    ${fileName}    OperatingSystem.List Files In Directory    ${sysDownloadPath}    ${filename}
    ${file_content}    OperatingSystem.Get File    ${sysDownloadPath}\\${fileName}[0]    encoding=UTF-8
    ${csvData}    Split To Lines    ${file_content}
    Log    ${csvData}[0]
    ${csvHeaders}    Split String    ${csvData}[0]    ,
    ${headerLen}    Get Length    ${csvHeaders}
    ${csvDataLength}    Get Length    ${csvData}
    ${dataDict}    Create Dictionary
    FOR    ${i}    IN RANGE    1    ${csvDataLength}
        ${attempts}    Get Regexp Matches    ${csvData}[${i}]    \\[DeviceAttempt.*]
        Log    ${attempts}
	    ${rowData}    Split String    ${csvData}[${i}]    ,
	    ${rowDataLen}    Get Length    ${rowData}
	    Continue For Loop If    '${rowDataLen}'<='1'
	    ${entry}    Evaluate    dict(zip(${csvHeaders},${rowData}))
	    Set To Dictionary    ${dataDict}    ${rowData}[0]=${entry}
	    Log	${dataDict}[${rowData}[0]]
	    Set To Dictionary    ${dataDict}[${rowData}[0]]    Attempts=${attempts}
    END
    Log	${dataDict}
    Return From Keyword    ${dataDict}