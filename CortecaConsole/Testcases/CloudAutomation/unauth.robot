*** Settings ***
Library         QWeb
Library         String
Library         Collections
Library         ../../Resources/commonPythonKeywords/libwrap.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/KeywordDefinition/ApiRequest.resource
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource
Variables       ../../Resources/JavaScriptCodes/cloudautomationJavaScriptCode.py
Variables       ../../InputFiles/EnvironmentInput.py
Variables       ../../InputFiles/sampleSetupFileFormat_G-2425-GA.py

*** Test Cases ***
Unauth_list
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${password}=    Set Variable    ${Root}[ssid_defa_password]
    Run Keyword And Ignore Error    wifipoint_provision_API    ${macaddress}    ${password}
    Open Browser    https://homeconsole1.stg.homewifi.nokia.com/    Chrome
    Maximize Window
    qwebelement.typetext    masteruser    username
    qwebelement.typetext    'Masteruser@123    password
    Qwebelement.clicktext    Login
    Qwebelement.clicktext    Admin
    Sleep    15s
    cloudconnectioncheck    ${Root}[ip]    ${Root}[telnet_vtysh]  
    ExpectFileDownload
    ${status_code}=    Set Variable    False
    Qwebelement.clicktext    Download
    VerifyFileDownload    timeout=20s
    ${macaddress}=    Set Variable    ${Root}[mac1]
    ${password}=    Set Variable    ${Root}[ssid_defa_password]
    ${resp}=    Run Keyword    libwrap.Macpresentunauth    ${macaddress}
    Should Be Equal    ${resp}    ${status_code}
    Run Keyword    libwrap.remove_file_func_unauth
    Log To Console    check mac not present in the unauth table
    Run keyword and continue on failure    wifipoint_provision_API    ${macaddress}    ${password}
    Qw.closebrowser
    Sleep    15s
    delete_mac_provision    ${Root}[mac1]
    Sleep    10s
    Open Browser    https://homeconsole1.stg.homewifi.nokia.com/    Chrome
    Maximize Window
    cloudconnectioncheck    ${Root}[ip]    ${Root}[telnet_vtysh]   
    qwebelement.typetext    masteruser    username
    qwebelement.typetext    'Masteruser@123    password
    Qwebelement.clicktext    Login
    Qwebelement.clicktext    Admin
    ${status_code}=    Set Variable    True
    IF    '${DeviceStream}'=='HA'
        ${ssh_output}=    SSHExecute
        ...    ${ipaddress}
        ...    ${password2}
        ...    ${restart_plasmodium}
        Sleep    10s
        ${ssh_output}=    sshlogin_Execute    ${ipaddress}    ${password2}    netstat -anp | grep -i plas
        Should Not Contain     Contain    ${ssh_output}    ESTABLISHED
    ELSE IF    '${DeviceStream}'=='USP'
        ${ssh_output}=    sshlogin_Execute     ${ipaddress}    ${password2}   cat /tmp/mqtt_nwcc_status
        Should Not Contain    ${ssh_output}    Connected
    END
    Qwebelement.clicktext    Download
    VerifyFileDownload    timeout=20s
    ${resp}=    Run Keyword    libwrap.Macpresentunauth    ${macaddress}
    Should Be Equal    ${resp}    ${status_code}
    Run Keyword    libwrap.remove_file_func_unauth
    [Teardown]    Qw.closebrowser
