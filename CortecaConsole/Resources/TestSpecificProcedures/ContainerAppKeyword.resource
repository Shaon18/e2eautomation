*** Settings ***
Resource     ../KeywordDefinition/CommonKeywords.robot
Variables    ../JavaScriptCodes/executeJavaScriptCodeCorteca.py
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/CortecaConsoleLocators.py
Resource    LoginPageProcedures.robot
Resource    ../KeywordDefinition/ssh.resource
Variables    ../Resources/TestDatas.py

Library    DateTime

*** Keywords ***
Open Application From Portal
    [Arguments]    ${macToEnter}=${EMPTY}
    [Documentation]    Open the Cortea console home page and open the application tab
    Log    ${macToEnter}
    Login To Corteca Console
    Open Corteca Console Home Page    macToEnter=${macToEnter}
    #Run Keyword If    ${HomeTroubleshooting}    Press Click Element    ${eleNewPortal}
    #Press Click Element    ${eleNewPortal}
    Press Click Element    ${eleApplicationTab}
    Sleep    ${sleepMin}
    Wait Until Element Is Enabled    ${eleApplicationPage}    timeout=60s
    Capture Page Screenshot    

Install Container Application
    [Documentation]    Select given app and instal the given version
    ...            Argument:
    ...                   appName-> F-Secure Sense/M-Lab Speed Test/Nokia Fingerprint
    [Arguments]    ${appName}    ${version}    ${initalInstall}=${False}    ${negCheck}=${False}    ${mac}=${Root}[mac1]
    [Teardown]    Close All Browsers
    Open Application From Portal    ${mac}
    Sleep    ${sleepMax}
    Select Application    ${appName}
    Run Keyword If    ${initalInstall}    No App Installed Page Validation
    Log    **** Select application and version to install ****
    #Check Element    ${eleAppCurrentSelection}
    #${currentAppSelect}    Get Text    ${eleAppCurrentSelection}
    #${status}    Should Not Match Regexp    ${currentAppSelect}    ${appName}
    #Run Keyword If    ${status}    Select Application    ${appName}
    Sleep    ${sleepMax}
    ${version}    Replace String    ${eleSelectAppVersionDropdownSelect}    VERSION    ${version}
    ${status}    Run Keyword And Return Status    Select From Dropdown Item    ${eleSelectAppVersionDropdownClick}    ${version}
    Press Click Element    ${eleApplicationContainerInstall}
    Sleep    ${sleepMin}
    Wait Until Page Contains    ${installSuccessToaster}    timeout=300
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Page Should Contain    ${installSuccessToaster}
    Logout From Corteca Console

No App Installed Page Validation
    [Documentation]    Keyword to check there is no application installed
    Check Element    ${eleFsecureNoAppInstalled}
    Check Element    ${eleFsecureNoAppInstalledText}
    ${text}    Get Text    ${eleFsecureNoAppInstalledText}
    Should Match Regexp    ${text}    ${noApplicationInstalled}

Select Application
    [Documentation]    Keyword to select the application    
    [Arguments]    ${application}
    Run Keyword If    '${application}'=='F-Secure Sense'    Press Click Element    ${eleFsecureApplicationContainerTab}
    Run Keyword If    '${application}'=='M-Lab Speed Test'    Press Click Element    ${eleMLabApplicationContainerTab}
    Run Keyword If    '${application}'=='Nokia Fingerprint'    Press Click Element    ${eleFPApplicationContainerTab}
    Sleep    ${sleepMin}

Validate Installed Application From Portal
    [Documentation]    Keyword to validate the Installed application card
    [Arguments]    ${appName}    ${version}    ${runningStatus}    ${autostartStatus}
    Log    **** Open application tab and verify the installed apps
    Open Application From Portal
    Sleep    ${sleepMax}
    ${appList}    Get Installed Application List From Portal
    Log    ${appList}
    Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appName}][Name]    ${appName}
    Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appName}][Version]    ${version}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${appList}[${appName}][Running]    ${runningStatus}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${appList}[${appName}][Autostart]    ${autostartStatus}
    Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appName}][Remove]    close-icon
    Logout From Corteca Console
    
Get Installed Application List From Portal
    [Documentation]    Javascript to get the installed apps list and return as a dictionary
    ${appList}    Set Variable    []
    ${status}    Run Keyword And Return Status    Check Element    ${eleFsecureNoAppInstalled}
    Return From Keyword If    ${status}    ${appList}
    ${appList}    Execute Javascript    ${containerApplicationInstalled}
    Return From Keyword    ${appList}

App Install Events Validation
    [Documentation]    History validation
    [Arguments]    ${version}    ${appStatus}    ${autoStart}    ${systemTime}    ${appName}="F-Secure Sense"
    Log    **** Open application tab and verify the history for installation events
    Open Application From Portal
    Sleep    ${sleepMax}
    ${versionEvent}    Get Text    ${eleApplicationEventTableRow1}
#    ${appStatusEvent}    Get Text    ${eleApplicationEventTableRow3}
#    ${autoStartEvent}    Get Text    ${eleApplicationEventTableRow2}
    Run Keyword And Continue On Failure    Should Match Regexp    ${versionEvent}    ${appName}.*Installation.*${version}.*successful
#    Run Keyword And Continue On Failure    Should Match Regexp    ${appStatusEvent}    ${appName}.*Status.*update.*(${appStatus}).*successful
#    Run Keyword And Continue On Failure    Should Match Regexp    ${autoStartEvent}    ${appName}.*Auto start.*(${autoStart}).*successful
    Run Keyword And Continue On Failure    Get And Compare The History Time    ${versionEvent}    ${appName}    ${systemTime}
#    Run Keyword And Continue On Failure    Get And Compare The History Time    ${appStatusEvent}    ${appName}    ${systemTime}
#    Run Keyword And Continue On Failure    Get And Compare The History Time    ${autoStartEvent}    ${appName}    ${systemTime}
    Logout From Corteca Console

Get And Compare The History Time
    [Documentation]    Get the History update Time and Compare with specified system time
    [Arguments]    ${time}    ${appName}    ${systemTime}    ${maxgap}=${epocContainerMax}
    ${historytime}    Fetch From Left    ${time}    ${appName}
    ${getYear}    Get Current Date    result_format=%Y
    ${historytime}    Set Variable    ${getYear} ${historytime}
    ${historyEpoctimePortal}    Convert Date    ${historytime.strip()}    ${epochTime}    date_format=%Y %b %d, %I:%M %p
    ${time}    Evaluate    ${systemTime}-${historyEpoctimePortal}
    Should Be True    ${epocContainerMin}<${time}<${maxgap}

Get Device Time In Epoch
    [Documentation]    Get the Device time and convert to epoc.Returns the epoc value
    ${currentTime}    SSHExecute    ${deviceTimezoneCli}    ${Root}[ip]    ${Root}[telnet_vtysh]
    ${historytime}    Fetch From Right    ${currentTime}    ${deviceTimezoneMatch}
    ${dateVal}    Get Regexp Matches    ${historytime}    (\\S.*)T\\S+
    ${dateVal}    Set Variable    ${dateVal}[0]
    ${historyEpoctime}    Convert Date    ${dateVal.strip()}    ${epochTime}    date_format=%Y-%m-%dT%H:%M:%S
    Log    ${historyEpoctime}
    Return From Keyword    ${historyEpoctime}

Uninstall The Application And History Validation
    [Documentation]    Keyword to uninstall the application
    [Arguments]    ${appName}    ${version}    ${mac}=${Root}[mac1]
    Open Application From Portal    ${mac}
    Sleep    ${sleepMax}
    ${appList}    Get Installed Application List From Portal
    Log    ${appList}
    ${listEmptyStatus}    Run Keyword And Return Status    Should Be Equal As Strings    ${appList}    []
    Return From Keyword If    ${listEmptyStatus}

    Should Be Equal As Strings    ${appList}[${appName}][Name]    ${appName}    msg="Either container app not Installed or wrong container app Name"
    ${Index}    Convert To String    ${appList}[${appName}][TableRow]
    ${eleUninstallAppSelector}    Replace String    ${eleUninstallApp}    APPINDEX    ${Index}
    Press Click Element    ${eleUninstallAppSelector}
    Wait Until Element Is Visible    ${eleUninstallConfirm}
    Press Click Element    ${eleUninstallConfirm}
    Wait Until Page Contains    ${uninstallSuccessToaster}    timeout=300
#    Verify the Toaster Message    ${uninstallInitiated}    timeout=300
#    Verify the Toaster Message    ${uninstallSuccessToaster}    timeout=300
    Run Keyword And Continue On Failure    Page Should Contain    ${uninstallSuccessToaster}
    ${appList}    Get Installed Application List From Portal
    Log    ${appList}
    ${statusEmpty}    Run Keyword And Return Status    Should Be Equal As Strings    ${appList}    ${None}
    ${statusEntry}    Run Keyword And Return Status    Should Not Contain    ${appList}    ${appName}
    Should Be True    ${statusEmpty} or ${statusEntry}
    Capture Page Screenshot
    ${unInstallEvent}    Get Text    ${eleApplicationEventTableRow1}
    Run Keyword And Continue On Failure    Should Match Regexp    ${unInstallEvent}    ${appName}.*Uninstallation.*${version}.*successful
    Logout From Corteca Console

Validate Router ManifestKey
    [Documentation]    Keywrod to validate Router manifest key
    [Arguments]    ${initial}=${False}
    ${manifestKey}    Sshlogin_Execute    ${Root}[ip]    ${Root}[telnet_vtysh]    ${containerManifestKey}
    ${manifestKey}    Fetch From Right    ${manifestKey}    "value":
    Run Keyword If    ${initial}    Should Not Match Regexp    ${manifestKey}    (\\w+-){4}\\w+    ELSE    Should Match Regexp    ${manifestKey}    (\\w+-){4}\\w+

Cli Check After App Install
    [Arguments]    ${appName}    ${versionExpected}    ${AutoStartExpected}    ${RequestedStateExpected}    ${StatusExpected}
    ${appListCount}    Sshlogin_Execute    ${Root}[ip]    ${Root}[telnet_vtysh]    ${containerExecutionUnit}
    ${count}    Get Regexp Matches    ${appListCount}    last_index = \\d+
    Log    ${count}
    ${count}    Get Regexp Matches    ${count}[0]    \\d+
    FOR    ${i}    IN RANGE    1    ${count}[0]+1
        ${i}    Convert To String    ${i}
        ${command}    Replace String    ${containerCliName}    INDEX    ${i}
        ${manifestKey}    Sshlogin_Execute    ${Root}[ip]    ${Root}[telnet_vtysh]    ${command}
        ${status}    Run Keyword And Return Status    Should Match Regexp    ${manifestKey}    ${appName}
        Continue For Loop If    not ${status}
        ${version}    Replace String    ${containerCliVersion}    INDEX    ${i}
        ${autoStart}    Replace String    ${containerCliAutostart}    INDEX    ${i}
        ${RequestedState}    Replace String    ${containerCliRequestedState}    INDEX    ${i}
        ${statusOutput}    Replace String    ${containerCliStatus}    INDEX    ${i}
        ${versionCli}    Sshlogin_Execute    ${Root}[ip]    ${Root}[telnet_vtysh]    ${version}
        ${autoStartCli}    Sshlogin_Execute    ${Root}[ip]    ${Root}[telnet_vtysh]    ${autoStart}
        ${RequestedStateCli}    Sshlogin_Execute    ${Root}[ip]    ${Root}[telnet_vtysh]    ${RequestedState}
        ${statusOutputCli}    Sshlogin_Execute    ${Root}[ip]    ${Root}[telnet_vtysh]    ${statusOutput}
        Run Keyword And Continue On Failure    Should Match Regexp    ${versionCli}    ${versionExpected}
        Run Keyword And Continue On Failure    Should Match Regexp    ${autoStartCli}    ${AutoStartExpected}
        Run Keyword And Continue On Failure    Should Match Regexp    ${RequestedStateCli}    ${RequestedStateExpected}
        Run Keyword And Continue On Failure    Should Match Regexp    ${statusOutputCli}    ${StatusExpected}
        Exit For Loop If    ${status}
    END

Process Running Check
    [Arguments]    ${cmd}    ${process}    ${positive}=${True}
    ${processCmd}    Sshlogin_Execute    ${Root}[ip]    ${Root}[telnet_vtysh]    ${cmd}
    Run Keyword If    ${positive}    Should Match Regexp    ${processCmd}    ${process}    ELSE    Should Not Match Regexp    ${processCmd}    ${process}	

Validate Uninstalled Application From Portal And History Validation
    [Documentation]    Keyword to validate the Installed application card
    [Arguments]    ${macList}    ${appName}    ${appVersion}
    FOR    ${mac}    IN    @{macList}
        Log    **** Open application tab and verify the installed apps
        Open Application From Portal    macToEnter=${mac}
        Sleep    ${sleepMax}
        ${appList}    Get Installed Application List From Portal
        Log    ${appList}
        ${statusEmpty}    Run Keyword And Return Status    Should Be Equal As Strings    ${appList}    ${None}
        ${statusEntry}    Run Keyword And Return Status    Should Not Contain    ${appList}    ${appName}
        Should Be True    ${statusEmpty} or ${statusEntry}
        ${unInstallEvent}    Get Text    ${eleApplicationEventTableRow1}
        Run Keyword And Continue On Failure    Should Match Regexp    ${unInstallEvent}    ${appName}.*Uninstallation.*${appVersion}.*successful
        Logout From Corteca Console
    END

Validate Installed Application From Portal And History Validation
    [Documentation]    Keyword to validate the Installed application card
    [Arguments]    ${macList}    ${appName}    ${version}    ${runningStatus}    ${autostartStatus}    ${systemTime}=''    ${historyTimeValidation}=${True}
    Log    **** Open application tab and verify the installed apps
    FOR    ${mac}    IN    @{macList}
        Open Application From Portal    ${mac}
        Sleep    ${sleepMax}
        ${appList}    Get Installed Application List From Portal
        Log    ${appList}
        Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appName}][Name]    ${appName}
        Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appName}][Version]    ${version}
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${appList}[${appName}][Running]    ${runningStatus}
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${appList}[${appName}][Autostart]    ${autostartStatus}
        Run Keyword And Continue On Failure    Should Match Regexp    ${appList}[${appName}][Remove]    close-icon
        Log    **** verify the history for installation events ****
        ${versionEvent}    Get Text    ${eleApplicationEventTableRow1}
        Run Keyword And Continue On Failure    Should Match Regexp    ${versionEvent}    ${appName}.*Installation.*${version}.*successful
        Run Keyword If    ${historyTimeValidation}    Get And Compare The History Time    ${versionEvent}    ${appName}    ${systemTime}
        Logout From Corteca Console
    END