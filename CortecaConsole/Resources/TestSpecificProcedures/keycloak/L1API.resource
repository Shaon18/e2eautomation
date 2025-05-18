*** Settings ***
Library         String
Library         Collections
Library         QWeb
Library         Process
Library         DateTime
Variables       ../../../Locators/keycloak.py
Variables       ../../../Locators/CortecaConsoleLocators.py
Variables       ../../../InputFiles/EnvironmentInput.py
Resource        ../../KeywordDefinition/Qtwebkeywords.resource
Resource        ../../../Resources/KeywordDefinition/Keycloakresources.resource
Resource        ../../../Resources/KeywordDefinition/ApiRequest.resource
Variables            ../../TestDatas.py



*** Keywords ***

Verify corteca elements for l1l2api
    LogScreenshot
    Verifytext    Home troubleshooting
    VerifyText    WiFi Optimization
    VerifyText    FCC Broadband Compliance

Verify corteca elements for l1api
    LogScreenshot
    Verifytext    Home troubleshooting
    VerifyText    FCC Broadband Compliance


create schedule
    LogScreenshot
    Qwebelement.clicktext    keycloak
    LogScreenshot
    Qwebelement.clicktext    Delete
    LogScreenshot
    ClickText    Delete    Cancel
    LogScreenshot
    VerifyText    Success    30s
    Sleep    10s
    Qwebelement.clicktext    New Schedule
    LogScreenshot
    ClickElement    ${namefcc}
    LogScreenshot
    Qwebelement.typetext    keycloak    ${namefcc}
    LogScreenshot
    ClickElement    ${cron}
    LogScreenshot
    Qwebelement.clicktext       Please select
    LogScreenshot
    Qwebelement.clicktext    Hour
    LogScreenshot
    Qwebelement.clicktext    Value
    LogScreenshot
    ClickElement    ${selecthour}
    LogScreenshot
    ClickElement    ${select4}
    LogScreenshot
    Qwebelement.clicktext    Value
    LogScreenshot
    ClickText    Submit    Back
    LogScreenshot
#    ClickText    Speed    Select timezone
#    ClickElement    ${inputlatency}
    Qwebelement.clicktext    Select timezone
    LogScreenshot
    Qwebelement.clicktext    America/Coral_Harbour
    LogScreenshot
    Qwebelement.typetext    56    ${upstream}
    LogScreenshot
    Qwebelement.typetext    98    ${downstream}
    LogScreenshot
    Qwebelement.clicktext    Submit
    LogScreenshot
    Run Keyword And Continue On Failure    VerifyText    Success
    Run Keyword And Continue On Failure    VerifyNoText    This schedule is conflicting with another available schedule


API DEVICE PROVISION
    [Arguments]    ${pay}=${payload_fmcadmin}
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token     ${pay}
    &{headers}=    Create Dictionary    Authorization=${auth_token}    X-Service-Type=${NewUser_Credentials1}[X-ServiceType]    Content-Type=${NewUser_Credentials1}[Content-Type]
    ${device}    Replace String    ${deviceprov}    INDEX    ${Root}[mac]
    ${RetResponse}=    POST On Session       ${session_id}    ${device}    headers=${headers}  json=${abc}
    Status Should Be    200    ${RetResponse}
#    Log To Console    ${RetResponse.status()}
    ${RetResponse}=   Set To Dictionary       ${RetResponse.json()}
    Log To Console      ${RetResponse}


L2 API CHECK
    [Arguments]    ${pay}=${payload_fmcadmin}
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    ${date_1day_ago}=    Subtract Time From Date    ${current_date}    1d    result_format=%Y-%m-%d
    ${online_url}    Set Variable    /ouife/events/ouifeapi?date_start=${date_1day_ago}T10%3A10%3A10&date_end=${current_date}T10%3A10%3A10&device_mac=${Root}[mac]
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token    ${pay}
    &{headers}=    Create Dictionary    Authorization=${auth_token}
    ${RetResponse}=    Get On Session       ${session_id}    ${online_url}    headers=${headers}
    Status Should Be    200    ${RetResponse}

