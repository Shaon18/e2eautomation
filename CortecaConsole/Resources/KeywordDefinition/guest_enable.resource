*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Variables       ../../InputFiles/EnvironmentInput.py
Library          ../../Resources/commonPythonKeywords/suppress.py
Resource                   ../../Resources/KeywordDefinition/ApiRequest.resource
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Variables        ../../InputFiles/Apirequest.py
Variables        ../../Locators/CortecaConsoleLocators.py
Variables        ../TestDatas.py
Resource    ../../Resources/KeywordDefinition/WebguiAccessQWEB.resource


*** Keywords ***

Guest_Enable_Disable_API
    [Arguments]    ${val}=0
    ${RetResponse}       Auth_token
#    Run Keyword And Continue on failure    Dictionary Should Not Contain Key    ${RetResponse}    message
#    Comment    Run Keyword And Continue on failure    API_Response_Check    ${RetResponse}    ${GetAPIToken_NewUser_Credentials1}
    Run Keyword And Continue on failure    Set To dictionary    ${NewUser_Credentials1}    access_token    ${RetResponse}
#    Comment    Log Dictionary    ${dict}
    ${uri}=    Replace String    ${API_CGI_URL}    INDEX    ${NewUser_Credentials1}[mac]    count=1
    &{headers}=    Create Dictionary    Authorization=${NewUser_Credentials1}[access_token]    X-Service-Type=${NewUser_Credentials1}[X-ServiceType]    Content-Type=${NewUser_Credentials1}[Content-Type]
    ${data}=    Set Variable    { \ "payload" : { \ "resource": "wlan_config_app.cgi", \ "id": "wlan_config_status_web_app", \ "method": "POST", \ "headers": { "Content-Type": "application/x-www-form-urlencoded" }, \ "data": "act=ConfigWhwGuest&iso=&enable=${val}&accessType=&wl_ssid=&wpaKey=" \ } }
    Comment    API_CGI_URL
    ${response}=    API_RawPostRequest     LoginSession   ${uri}    data=${data}    headers=&{headers}
    Run Keyword And Continue on Failure    Should be equal as strings    ${response.status_code}    ${NewUser_Credentials1}[response_code]
    ${response}=    Set Variable    ${response.json()}
    Log Dictionary    ${response}




API_RawPostRequest
    [Arguments]    ${alias}    ${uri}    ${data}=None    ${json}=None    ${params}=None    ${headers}=None    ${files}=None    ${allow_redirects}=None    ${timeout}=None
    ${response}=    POST On Session        ${alias}    ${uri}    headers=${headers}    data=${data}
#       json=${json}    params=${params}    allow_redirects=${allow_redirects}    timeout=${timeout}    files=${files}
     [Return]        ${response}



change SSID
    [Arguments]    ${name}=${Root}[ssid_defa_name]     ${pass}=${Root}[ssid_defa_password]    ${mod_name}=${name}    ${mod_pass}=${modified_pass}
#    Qwebelement.clicktext        Modify WiFi network
#    Log    Click the dropdown for select the wifi network
#    ClickElement     ${selectwifinetwork}
#    Log    Clicks the mentioned SSID name
#    Qwebelement.clicktext        ${name}
#    Sleep    3s
#    Log    Verify the mentioned SSID name
#    VerifyText           ${name}
#    Log    Get the value of the placeholder for ssid name
#    ${wifi_name}       GetAttribute             ${enterwifinetwork}    value
#    Log    ${wifi_name}
#    Log    We will change the SSID name by adding _Changed to it For e.g NOKIA-6DE1 will become NOKIA-6DE1_Changed
#    ${changed_name}        Set Variable        ${name}
#    ClickElement        ${enterwifinetwork}
#    IF    '${wifi_name}' == '${name}'
#            ${changed_name}        Set Variable        ${name}_Changed
#            Log    Type the changed name in the placeholder for ssid name
#           Qwebelement.typetext      ${changed_name}      ${enterwifinetwork}
#    ELSE
#            Log    Type the changed name in the placeholder for ssid name
#            Qwebelement.typetext    ${name}        ${enterwifinetwork}
#    END
#    Log    Get the value for SSID password from the placeholder
#    ${wifi_pass}       GetAttribute          ${enternetworkpassword}        value
#    Log    If the value of the password is empty we return false
#    IF       '${wifi_pass}' == ''
#       Run Keyword And Continue On Failure     Fail    placeholder empty
#    END
#    ClickElement    ${enternetworkpassword}
#    IF       '${wifi_pass}' == '${pass}'
#        Log    Type the changed password in the placeholder for ssid password
#        Qwebelement.typetext    ${Root}[default_value_for_modified_password]       ${enternetworkpassword}
#    ELSE
#        Log    Type the changed password in the placeholder for ssid password
#        Qwebelement.typetext    ${pass}        ${enternetworkpassword}
#    END
#    Qwebelement.clicktext        Modify Network
#    Run Keyword And Continue On Failure    VerifyText           ${ssid_modified}        100s
#    ClickElement         ${closethecard}
##    VerifyText    Success          30s
#    Sleep    120s
#    Move To Event History
#    Run Keyword And Continue On Failure    VerifyText    The modify WiFi network request for ${changed_name} has succeeded     30s
    Change Ssid To Given Values    ${name}    ${pass}    ${mod_pass}    ${mod_name}
    Qw.closebrowser
    Move To Home Dashboard
    Open SA Configuration
    Changeback and check teardown    ${mod_name}    ${pass}    ${name}


changeback and check teardown
    [Arguments]    ${name}    ${pass}    ${modname}
    Qwebelement.clicktext        Modify WiFi network
    Log    Click the dropdown for select the wifi network
    ClickElement     ${selectwifinetwork}
    Log    Clicks the mentioned SSID name
    Qwebelement.clicktext        ${name}
    Log    Verify the mentioned SSID name
    VerifyText           ${name}
    Log   enter the mentioned ssid name and password in the placeholder
    ${wifi_name}       GetAttribute             ${enterwifinetwork}    value
    Log    ${wifi_name}
    Qwebelement.typetext      ${modname}      ${enterwifinetwork}
    Qwebelement.typetext    ${pass}        ${enternetworkpassword}
    LogScreenshot
    Qwebelement.clicktext        Modify Network
    LogScreenshot
    Run Keyword And Continue On Failure    VerifyText           ${ssid_modified}        100s
    Sleep  30s
    Log    Close the toaster
    ClickElement         ${closethecard}
    Open SA Configuration
    Qwebelement.clicktext        Modify WiFi network
    Log    Click the dropdown for select the wifi network
    ClickElement     ${selectwifinetwork}
    Qwebelement.clicktext        ${modname}
    Log    Clicks the mentioned SSID name
    Log    Get the value of the placeholder for ssid name
    ${wifi_name}       GetAttribute             ${enterwifinetwork}    value
    Should Be Equal As Strings    ${wifi_name}    ${modname}

    
    


change ssid to given values
    [Arguments]    ${name}    ${pass}    ${mod_pass}=${pass}    ${mod_name}=${name}    
    Qwebelement.clicktext        Modify WiFi network
    Log    Click the dropdown for select the wifi network
    ClickElement     ${selectwifinetwork}
    Log    Clicks the mentioned SSID name
    Qwebelement.clicktext        ${name}
    Sleep    3s
    Log    Verify the mentioned SSID name
    VerifyText           ${name}
    Log    Get the value of the placeholder for ssid name
    ${wifi_name}       GetAttribute             ${enterwifinetwork}    value
    Log    ${wifi_name}
    ClickElement        ${enterwifinetwork}
    Log    We will change the SSID name
    Qwebelement.typetext      ${mod_name}      ${enterwifinetwork}
    Log    Get the value for SSID password from the placeholder
    ${wifi_pass}       GetAttribute          ${enternetworkpassword}        value
    Log    If the value of the password is empty we return false
    IF       '${wifi_pass}' == ''
       Run Keyword And Continue On Failure     Fail    placeholder empty
    END
    ClickElement    ${enternetworkpassword}
    Log    Type the changed password in the placeholder for ssid password
    Qwebelement.typetext    ${mod_pass}      ${enternetworkpassword}
    Qwebelement.clicktext        Modify Network
    Run Keyword And Continue On Failure    VerifyText           ${ssid_modified}        100s
    ClickElement         ${closethecard}
    Sleep    30s
    Move To Event History
    IF  '${name}'=='${mod_name}'
        Run Keyword And Continue On Failure    VerifyText    The WiFi password has successfully changed    30s
    ELSE
        Run Keyword And Continue On Failure    VerifyText    The modify WiFi network request for ${mod_name} has succeeded     30s
    END

check ssid pass
    [Arguments]    ${name}    ${ssidnum}=SSID1
    IF    '${Root_Web_GUI_Type}'=='Pureview'
        Open Pureview WebGui
        Qwebelement.clicktext    Maintenance
        Sleep    ${sleepMin}
        Qwebelement.clicktext    Overview
        Sleep    ${sleepMin}
        FOR    ${i}    IN RANGE    10
            ClickElement    xpath=//pv-vector[@class='size-small small']//*[name()='svg']
            ${res}    Run Keyword And Return Status    VerifyText    ${name}    30s
            LogScreenshot
            IF    '${res}'=='True'
                BREAK
            END
        END
        Qwebelement.clicktext    ${name}
        ${wifi_pass}=       GetAttribute        ${ssidpass}                 value
        Sleep    ${sleepMin}
    ELSE
        Open Old WebGui    
        ClickText    Network    Security
        Qwebelement.clicktext    Wireless (2.4GHz)
        ClickElement    ${ssidselect}
        IF    '${ssidnum}'!='SSID1'
            ClickText    ${ssidnum}    SSID1
        END
        ${wifi_pass}=       GetAttribute        ${wpakey}                 value
        Sleep    ${sleepMin}
    END        
    RETURN    ${wifi_pass}
    