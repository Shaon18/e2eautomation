*** Settings ***
Library         ../../InputFiles/suppress.py
Library         RequestsLibrary
Variables       ../../InputFiles/sampleSetupFileFormat.py
Variables       ../../InputFiles/EnvironmentInput.py
Variables       ../../InputFiles/Apirequest.py
Library         ../../InputFiles/MappAPIValidation.py
Library         Collections
Library         String
Library         JSONLibrary
Resource        ../KeywordDefinition/ApiRequest.resource
Resource        ../KeywordDefinition/Sshkeywords.resource
Resource        ../keywordDefinition/CommonKeywords.robot
Resource        ConfigureBoengSSH.resource

*** Keywords ***
Extender_Onboarding_CGI
    Log    Adding Extenders
    Log To Console    Adding Extenders
    ${a}=    Set Variable    1
    ${i}=    Set Variable    0
    ${Ext_ip}    Create List
    FOR    ${extender}    IN    @{meshNodes}
        MAPP_APICreateSession
        ${Success_Code}=    Set Variable    200
        ${schema}=    Set Variable    yes
        ${response}=    MAPP_APILogin
        Should be equal as strings    ${response.status_code}    ${Success_Code}
        ${data}=    Set Variable    act=AddBeacon&BeaconSrn=${Ext${a}}[serial_num]
        ${response}=    Post Request    label    ${API_URL_ZeroTouchOnboard}    data=${data}
        Run Keyword And Continue on Failure    Should be equal as strings    ${response.status_code}    ${Success_Code}
        API_Response_Check    ${response.json()}    ${RESTAPI_FriendlyName_Test16_Scenario1_body_response}    ${schema}
        Log    Sleep time after Extender added
        Log To Console    Sleep time after Extender added
        Comment    Sleep Count    360
        ${Ext_ip}    MeshAPI_Validation    ${Ext${a}}[serial_num]    ${Ext_ip}
        Validate_Process    ${Ext_ip}[${i}]    ${Ext${a}}[telnet_vtysh]
        Log	Core Validation
        ONT_CheckCore
        ${i}=    Evaluate    ${i} + 1
        ${a}=    Evaluate    ${a} + 1
    END

MAPP_APICreateSession
    Run keyword and Ignore Error    Delete All Sessions
    Sleep    3s
    ${URL}=    Set Variable    http://${Root}[ip]
    &{headers_local}=    Create Dictionary
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Accept=*/*
    ...    User-Agent=Curl/7.31
    ${session}=    RequestsLibrary.Create Session    label    ${URL}    headers=&{headers_local}

MAPP_APILogin
    ${data}=    Set Variable    name=${Root}[app_username]&pswd=${Root}[app_password]
    ${response}=    Post Request    label    ${API_URL_login}    data=${data}
    RETURN    ${response}

API_Response_Check
    [Arguments]    ${response_value}    ${static_response}    ${schema}=yes    ${api}=yes    ${keys}=yes
    IF    '${api}'=='yes'
        ${resp}=    api_response_validation    ${response_value}    ${static_response}
    ELSE
        ${resp}=    Set Variable    ${None}
    END
    Run Keyword and Continue on failure
    ...    Run Keyword if    '${resp}' == '0' and '${api}'=='yes'    Fail    Response is not equal
    IF    '${keys}'=='yes'
        ${resp}=    api_key_validation    ${response_value}    ${static_response}
    ELSE
        ${resp}=    Set Variable    ${None}
    END
    Run Keyword and Continue on failure
    ...    Run Keyword if    '${resp}' == '0' and '${keys}'=='yes'    Fail    Response is not equal
    ${undefined_keys}=    api_response_get_undefined_values    ${static_response}
    Log    Undefined Keys: ${undefined_keys}
    Log    ${schema}
    IF    '${schema}'=='yes'
        ${resp}=    api_schema_validation    ${response_value}    ${static_response}
    ELSE
        ${resp}=    Set Variable    ${None}
    END
    Run Keyword and Continue on failure
    ...    Run Keyword if
    ...    '${resp}' == '0'
    ...    and '${schema}'=='yes'
    ...    Fail
    ...    Response is not equal

MeshAPI_Validation
    [Arguments]    ${serialnumber}    ${Ext_ip}=[]
    [Return]    ${Ext_ip}
    Auth_token
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}
    ${uri}=    Replace String    ${API_URL_MeshBackHaul}    INDEX    ${Root}[mac1]
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    ${MeshResponse}    Set Variable    ${RetResponse.json()}[aps]
    FOR    ${i}    IN    @{MeshResponse}
        Run Keyword And Continue On Failure    Run Keyword If    '${i}[id]'=='${serialnumber}'    Should Be Equal    ${i}[status]    online
        Run Keyword And Continue On Failure    Run Keyword If    '${i}[id]'=='${serialnumber}'    Append To List    ${Ext_ip}    ${i}[ipaddress]
        Run Keyword If    '${i}[id]'=='${serialnumber}'    Exit For Loop
    END
    Set Global Variable    ${Ext_ip}

GetExtenderIP
    [Return]    ${Ext_ip}
    ${Ext_ip}    Create List
    ${a}    Set Variable    1
    FOR    ${extender}    IN    @{meshNodes}
        ${Ext_ip}    MeshAPI_Validation    ${Ext${a}}[serial_num]    ${Ext_ip}
        ${a}=    Evaluate    ${a} + 1
    END