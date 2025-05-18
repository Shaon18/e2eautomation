*** Settings ***
Library         QWeb
Resource        ../Resources/KeywordDefinition/Qtwebkeywords.resource
Library         ../Resources/commonPythonKeywords/RemoteloggingFileAccess.py
Library         Collections
Variables       ../Locators/RemoteLogging.py
Variables       ../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py


*** Test Cases ***
# manually enable banglore vpn before triggering the cases
BBDT-353189 NWCC_USP_RemoteLogging_02 | Verify Remote Logging feature working with VPN Enabled
    [Documentation]    This case covers:
    ...    BBDT-353188    NWCC_USP_RemoteLogging_01 | Verify Remote Logging page based on Login Role defined in Keycloak
    ...    BBDT-353189    NWCC_USP_RemoteLogging_02 | Verify Remote Logging feature working with VPN Enabled
    ...    BBDT-353193    NWCC_USP_RemoteLogging_06 | Verify PIN Access validation for Remote Logging page
    ...    steps are as follows:
    ...    Check if Corteca console should display Remote Logging section in Troubleshooting dashboard when “sv_remote_access” keycloak role associated to user login credentials.
    ...    Check if the Remote Logging feature will function and give output only when Corteca Console is accessed, after connecting it via VPN.    Default VPN configured will be 'Bangalore VPN'    ENV : "name": "REMOTSHELL_ALLOWED_CIDR_RANGE","value": ""}    135.245.190.5/32 - Sydney VPN    131.228.104.64/27 - Hong Kong VPN IP Range
    ...    Check upon giving a command input in Input Box, it should prompt for a PIN dialogue box wherein the user needs to give the 'shell password2' of the WiFi Point in order to access the output.PIN = shell password2
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move to Remote Logging page
    Type Text    ${RemoteLog_input_cmd}    ritool dump
    Click Text    Execute
    IF    '${DeviceStream}'=='USP'
        Type Text    ${pin_input}    ${Root}[telnet_vtysh]
        Click Text    Submit
    ELSE
        Log To Console    HA device
    END
    sleep    30s
    # below javascript code stores output generated on screen in d1.
    Execute Javascript    ${Get_displayed_output}    $textOnscreen
    Log To Console    ${textOnscreen}
    verifyOutput    ${textOnscreen}
    sleep    60s
    # navigating to any other page for the history to get updated after waiting.
    Click Text    Profiles
    Click Text    Remote Logging
    Verify Text   Remote shell command ritool is executed for the WiFi point    timeout= 60s

BBDT-353194 NWCC_USP_RemoteLogging_07 | Verify Wrong PIN Access validation for Remote logging page
    [Documentation]    This case covers:
    ...    BBDT-353194    NWCC_USP_RemoteLogging_07 | Verify Wrong PIN Access validation for Remote logging page
    ...    BBDT-353195    NWCC_USP_RemoteLogging_08 | Verify Lock Enabled due to multiple Wrong PIN input
    ...    steps are as follows:
    ...    Check upon giving a Wrong PIN, it should thrown an Error notification text.History Event should be logged for the PIN failure event.
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move to Remote Logging page
    Type Text    ${RemoteLog_input_cmd}    ritool dump
    Click Text    Execute
    Type Text    ${pin_input}    1234
    Click Text    Submit
    Verify Text    Wrong pin!    timeout=30s
    Type Text    ${pin_input}    12345
    Click Text    Submit
    Verify Text    Wrong pin!    timeout=30s
    Type Text    ${pin_input}    12345
    Click Text    Submit
    Verify Text    Device is locked!    timeout=30s
    # after checking wrong pin scenarios waiting for 10mins to get the remote logging page of device up again.
    sleep    600s
    Type Text    ${RemoteLog_input_cmd}    ritool dump
    Click Text    Execute
    IF    '${DeviceStream}'=='USP'
        Type Text    ${pin_input}    ${Root}[telnet_vtysh]
        Click Text    Submit
    ELSE
        Log To Console    HA device
    END
    sleep    30s
    Execute Javascript    ${Get_displayed_output}    $textOnscreen
    Log To Console    ${textOnscreen}
    verifyOutput    ${textOnscreen}

BBDT-353208 NWCC_USP_RemoteLogging_21 | Verify Error codes for Remote Logging feature
    [Documentation]    steps are as follows:
    ...    Hit the various errors in the remote logging page
    ...    Please check the error table in descrption in Jira for more information
    ...    These following commands are given by vinodh.kankanalu@nokia.com:
    ...    cfgcli -a, wl -i wl1 status for 404 error
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move to Remote Logging page
    Type Text    ${RemoteLog_input_cmd}    wl -i wl1 status
    Click Text    Execute
    IF    '${DeviceStream}'=='USP'
        Type Text    ${pin_input}    ${Root}[telnet_vtysh]
        Click Text    Submit
    ELSE
        Log To Console    HA device
    END
    Verify Text    Requested shell command not supported on this Wi-Fi Point    timeout=30s
    Type Text    ${RemoteLog_input_cmd}    cfgcli -a
    Click Text    Execute
    IF    '${DeviceStream}'=='USP'
        Type Text    ${pin_input}    ${Root}[telnet_vtysh]
        Click Text    Submit
    ELSE
        Log To Console    HA device
    END
    Verify Text    Not supported in this device.    timeout=30s

RemoteLogging_commands_OUTPUT_Validation
    [Documentation]    steps are as follows:
    ...    Run the various commands in RemoteLogging_Cmds and check if output generated
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move to Remote Logging page
    FOR    ${i}    IN    @{RemoteLogging_Cmds}
        Type Text    ${RemoteLog_input_cmd}    ${i}
        Click Text    Execute
        IF    '${DeviceStream}'=='USP'
            Type Text    ${pin_input}    ${Root}[telnet_vtysh]
            Click Text    Submit
        ELSE
            Log To Console    HA device
        END
        sleep    30s
        Execute Javascript    ${Get_displayed_output}    $d2
        ${res3}=    verifyOutput    $d2
        Should Be True    ${res3}
    END

NWCC_USP_RemoteLogging_18 | Verify Copy to clipboard & Download option in Remote logging page
    [Documentation]    steps are as follows:
    ...    Check the below options to retrieve Remote logging command outputs,1. Enter the command to be executed.2. Check if the Output is shown in the output window.3. Copy to clipboard - shall copy the command output and pasted at required location.4. Download - shall download the command output in Notepad.
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move to Remote Logging page
    Type Text    ${RemoteLog_input_cmd}    ritool dump
    Click Text    Execute
    IF    '${DeviceStream}'=='USP'
        Type Text    ${pin_input}    ${Root}[telnet_vtysh]
        Click Text    Submit
    ELSE
        Log To Console    HA device
    END
    sleep    30s
    Execute Javascript    ${Get_displayed_output}    $d3
    Should Not Be Empty    $display_output
    Click Text    Copy to Clipboard
    Verify Text    Text is copied successfully    timeout=30s
    # the below 4 commands will select the present text in input field and then give paste to check if copied successfully.
    PressKey    ${RemoteLog_input_cmd}    {CONTROL + A}
    Click Text    Copy to Clipboard
    Verify Text    Text is copied successfully    timeout=30s
    PressKey    ${RemoteLog_input_cmd}    {CONTROL + V}
    sleep    10s
    # stores the current text in input field and store it in inputText variable
    Execute Javascript    ${Get_text_of_input}    $inputText
    sleep    5s
    # this will compare verify if the text is correct
    ${res1}=    verify_copy_output    $d3    $inputText
    Should Be True    ${res1}
    Click Text    Download
    Sleep    10s
    # this command will check if file if not empty and contains commands.
    Log To Console    $d3
    ${res2}=    check_remotelogging_file  ${Root}[mac]   ${DownloadFolderPath}
    Should Be True    ${res2}
    # checking session log csv file
    Click Text    Session log
    Verify Text    Success    timeout= 10s
    ${res3}=    check_remote_logging_csv_file     ${DownloadFolderPath}
    Should Be True    ${res2}


