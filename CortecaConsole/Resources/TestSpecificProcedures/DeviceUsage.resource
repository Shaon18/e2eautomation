*** Settings ***
Library         String
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         ../../InputFiles/imagecomparision.py
Resource        ../../Resources/TestSpecificProcedures/LoginPageProcedures.robot
Resource        ../../Resources/KeywordDefinition/ApiRequest.resource
Variables       ../../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py




*** Keywords ***

Move To Usage Tab
    Login To Corteca Console
    Open Corteca Console Home Page
    Sleep    30s
    Capture Page Screenshot
    Click Element    ${usageOverview}


Move To Device Usage
    Move To Usage Tab
    Click Element    ${DeviceUsage}
    Sleep  60s

Usage API Validation
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=        Create Dictionary    Authorization=${auth_token}
    ${uri}=     REPLACE
    Log    ${uri}
    Sleep    100s
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    ${RetResponse}=   Set To Dictionary       ${RetResponse.json()}
    Log To Console      ${RetResponse}
    ${rx_rate}    Set Variable    ${RetResponse}[data][0][rx_bytes]
    ${tx_rate}    Set Variable    ${RetResponse}[data][0][tx_bytes]
    Should Not Be Equal    ${tx_rate}   0
    Should Not Be Equal    ${rx_rate}   0
    ${meshnodeMacs}    Create List
    FOR    ${meshnode}    IN    @{meshNodes}
        Append To List    ${meshnodeMacs}    ${${meshnode}}[mac]
    END
    Log To Console    Check extender Mac not present
    FOR    ${responseData}    IN    @{RetResponse}[data]
        ${mac}    Set Variable    ${responseData}[mac]
        List Should Not Contain Value    ${meshnodeMacs}        ${mac}    msg=${mac} is extender and not expected in this list
    END

check list of clients present or not
    Run Keyword If    '${boardModel}' == 'MTK'   Add List Acc To Network Devices For Eth Clients
    Log    ${clientsthatareshown}
    Add List Acc To Network Devices For Wifi Clients
    Log    ${clientsthatareshown}
    RETURN    ${clientsthatareshown}
    
    
add list acc to network devices for eth clients
    Add List For Eth Clients    Root
    FOR    ${meshNode}     IN     @{meshNodes}
        Add List For Eth Clients    ${meshNode}
    END


add list acc to network devices for wifi clients
    Add List For Wifi Clients        Root
    FOR    ${meshNode}    IN     @{meshNodes}
        Add List For Wifi Clients        ${meshNode}
    END

add list for wifi clients
    [Arguments]    ${dev}
    FOR   ${clientCount}    IN RANGE    ${${dev}_Clients}
        ${wifiClient}=    Evaluate     ${clientCount} + 1
        IF    '${${dev}_Client${wifiClient}}[connectionType]' == 'wifi'
            Append To List       ${clientsthatareshown}        ${${dev}_Client${wifiClient}}[hostName]
        END
    END
    
add list for eth clients
    [Arguments]    ${dev}
    FOR   ${clientCount}    IN RANGE    ${${dev}_Clients}
        ${ethClient}=    Evaluate     ${clientCount} + 1
        IF    '${${dev}_Client${ethClient}}[connectionType]' == 'ethernet'
            Append To List        ${clientsthatareshown}        ${${dev}_Client${ethClient}}[hostName]
        END
    END

checking graph after one minute
    Capture Element Screenshot     ${vsspeedgraph}         ${topologyscpath}/SpeedGraph1.png
    Sleep    30s
    Capture Element Screenshot     ${vsspeedgraph}         ${topologyscpath}/SpeedGraph2.png
    ${ssim}    Calculate Image Similarity       ${topologyscpath}/SpeedGraph1.png        ${topologyscpath}/SpeedGraph2.png 
    Run Keyword And Continue On Failure    Should Not Be Equal As Numbers     ${ssim}    1


checking list of clients in dropdown menu
    Log    Getting the clients details
    ${clientList}    Check List Of Clients Present Or Not
    FOR    ${client}    IN    @{clientList}
      Log    Check device usage for ${client}
      Click Element    ${dropdowndeviceusage}
      ${ele}    Replace String    ${connectedclientlist}        INDEX    ${client}
      Sleep    ${sleepAvg}
      ${status}    Click Element    ${ele}
      Continue For Loop If    '${status}'=='False'
      Sleep    ${sleepAvg}
      Click Element    ${dropdowndeviceusage}
#      Sleep  5s
#      Click Element    ${dropdowndeviceusage}
#      Sleep    5s
#      Click Element    ${ele}
#      Sleep    5s
#      Click Element    ${dropdowndeviceusage}
      Capture Page Screenshot    ${saveScreenShotPath}/dropdownmenu_${client}_unselect.png
    END
    Run Keyword And Continue On Failure    Page Should Contain    Please select atleast one device.
    FOR    ${client}    IN    @{clientList}
      Log    Check device usage for ${client}
      Click Element    ${dropdowndeviceusage}
      ${ele}    Replace String    ${connectedclientlist}        INDEX    ${client}
      Sleep    ${sleepAvg}
      ${status}    Click Element    ${ele}
      Continue For Loop If    '${status}'=='False'
      Sleep    ${sleepAvg}
      Click Element    ${dropdowndeviceusage}
      Sleep  ${sleepAvg}
      Run Keyword And Continue On Failure    Page Should Not Contain Element       ${nodataavailable}
      Capture Page Screenshot    ${saveScreenShotPath}/dropdownmenu_${client}_select.png
    END


