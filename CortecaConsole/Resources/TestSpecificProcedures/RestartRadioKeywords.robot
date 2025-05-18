*** Settings ***
Library    QWeb
#Library    Selenium
Library    String
Library    Telnet
Library    Process
Library    Collections
Library    JSONLibrary
#Resource     ../KeywordDefinition/CommonKeywords.robot
Variables    ../../InputFiles/EnvironmentInput.py
Variables        ../../InputFiles/Apirequest.py
Variables    ../../Locators/CortecaConsoleLocators.py
Variables    ../TestDatas.py
Variables    ../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py
Resource    ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Resource    ../../Resources/TestSpecificProcedures/wifi_point.resource
Resource        ../../Resources/KeywordDefinition/Sshkeywords.resource

*** Keywords ***

Trigger Restart Radio for Root and Extenders
    ${RadioDetails}    ${Count}=    Get Radio details for Restart
    FOR    ${i}    IN RANGE    0    ${Count}
        #${Getidentifier}=    Get_Radio_Identifier_via_API    ${RadioDetails}[${i}]
        Run Keyword And Continue On Failure    Check Restart Radio feature    ${Root}[udefi_frn_name]    ${RadioDetails}[${i}]
        Sleep    ${sleepMax}
    END
    FOR    ${extender}    IN    @{meshNodes}
        ${extFriendlyName}    Set Variable    ${${extender}}[udefi_frn_name]
        FOR    ${i}    IN RANGE    0    ${Count}
            Run Keyword And Continue On Failure    Check Restart Radio feature    ${extFriendlyName}    ${RadioDetails}[${i}]
            Sleep    ${sleepMax}
        END
     END
     
Get Radio details for Restart
    ${WifiBandsList}=    Get the wifi band details Qweb   ${Root_bconType}
    Log    ${WifiBandsList}
    ${Count}=    Get Length    ${WifiBandsList}
    ${Count}=    Convert To String    ${Count}
    FOR    ${i}    IN RANGE    0    ${Count}
        Run Keyword If    '${WifiBandsList}[${i}]'=='24_GHz'    Set List Value    ${WifiBandsList}    ${i}    2.4 GHz
        ...    ELSE IF    '${WifiBandsList}[${i}]'=='5_GHz'    Set List Value    ${WifiBandsList}    ${i}    5 GHz
        ...    ELSE IF    '${WifiBandsList}[${i}]'=='5_GHz_Low'    Set List Value    ${WifiBandsList}    ${i}    5 GHz Low
        ...    ELSE IF    '${WifiBandsList}[${i}]'=='5_GHz_High'    Set List Value    ${WifiBandsList}    ${i}    5 GHz High
        ...    ELSE IF    '${WifiBandsList}[${i}]'=='6_GHz'    Set List Value    ${WifiBandsList}    ${i}    6 GHz
        ...    ELSE    Set List Value    ${WifiBandsList}    ${None}
    END
    Log    ${WifiBandsList}
    Return From Keyword    ${WifiBandsList}    ${Count}


Check Restart Radio feature
    [Arguments]    ${deviceFriendlyName}    ${Radio}
    Trigger Radio Restart    ${deviceFriendlyName}    ${Radio}

Trigger Radio Restart
    [Arguments]    ${deviceFriendlyName}    ${Radio}
    ${locator1}    Replace String    ${eleSupportActionsRestartRadioDevice}    INDEX    ${deviceFriendlyName}
    ${locator2}    Replace String    ${eleSupportActionsRestartRadios}    INDEX    ${Radio}
    Qwebelement.clicktext    Network device
    Sleep    ${sleepMin}
    LogScreenshot
    Qwebelement.clicktext    Restart Radio
    Sleep    ${sleepMin}
    LogScreenshot
    Qwebelement.clicktext   Select network device
    Sleep    ${sleepMin}
    LogScreenshot
    Qwebelement.clicktext   ${deviceFriendlyName}
    Sleep    ${sleepMin}
    LogScreenshot
    Qwebelement.clicktext   ${Radio}
    Sleep    ${sleepMin}
    LogScreenshot
    Run Keyword    QWeb.Click Element    ${eleSupportActionsRestartTrigger}
    Sleep    ${sleepMin}
    LogScreenshot
    VerifyText                    Success        20s
    VerifyText                    The WiFi radio restart is initiated successfully, check the status in Event History
    LogScreenshot
    #Check_Radio_Info_via_API    ${identifier}
    Sleep    ${sleepMax}
    Move To Event History
    LogScreenshot
    Run Keyword And Continue On Failure     VerifyText                     Request to restart ${Radio} radio of ${deviceFriendlyName} initiated
    LogScreenshot
    FOR    ${i}    IN RANGE    1      4
        Run Keyword And Continue On Failure      VerifyText                Restart on ${Radio} radio of ${deviceFriendlyName} has been successful
        LogScreenshot
    END
    Qwebelement.clicktext    Overview
    Sleep    ${sleepMax}
    Run Keyword And Continue On Failure    Check Core Logs
    LogScreenshot

check core logs
    ${result}   SSHExecute    ${core}
    Run Keyword And Continue On Failure    Should Contain    ${result}    No such file or directory

Get the wifi band details Qweb
    [Arguments]    ${bconType}
    Log    Get the wifi band details for ${bconType}
    ${DeviceBand}=    Check wifi band Qweb   ${bconType}
    @{WifiBands}=    Create List
    Set Test Variable    @{WifiBands}
    @{WifiBands}    Set Variable    ${WifiBandList}[${DeviceBand}]
    Log    ${WifiBands}
    Return From Keyword    ${WifiBands}

Check wifi band Qweb
    [Arguments]    ${bconType}
    Log    Get the wifi band details for ${bconType}
    ${DeviceBand}=    Run Keyword If    '${bconType}' in ${DeviceBandList}[Dual Band]    Set Variable    Dual Band
    ...    ELSE IF    '${bconType}' in ${DeviceBandList}[Tri Band]    Set Variable    Tri Band
    ...    ELSE IF    '${bconType}' in ${DeviceBandList}[Tri Band 6G]    Set Variable    Tri Band 6G
    ...    ELSE       '${bconType}' in ${DeviceBandList}[Quad Band]    Set Variable    Quad Band
    Log    ${DeviceBand}
    Return From Keyword    ${DeviceBand}
    
Get_Radio_Identifier_via_API
    [Arguments]    ${Radio}
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=        Create Dictionary    Authorization=${auth_token}
    ${uri}=    Replace String    ${API_URL_Radio}    INDEX1    ${NewUser_Credentials1}[mac]
    Log    ${uri}
    Sleep    100s
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    ${RetResponse}=   Set To Dictionary       ${RetResponse.json()}
    Log    ${RetResponse}
    ${identifier}=    Run Keyword If    "${RetResponse}[0][bands][0]".strip()=="${Radio}".strip()    Set Variable    ${RetResponse}[0][id]    
    ${identifier}=    Run Keyword If    "${RetResponse}[1][bands][0]".strip()=="${Radio}".strip()    Set Variable    ${RetResponse}[1][id]
    Return From Keyword    ${identifier}

Check_Radio_Info_via_API
    [Arguments]    ${identifier}
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=        Create Dictionary    Authorization=${auth_token}
    ${uri}=    Replace String    ${API_URL_RadioWiFi}    INDEX2    ${identifier}
    Log    ${uri}
    Sleep    100s
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    ${RetResponse}=   Set To Dictionary       ${RetResponse.json()}
    Log    ${RetResponse}[enabled]
    Should Not Be True    ${RetResponse}[enabled]

