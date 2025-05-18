*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Library         JSONLibrary
Library         ../../InputFiles/pvCases.py
Variables      ../../InputFiles/EnvironmentInput.py
Variables        ../../Locators/CortecaConsoleLocators.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource        ../../Resources/KeywordDefinition/ApiRequest.resource
Resource        ../../Resources/KeywordDefinition/CommonKeywords.robot
Resource        ../../Resources/TestSpecificProcedures/DeviceDetails.resource


*** Keywords ***
Verification of Connected devices card in network page
    ClickText    Network   Event history
    Log   **** Verifying Connected devices card in network page"
    DeviceMemDataFromCloud
    Get Total Connected Clients MAC List
    Verify Text    Connected devices (${OnlineCount})
    FOR    ${client}    IN    @{totalClientMAC}
          Run Keyword And Continue On Failure    Verify Text   ${client}
    END
    Log   **** Verifying Network slices card in network page"
    Run Keyword And Continue On Failure     VerifyElement    ${eleNetworkSliceCard}

Verify root wifipoint details
    [Arguments]    ${dev1}
    ClickText    Network   Event history
    Run Keyword    Check Firmware Connectivity And Device Info Card  ${dev1}
    Run Keyword And Continue On Failure    VerifyText     Last 30 days
    Run Keyword And Continue On Failure    VerifyText    Disconnection
    Run Keyword And Continue On Failure    VerifyText    Average disconnection time
    Run Keyword And Continue On Failure    Check Online Percent
    Run Keyword And Continue On Failure    Check Wifi Scan Graph  ${dev1}
    Run Keyword And Continue On Failure    Check Network History

Verify ext wifipoint details
    [Arguments]    ${dev2}
    ClickText    Network   Event history
    Run Keyword    Check Firmware Connectivity And Device Info Card  ${dev2}
    ${healthData}=    QWeb.Get Text        ${health_card}
    ${roamingData}=   QWeb.Get Text        ${roaming_history}
    ${scanData}=      QWeb.Get Text        ${wifiscangraph}
    Run Keyword If	"${${dev2}}[ConnectionType]" == "wifi"  Check Wifi Scan Graph   ${dev2}
    IF  "${${dev2}}[ConnectionType]" == "ethernet"
         Run Keyword And Continue On Failure    Should Contain   ${healthData}    N/A for Ethernet
         Run Keyword And Continue On Failure    Should Contain   ${roamingData}    N/A for Ethernet
         Run Keyword And Continue On Failure    Should Contain   ${scanData}    N/A for Ethernet
    ELSE
         Run Keyword And Continue On Failure   VerifyElement    ${health_card}
         Run Keyword And Continue On Failure   VerifyAll   ${health}
         Run Keyword And Continue On Failure   Should Not Contain  ${healthData}   unknown
         Run Keyword And Continue On Failure   VerifyElement    ${roaming_history}
    END
    Run Keyword And Continue On Failure    Check Network History


check wifi scan graph
    [Arguments]      ${dev}
    QWeb.Click Element    ${reload_icon}
    ${bands}    Return List Of Band   ${DevicebandList}       ${${dev}}[bconType]
    FOR    ${i}    IN    @{bands}
        Run Keyword And Continue On Failure    VerifyText    ${i}
        Qwebelement.clicktext    ${i}
        VerifyElement    ${wifiscangraph}     30s
    END


check network history
    FOR    ${i}    IN    @{dropdownlist}
       QWeb.Click Element        ${dropdown}
       Qwebelement.clicktext    ${i}
       VerifyElement    ${networkhistorychecker}
    END

Verification of Wifi-points Detail
    Verify root wifipoint details      Root
    FOR   ${i}  IN   @{meshNodes}
        Verify ext wifipoint details     ${i}
    END

check firmware connectivity and device info card
    [Arguments]    ${dev}
    Qwebelement.clicktext    ${${dev}}[serial_num]
    Sleep  30s
    ${portalConnInfo}=    QWeb.Get Text        ${connectivity_info}
    Log   ${DeviceStream}
    Log    ${portalConnInfo}
    Run Keyword  Should Contain    ${portalConnInfo}    Connection to cloudOnline
    Run Keyword And Continue On Failure    Should Contain    ${portalConnInfo}    Serial number${${dev}}[serial_num]
    Run Keyword And Continue On Failure    Should Contain    ${portalConnInfo}    WiFi point type${${dev}}[model]
    Run Keyword And Continue On Failure    Should Not Contain    ${portalConnInfo}    IPv6 addressN/A
    ${portalFirmware}=    QWeb.Get Text        ${firmware}
    Log     ${portalFirmware}
    Run Keyword And Continue On Failure    Should Contain All Strings    ${portalFirmware}        Version${${dev}}[active_firmware]   Date     Firmware Update
    Sleep  10s
    ${portalDeviceInfo}=    QWeb.Get Text        ${device_info}
    Log    ${portalDeviceInfo}
    Run Keyword And Continue On Failure    Should Contain    ${portalDeviceInfo}    Device name${${dev}}[TopoDefName]
    Run Keyword And Continue On Failure    Should Contain    ${portalDeviceInfo}    Model${${dev}}[model]
    Run Keyword And Continue On Failure    Should Contain    ${portalDeviceInfo}    MAC address${${dev}}[mac]
    ${portalMainInfo}=    QWeb.Get Text        ${maint_info}
    Run Keyword And Continue On Failure  Should Contain All Strings  ${portalMainInfo}    Advanced metrics   Radio management    Reboot device    Factory reset device
    Sleep    100s
    ${portalResInfo}    Run Keyword If	'${DeviceStream}'=='USP'	  QWeb.Get Text        ${resources_info}
    Run Keyword If  '${DeviceStream}'=='USP'    Should Contain All Strings  ${portalResInfo}    Persistent memory usage    Non Persistent memory usage     CPU usage
    Log  ${TopologyAssociatedDevices}
    Run Keyword If   ${${dev}_Clients} > 0    QWeb.Execute Javascript     ${TopologyAssociatedDevices}    $count
    ${clientscount_int}   Convert To Integer  ${${dev}_Clients}
    Run Keyword If   ${${dev}_Clients} > 0   Should be equal    ${clientscount_int}    ${count}

check online percent
    ${online_url}    Set Variable    /measures/networks/${Root}[mac]/devices/${Root}[mac]/diagnostics
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=${NewUser_Credentials1}[X-ServiceType]    Content-Type=${NewUser_Credentials1}[Content-Type]
    ${jsonPayload}=        Set Variable         {"last_month": "true"}
    ${jsonPayload}=    Convert String To Json       ${jsonPayload}
    ${RetResponse}=    POST On Session       ${session_id}    ${online_url}    headers=${headers}  json=${jsonPayload}
    ${RetResponse}=   Set To Dictionary       ${RetResponse.json()}
    Log      ${RetResponse}
    ${online_time}    Set Variable    ${RetResponse}[last_month][offline_percentage]
    ${online_time}    Convert To Integer    ${online_time}
    ${online_disconnection}    Set Variable    ${RetResponse}[last_month][disconnections]
    ${online_avg_disc}    Set Variable    ${RetResponse}[last_month][avg_disconnect_time]
    Run Keyword And Continue On Failure    Should Be True        '${online_disconnection}'>='0'
    Run Keyword And Continue On Failure    Should Be True        '${online_avg_disc}'>='0'
    Run Keyword And Continue On Failure    Should Be True        '${online_time}'>='0'
    Run Keyword If    ${online_time} > 100     Fail
