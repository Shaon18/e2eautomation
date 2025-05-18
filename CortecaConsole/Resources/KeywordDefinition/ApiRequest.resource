*** Settings ***
Library         RequestsLibrary
Variables       ../../InputFiles/EnvironmentInput.py
Library          ../../Resources/commonPythonKeywords/suppress.py
Variables        ../../InputFiles/Apirequest.py
Library         ../../InputFiles/MappAPIValidation.py
Library         ../../Resources/commonPythonKeywords/libwrap.py
Library         Collections
Library         String
Library         JSONLibrary


*** Keywords ***
API-CreateSession
    [Arguments]    ${url}=${API_URL}
    # Create a session with a base URL
    ${session_id}=    Set Variable    LoginSession
    suppress_insecure_request_warning
    Create Session
    ...    ${session_id}
    ...    ${url}
    ...    timeout=10
    ...    retry_method_list=['OPTIONS', 'DELETE', 'GET', 'TRACE', 'PUT', 'HEAD']
    Set Global Variable    ${session_id}

Auth_token
    [Arguments]    ${dict}=${User_Credentials}    ${code}=200
    suppress_insecure_request_warning
    ${data}=    Set Variable    {"email": "${dict}[email]","password": "${dict}[password]"}
    Log    ${data}
    Log    ${HEADERS}
    API-CreateSession
    ${response}=    Post On Session
    ...    ${session_id}
    ...    ${API_URL_Auth_GetAPIToken}
    ...    data=${data}
    ...    headers=${HEADERS}
    Log    ${response.status_code}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${response.status_code}    ${code}
    ${access_token}=    Get From Dictionary    ${response.json()}    access_token
    ${dict}[access_token]=    Set Variable    ${access_token}
    Log    ${access_token}
    RETURN    ${access_token}

GetCustomerID
    [Arguments]    ${dict}=${NewUser_Credentials1}
    suppress_insecure_request_warning
    ${data}=    Set Variable    {"email": "${dict}[email]","password": "${dict}[password]"}
    Log    ${data}
    Log    ${HEADERS}
    API-CreateSession
    ${response}=    Post On Session
    ...    ${session_id}
    ...    ${API_URL_Auth_GetAPIToken}
    ...    data=${data}
    ...    headers=${HEADERS}
    Log    ${response.status_code}
    ${user_uuid}=    Get From Dictionary    ${response.json()}    user_uuid
    ${dict}[user_uuid]=    Set Variable    ${user_uuid}
    Log    ${user_uuid}
    RETURN    ${user_uuid}

GetResponse
    [Arguments]    ${uri}    ${dict}=${User_Credentials}
    [Return]    ${response}
    ${auth_token}=    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=KC    timeout=30
    ${uri}=    Replace String    ${uri}    INDEX    ${Root}[mac1]
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    Log    ${RetResponse.status_code}
    ${response}=    Set Variable   ${RetResponse.json()}

GetStatus
    [Arguments]    ${uri}    ${mac}
    [Return]    ${response}
    ${auth_token}=    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=KC    timeout=30
    ${uri}=    Replace String    ${uri}    INDEX    ${mac}
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    Log    ${RetResponse.status_code}
    ${response}=    Set Variable   ${RetResponse.json()}

REPLACE
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    ${date_30_days_ago}=    Subtract Time From Date    ${current_date}    30d    result_format=%Y-%m-%d
    ${add}   Set Variable       ${adder_1}${date_30_days_ago}${adder_2}${current_date}${adder_3}
    ${add_1}=   Replace String   ${add}   subMac      ${subMac}
    Log    ${add}
    RETURN    ${add_1}

delete_mac_provision
    [Arguments]    ${macaddress}
    API-CreateSession

provision_get_api
    [Arguments]    ${macaddress}    ${OUI}    ${Productclass}    ${serial_num}
    ${data}=    Set Variable    {"email": "${dict}[email]","password": "${dict}[password]"}
    Log    ${data}
    Log    ${HEADERS}
    API-CreateSession
    suppress_insecure_request_warning
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}
    ${uri}=    Replace String    ${API_UPDATE_GET_PROVISION}    INDEX    ${mac_address}
    ${response}=    Post On Session
    ...    ${session_id}
    ...    ${API_URL_Auth_GetAPIToken}
    ...    data=${data}
    ...    headers=${HEADERS}
    Log    ${response.status_code}
    ${user_uuid}=    Get From Dictionary    ${response.json()}    user_uuid
    ${dict}[user_uuid]=    Set Variable    ${user_uuid}
    Log    ${user_uuid}
    RETURN    ${user_uuid}

wifipoint_provision_API
    [Arguments]    ${macaddress}    ${password}
    API-CreateSession
    suppress_insecure_request_warning
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}
    ${uri}=    Replace String    ${API_URL_provision}    INDEX    ${mac_address}
    ${data}=    Set Variable    { "username": "${macaddress}", "password": "${password}" }
    ${data}=    Replace String    ${data}    string1    ${macaddress}
    ${data}=    Replace String    ${data}    string2    ${password}
    ${data}=    Convert String To Json    ${data}
#    ${provision_api_json}=    evaluate    json.dumps(${data})    json
    ${RetResponseA}=    Run Keyword    POST On Session    ${session_id}    ${uri}    json=${data}    headers=${HEADERS}
    Log    ${RetResponseA}
    Status Should Be    200    ${RetResponseA}

cloud_account_create
    [Arguments]
    ...    ${macaddress}
    ...    ${email}= "kdjcsowefda@gmail.com"
    ...    ${tenantName}="dummymac"
    API-CreateSession
    suppress_insecure_request_warning
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=KC
    ${uri}=    Replace String    ${API_URL_CreateAccount}    INDEX    ${mac_address}
    ${data}=    Set Variable
    ...    { "name": "${tenantName}", "email": "${email}","password": "Nokia@12345","mac": "${macaddress}"}
    ${data}=    Convert String To Json    ${data}
    ${RetResponseA}=    POST On Session    ${session_id}    ${uri}    json=${data}    headers=${HEADERS}
    Log    ${RetResponseA.content}
    ${Ret}=    Convert String To Json    ${RetResponseA.content}
    ${message}=    Get From Dictionary    ${Ret}    user_uuid
    RETURN    ${message}

AddIPAddressAPI
    [Arguments]    ${customerid}    ${macaddress}
    ${data}=    Set Variable    { "uuid": "${customerid}", "home_wifis": [ "${macaddress}" ], "ip": "10.10.10.11"}
    API-CreateSession
    suppress_insecure_request_warning
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}
    ${data}=    Convert String To Json    ${data}
    ${RetResponseA}=    POST On Session    ${session_id}    ${API_UPDATE_UUID}    json=${data}    headers=${HEADERS}
    Return       ${RetResponseA.content}
    Log    ${RetResponse.status_code}
    ${response}=    Set Variable   ${RetResponse.json()}


CheckIpaddressAPI
    [Arguments]    ${customerid}
    API-CreateSession
    suppress_insecure_request_warning
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}
    ${uri}=    Replace String    ${API_URL_MATCH}    INDEX    ${customerid}
    
GetStatus
    [Arguments]    ${uri}    ${mac}
    [Return]    ${response}
    ${auth_token}=    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=KC    timeout=30
    ${uri}=    Replace String    ${uri}    INDEX    ${mac}
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    ${RetResponse}=    Set To Dictionary    ${RetResponse.json()}
    Run Keyword And Continue on Failure    Should Be Equal    ${RetResponse}[ip]    10.10.10.11
    Log    ${RetResponse.status_code}
    ${response}=    Set Variable   ${RetResponse.json()}

getDeviceDetails
    [Arguments]    ${mac}
    ${auth_token}=    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=KC    timeout=30
    ${uri}=    Replace String    ${API_DEVICE_MANAGEMENT_GET}    INDEX    ${mac}
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    ${RetResponse}=    Set To Dictionary    ${RetResponse.json()}
    Log    ${RetResponse}
    ${response}=    Set Variable   ${RetResponse}
    Return From Keyword    ${response}

getSecureSubscription
    [Arguments]    ${mac}
    ${deviceDetails}    getDeviceDetails    ${mac}
    ${auth_token}=    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=KC    timeout=30
    ${uri}=    Replace String    ${API_SECURE_SUBSCRIPTION_GET}    SUBSCRIBERID    ${deviceDetails}[uuid]
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    ${RetResponse}=    Set To Dictionary    ${RetResponse.json()}
    Log    ${RetResponse}
    ${response}=    Set Variable   ${RetResponse}
    Return From Keyword    ${response}

getTenantInfo
    [Arguments]    ${url}=${MarketPlace}[url]    ${token}=${MarketPlace}[token]
    API-CreateSession    ${url}
    ${headers}=    Create Dictionary    token=${token}
    ${uri}    Set Variable    ${API_ADMIN_GET_ALL_TENANT}
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}    timeout=10
    Log    ${RetResponse.json()}
    Return From Keyword    ${RetResponse.json()}

putTenantInfo
    [Arguments]    ${dataJson}    ${url}=${MarketPlace}[url]    ${token}=${MarketPlace}[token]
    ${json_string}=    Evaluate    json.dumps(${dataJson})    json
    API-CreateSession    ${url}
    ${headers}=    Create Dictionary    token=${token}
    ${uri}    Set Variable    ${API_ADMIN_GET_ALL_TENANT}
    ${RetResponse}=    PUT On Session    ${session_id}    ${uri}    json=${dataJson}    headers=${headers}
    Log    ${RetResponse}
DeleteSubscriberReset
    [Arguments]    ${URL}    ${UUID}    ${topology}=true    ${account}=true    ${respcode}=200
    [Return]    ${response}
    ${access_toke}=    Auth_token
    ${uri}=	Replace String	${URL}	UUID	${UUID}
    ${uri}=	Replace String	${uri}	INDEX	${topology}    count=1
    ${uri}=	Replace String	${uri}	INDEX	${account}    count=1
    &{headers}=	Create Dictionary	Authorization=${access_toke}	Content-Type=application/json    X-Service-Type=KC
    ${response}=	DELETE On Session   ${session_id} 	${uri}	headers=${headers}    timeout=120
    Run Keyword And Continue on Failure	Should be equal as strings	${response.status_code}    ${respcode}
    ${response}    Set Variable    ${response.json()}

single_wifipoint_association_API
    [Arguments]    ${customerid}    ${macaddress}   ${name}   ${email}
    ${data}=    Set Variable    { "uuid": "${customerid}", "home_wifis": [ "${macaddress}" ], "name": "${name}", "email": "${email}" }
    API-CreateSession
    suppress_insecure_request_warning
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}
    ${data}=    Convert String To Json    ${data}
    ${RetResponse}=   POST On Session    ${session_id}    ${API_URL_SingleAssociation}    json=${data}  headers=${HEADERS}
    Log    ${RetResponse.status_code}
    ${response}=    Set Variable   ${RetResponse}


bulk_wifipoint_association_API
    ${File_name}=    Set Variable    ${supporting_path}\\mesh6.csv
    ${access_token}=    Auth_token
    ${url}   Set Variable  ${API_URl}${API_URL_BulkAssociation}
    ${res} =  file_upload_api   ${url}   ${access_token}   ${File_name}
    log   ${res}
    Should Be Equal   ${res}  True

update_wifipoint_association_API
    [Arguments]    ${customerid}    ${macaddress}   ${name}   ${email}
    ${data}=    Set Variable    { "uuid": "${customerid}", "home_wifis": [ "${macaddress}" ], "name": "${name}", "email": "${email}" }
    API-CreateSession
    suppress_insecure_request_warning
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}
    ${data}=    Convert String To Json    ${data}
    ${RetResponse}=    POST On Session    ${session_id}    ${API_URL_UpdateBeaconInventory}    json=${data}    headers=${HEADERS}
    Log    ${RetResponse.status_code}
    ${response}=    Set Variable   ${RetResponse}

getDeviceCount
    [Arguments]    ${mac}
    ${auth_token}=    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=KC    timeout=30
    ${uri}=    Replace String    ${API_URL_Clients}    INDEX    ${mac}
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    Log  ${RetResponse}
    ${RetResponse}=     Set Variable   ${RetResponse.json()}
    Log   ${RetResponse}
    ${response}=    Set Variable   ${RetResponse}
    Return From Keyword    ${response}

DeviceMemberProfileFromCloud
    [Arguments]    ${deviceMac}
    Log to console    Get the member profile devices data in cloud mode
        ${auth_token}=    Auth_token
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=KC    timeout=30
    ${uri}=    Replace String    ${API_MEM_PROFILE}    INDEX    ${mac}
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    Log  ${RetResponse}
    ${RetResponse}=     Set Variable   ${RetResponse.json()}
    Log    ${RetResponse}
    ${response}=    Set Variable   ${RetResponse}
    Run Keyword  Should be equal as strings    ${response.status_code}    200
    Log Many    ${response}
    Return From Keyword    ${response}
