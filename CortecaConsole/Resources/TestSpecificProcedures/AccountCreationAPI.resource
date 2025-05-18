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

*** Keywords ***
NWCC_AccountCreation_API
    Log    Event :: Account Creation
    Log To Console    Event :: Account Creation
    Log    Step1: Create Account
    ${access_token}=    Run Keyword    Auth_token
    ${data}=    Set Variable
    ...    {"name":"${NewUser_Credentials1}[name]","email":"${NewUser_Credentials1}[email]","password":"${NewUser_Credentials1}[password]","mac":"${NewUser_Credentials1}[mac]"}
    ${cusID}=    CloudAPI_CreateAccount    ${API_URL_CreateAccount}    ${data}    ${NewUser_Credentials1}    200
    Log    ${cusID}[user_uuid]
    Set Global Variable    ${cusID}
    Sleep    20s
    Log    Step2: Verify Account
    Verify_Email_New    ${Account['Email']}
    Sleep    5s
    Log    Step3: Associate Device
    ${dev_cap}=    GET    http://www.webgui.nokiawifi.com/get_devmap_cap_status_app.cgi
    ${dev_cap}=    Set Variable    ${dev_cap.json()}[devapp_cap_info]
    ${device_info}=    Get From List    ${dev_cap}    0
    ${cldClaimID}=    Get From Dictionary    ${device_info}    cldClaimID
    Log    ${cldClaimID}
    Sleep    5s
    ${data}=    Set Variable    {"claim_type": "pin","mac": "${NewUser_Credentials1}[mac]","pin": "${cldClaimID}"}
    ${response}=    CloudAPI_CreateAccount
    ...    ${API_URL_Associate_Device}
    ...    ${data}
    ...    ${NewUser_Credentials1}
    ...    200
    ...    ${cusID}[user_uuid]
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}
    ${uri}=    Replace String    ${API_URL_DeviceStatus1}    INDEX    ${Root}[mac1]
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    Log    ${RetResponse.json()}

CloudAPI_CreateAccount
    [Arguments]    ${uri}    ${data}    ${dict}=${NewUser_Credentials1}    ${Success_Code}=200    ${UUID}=none
    IF    '${uri}'=='${API_URL_Associate_Device}'
        ${access_token}=    Run Keyword    Auth_token    ${dict}
    ELSE
        ${access_token}=    Run Keyword    Auth_token
    END
    IF    '${uri}'=='${API_URL_Associate_Device}'
        ${uri}=    Replace String    ${API_URL_Associate_Device}    INDEX    ${UUID}    1
    ELSE
        ${uri}=    Set Variable    ${uri}
    END
    Log Dictionary    ${dict}
    &{headers}=    Create Dictionary    Authorization=${access_token}    X-Service-Type=KC
    Log    ${data}
    ${data}=    Convert String To Json    ${data}
    log    ${data}
    ${response}=    POST On Session    ${session_id}    ${uri}    json=${data}    headers=${headers}    timeout=30
    Run Keyword And Continue on Failure    Should be equal as strings    ${response.status_code}    ${Success_Code}
    ${response}=    Set Variable    ${response.json()}
    RETURN    ${response}