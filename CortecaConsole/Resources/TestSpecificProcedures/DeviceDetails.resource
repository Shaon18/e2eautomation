*** Settings ***
Library         String
Library         Collections
Library         RequestsLibrary
Library         DateTime
Library         QWeb
Library         ../../InputFiles/imagecomparision.py
Resource        ../../Resources/KeywordDefinition/ApiRequest.resource
Variables       ../../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py
Library         ../../Resources/commonPythonKeywords/checktable.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource


*** Keywords ***

Verify Devices page
    Log   ****Check Device, SiganlStrength, Connected/Not Connected DeviceCard Tabs****
    QWeb.Click Element    ${eleHomeDashboardDeviceTab}
    Sleep    30s
    Verify Element    ${eleDevicePageSignalStrength}
    Verify Element    ${eleDevicePageConnectedDevicesCard}
    DeviceMemDataFromCloud


Verify Connected/Not connected Device Tab
    Click Text    View more
    Verify Text    Connected devices (${OnlineCount})
    Qweb.Click Element     ${eleDevicePageNotConnectedDevice}
    Verify Text    Disconnected devices (${OfflineCount})
    Qweb.Click Element   ${eleDevicePageConnectedDevice}
    #Qweb.Get Text   ${eleDevicePageConnectedDevicesTable}
    Log   validating dropdown list values
    validate device page filter list


validate device page filter list
    Click Text    Field filter
    ${actual}=   Qweb.Get Text  ${eleDevicePageDropDown}
    Log    ${actual}


Verify Each Devices Info Page
    Log  ****Getting the total client List ****
    Get Total Connected Clients
    Log  ****Getting the total List of MAC ****
    Get Total Connected Clients MAC List
    FOR    ${client}    IN    @{totalClientMAC}
        Log   ${client}
        QWeb.Click Element    ${eleHomeDashboardDeviceTab}
        Click Text   ${client}
        Log  ****DETAILED Validation FOR MAC : ${client} ****
        Log  Validating Device card of ${client}
        Validating Device Card   ${client}
        Log  Validating Device information ${client}
        Validating Device information   ${client}
        Log  Validating Connectivity information of ${client}
        Validating Device Connectivity information  ${client}
        Log  Validating Health information of ${client}
        Validating Health information   ${client}
        Log  Validating WiFi capabilities of ${client}
        Validating Device WiFi capabilities  ${client}
        Log  Validating Roaming History of ${client}
        Validating Roaming information
        Log  Validating Event History of ${client}
        Validating network history
        Log  ****COMPLETED Validation FOR MAC : ${client} ****
    END

Get Total Connected Clients
    [Documentation]    This keyword will get total clients connected in network based on PY file input data
    ${totalClientConnected}    Set Variable    0
    ${totalClientConnected}    Evaluate    ${totalClientConnected}+${Root_Clients}
    FOR    ${extender}    IN    @{meshNodes}
         ${totalClientConnected}    Evaluate    ${totalClientConnected}+${${extender}_Clients}
    END
    Log   ${totalClientConnected}

Get Total Connected Clients MAC List
    [Documentation]    This keyword will get the List of total MAC and Dictionary with mandatory MAC details info mentioned in PY FIle
    ${totalClientMAC}    Create List
    ${totalClientMACDict}=    Create Dictionary
    FOR  ${i}    IN RANGE    ${Root_Clients}
        ${j}=    Evaluate     ${i} + 1
        Append To List        ${totalClientMAC}        ${Root_Client${j}}[MACAddress]
        ${key}=    Set Variable    ${Root_Client${j}}[MACAddress]
        &{values}=     Create Dictionary
        Set To Dictionary    ${values}    ip=${Root_Client${j}}[ipAddres]
        Set To Dictionary    ${values}    Type=${Root_Client${j}}[connectionType]
        Set To Dictionary    ${values}    connectedTo=${Root_Client${j}}[connectedTo]
        Set To Dictionary    ${values}    connectionType=${Root_Client${j}}[connectionType]
        IF       '${Root_Client${j}}[connectionType]'=='ethernet'
             Set To Dictionary    ${values}    port=${Root_Client${j}}[portNumber]
        ELSE
             Set To Dictionary    ${values}    ssid=${Root_Client${j}}[ssid]
        END
        Set To Dictionary    ${totalClientMACDict}    ${key}=${values}
    END
    FOR    ${extender}    IN     @{meshNodes}
        FOR   ${k}    IN RANGE    ${${extender}_Clients}
           ${l}=    Evaluate     ${k} + 1
           Append To List        ${totalClientMAC}        ${${extender}_Client${l}}[MACAddress]
           ${key}=    Set Variable    ${${extender}_Client${l}}[MACAddress]
           &{values}=     Create Dictionary
           Set To Dictionary    ${values}   ip=${${extender}_Client${l}}[ipAddres]
           Set To Dictionary    ${values}   Type=${${extender}_Client${l}}[connectionType]
           Set To Dictionary    ${values}   connectedTo=${${extender}_Client${l}}[connectedTo]
           Set To Dictionary    ${values}   connectionType=${${extender}_Client${l}}[connectionType]
           IF       '${${extender}_Client${l}}[connectionType]'=='ethernet'
                Set To Dictionary    ${values}   port=${${extender}_Client${l}}[portNumber]
           ELSE
                Set To Dictionary    ${values}    ssid=${${extender}_Client${l}}[ssid]
           END
           Set To Dictionary    ${totalClientMACDict}    ${key}=${values}
        END
    END
    Set test variable    ${totalClientMAC}
    Set test variable    ${totalClientMACDict}
    Log   Total MAC List: ${totalClientMAC}\nMAC dictionary Values : ${totalClientMACDict}

DeviceMemDataFromCloud
    [Documentation]    This keyword will get the online, offline and total connected devices count from members API
    Log     Get the connected devices count in cloud mode
    ${response_value}  Run Keyword   getDeviceCount   ${Root}[mac1]
    &{Device_Connected}    Create Dictionary
    ${DeviceCount}    Get Length    ${response_value}
    FOR    ${i}    IN RANGE    0    ${DeviceCount}
        ${b}    Set Variable    ${response_value}[${i}]
        ${ExcludeExtender}    Run keyword and return status    Get from dictionary    ${b}    extender_id
        Continue For Loop If    ${ExcludeExtender}
        ${key}    Get from dictionary    ${b}    id
        ${value}    Get from dictionary    ${b}    connected
        Set To Dictionary    ${Device_Connected}    ${key}    ${value}
    END
    ${TotalDeviceCount}    Get Dictionary Values    ${Device_Connected}
    ${DeviceCount}    Get length    ${TotalDeviceCount}
    ${OnlineCount}    Create list
    ${OfflineCount}    Create list
    FOR    ${i}    IN RANGE    0    ${DeviceCount}
        Run keyword if    '${TotalDeviceCount}[${i}]' == 'True'    Append To List    ${OnlineCount}    True
        ...    ELSE    Run keyword if    '${TotalDeviceCount}[${i}]' == 'False'    Append to List    ${OfflineCount}    False
    END
    ${OnlineCount}    Get length    ${OnlineCount}
    ${OfflineCount}    Get length    ${OfflineCount}
    Set Test Variable    ${OnlineCount}
    Set Test Variable    ${OfflineCount}
    ${TotalDeviceCountinNetwork}    Evaluate    ${OnlineCount} + ${OfflineCount}
    Set test variable    ${TotalDeviceCountinNetwork}
    Log to console    connected devices count in cloud mode is **** ${TotalDeviceCountinNetwork}

Device Info From ConnectedDevicesCard
    [Documentation]    This keyword will fetch the data from the connected devices card from devices page
    Log To Console    \n Fetch Device info from Connected Devices Card \n
    Sleep    2s
    ${devicedetailsA}=      Run Keyword And Return     QWeb.Execute Javascript      ${deviceList}
    Log To Console   Device info from Connected Devices Card **** ${devicedetailsA}

Validating Device information
    [Documentation]    This keyword will fetch the data from the devices info card from devices page
    [Arguments]    ${clientMAC}
    ${DeviceInfoPortal}=    QWeb.Get Text      ${eleDeviceDetailDevInfo}
    Log  ${DeviceInfoPortal}
    Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceInfoPortal}  Device name(?!unknown$|N/A$|error$).+$
    Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceInfoPortal}  Model(?!unknown$|N/A$|error$).+$
    Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceInfoPortal}  MAC address${clientMAC}
    Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceInfoPortal}  Mobility(?!unknown$|N/A$|error$).+$
    Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceInfoPortal}  Type(?!unknown$|N/A$|error$).+$
    Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceInfoPortal}  Manufacturer(?!unknown$|N/A$|error$).+$

Validating Device Connectivity information
    [Documentation]    This keyword will fetch the data from the devices connectivity  card from devices page
    [Arguments]    ${clientMAC}
    ${DeviceDetailConnInfo}=    QWeb.Get Text      ${eleDeviceDetailConnInfo}
    Log  ${DeviceDetailConnInfo}
    Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailConnInfo}  Connected WiFi point${totalClientMACDict['${clientMAC}']['connectedTo']}
    Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailConnInfo}  IP address${totalClientMACDict['${clientMAC}']['ip']}
    Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)IPv6 address 1(?!unknown$|N/A$|error$).*([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}
    Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)IPv6 address 2(?!unknown$|N/A$|error$).+$.*([0-9a-fA-F]{1,4}:){1,7}[0-9a-fA-F]{1,4}
    Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)Multi-link Operation^yes|no
    IF   '${totalClientMACDict['${clientMAC}']['connectionType']}'=='ethernet'
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailConnInfo}  SSIDN/A for Ethernet
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailConnInfo}  WiFi standardN/A for Ethernet
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailConnInfo}  WiFi bandN/A for Ethernet
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailConnInfo}  Signal strengthN/A for Ethernet
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  Port number${totalClientMACDict['${clientMAC}']['port']}
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  Last disconnection causeN/A for Ethernet
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailConnInfo}  Connectivity levelN/A for Ethernet
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailConnInfo}  Up time-
    ELSE
           Run Keyword And Continue On Failure  Should Contain  ${DeviceDetailConnInfo}  SSID${totalClientMACDict['${clientMAC}']['ssid']}
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)WiFi standard(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)WiFi band(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)Signal strength(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)Physical Tx rate.*bps
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)Physical Rx rate.*bps
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)Port number(?!unknown$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)Last disconnection cause(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)Connectivity level(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailConnInfo}  (?i)Up time(?!unknown$|N/A$|error$).+$
    END

Validating Device WiFi capabilities
    [Documentation]    This keyword will fetch the data from the devices wifi card from devices page
    [Arguments]    ${clientMAC}
    ${DeviceDetailWifiCap}=    QWeb.Get Text      ${eleDeviceDetailWifiCap}
    Log  ${DeviceDetailWifiCap}
    Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailWifiCap}  (?i)Multi-link Operation^yes|no
    IF   '${totalClientMACDict['${clientMAC}']['connectionType']}'=='ethernet'
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailWifiCap}  RadiosN/A for Ethernet
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailWifiCap}  WiFi standardN/A for Ethernet
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailWifiCap}  Roaming capableN/A for Ethernet
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailWifiCap}  Other 802.11 standardsN/A for Ethernet
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailWifiCap}  WiFi standard and Bandwidth in useN/A for Ethernet
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailWifiCap}  MIMON/A for Ethernet
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailWifiCap}  Max streams capableN/A for Ethernet
           Run Keyword And Continue On Failure  Should Contain   ${DeviceDetailWifiCap}  MLO capabilitiesNone
    ELSE
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailWifiCap}  (?i)Radios(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailWifiCap}  (?i)WiFi standard(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailWifiCap}  (?i)Roaming capable(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailWifiCap}  (?i)Other 802.11 standards(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailWifiCap}  (?i)WiFi standard and Bandwidth in use(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailWifiCap}  (?i)MIMO(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailWifiCap}  (?i)Max streams capable(?!unknown$|N/A$|error$).+$
           Run Keyword And Continue On Failure  Should Match Regexp  ${DeviceDetailWifiCap}  (?i)MLO capabilities(?!unknown$|N/A$|error$).+$
    END

Validating network history
    [Documentation]    This keyword will fetch the data from the devices networkhistory card from devices page
    FOR    ${i}    IN    @{dropdownlist}
       QWeb.Click Element     ${dropdowndevice}
       Qwebelement.clicktext    ${i}
       VerifyElement    ${networkhistorychecker}
    END

Validating Health information
    [Documentation]    This keyword will fetch the data from the device health info card from devices page
    [Arguments]    ${clientMAC}
    ${DeviceDetailHealth}=    QWeb.Get Text      ${eleDeviceDetailHeathInfo}
    IF   '${totalClientMACDict['${clientMAC}']['connectionType']}'=='ethernet'
        Run Keyword And Continue On Failure    Should Contain    ${DeviceDetailHealth}    N/A for Ethernet
    ELSE
        Run Keyword And Continue On Failure   Should Not Contain  ${DeviceDetailHealth}   unknown
    END

Validating Device Card
    [Documentation]    This keyword will check online string from device icon card
    [Arguments]    ${clientMAC}
    ${DeviceCard}=    QWeb.Get Text      ${eleDeviceDetailDeviceCard}
    Run Keyword And Continue On Failure   Should Contain    ${DeviceCard}   Online


Set Date In Roaming history Calendar
    Qweb.Get Start Time Portal    30    2
    ${PortalDateTime}=    Run Keyword    Qweb.Get End Time Portal    1
    Log    \n Enable calendar editable in EventHistory Page
    Run Keyword And Continue On Failure  QWeb.Execute javascript   ${DeviceDetailCalAttribute}
    Sleep    ${sleepMin}
    log Screenshot
    QWeb.Click Element    ${eleDeviceDetailCalendar}
    Sleep    ${sleepMin}
    log Screenshot
    Log    \n Check for 2 days Events logged.
    ${locator}    Replace String    ${EditDeviceDetailCal}    SELECTOR    ${PortalDateTime}
    Sleep    ${sleepMin}
    Run Keyword    QWeb.Execute javascript    ${locator}
    Sleep    ${sleepMin}
    QWeb.Click Text   Apply
    log Screenshot

Validating Roaming information
    [Documentation]    This keyword will fetch the data from the device roaming info card from devices page
    [Arguments]    ${clientMAC}
    ${DeviceDetailRoaming}=    QWeb.Get Text      ${eleDeviceDetailRoamingInfo}
    IF   '${totalClientMACDict['${clientMAC}']['connectionType']}'=='ethernet'
        Run Keyword And Continue On Failure    Should Contain    ${DeviceDetailRoaming}    N/A for Ethernet
    ELSE
        Set Date In Roaming history Calendar
        QWeb.Execute Javascript   ${RoamingHistory}    $inputDict
        Log   ${inputDict}
        FOR   ${value}   IN   @{inputDict}
            ${event}=    Get From Dictionary    ${value}    Event
            IF  '${event}' == 'Device Connected'
               Run Keyword And Continue On Failure   Validate Device Connected Dictionary   ${value}
            END
            IF  '${event}' == 'Device Disconnected'
               Run Keyword And Continue On Failure   Validate Device Disconnected Dictionary   ${value}
             END
        END
    END


Validate Device Connected Dictionary
    [Arguments]    ${device_info}
    Dictionary Should Contain Key    ${device_info}    Date
    Dictionary Should Contain Key    ${device_info}    Band
    ${date}=    Get From Dictionary    ${device_info}    Date
    ${band}=    Get From Dictionary    ${device_info}    Band
    Run Keyword And Continue On Failure   Should Match Regexp    ${date}    ^\\d+$
    Run Keyword And Continue On Failure   Should Match Regexp    ${band}    ^\\d(\.\\d)? GHz$    ignore_case=True

Validate Device Disconnected Dictionary
    [Arguments]    ${device_info}
    Dictionary Should Contain Key    ${device_info}    Date
    Dictionary Should Contain Key    ${device_info}    Reason
    ${date}=    Get From Dictionary    ${device_info}    Date
    ${Reason}=    Get From Dictionary    ${device_info}    Reason
    Run Keyword And Continue On Failure  Should Match Regexp    ${date}    ^\\d+$
    Run Keyword And Continue On Failure  Should Match Regexp    ${Reason}    .*$   ignore_case=True
