*** Settings ***
Library         RequestsLibrary
Variables        ../../Locators/CortecaConsoleLocators.py
Resource        ../../Resources/KeywordDefinition/ApiRequest.resource
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Library         Collections
Library         String
Library         JSONLibrary




*** Keywords ***


create and call session POST
    [Arguments]    ${uri} 
    Delete All Sessions
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=        Create Dictionary    Authorization=${auth_token}  
    Log    ${uri}
    Sleep    100s
    ${RetResponse}=  Run Keyword      POST On Session    ${session_id}    ${uri}    headers=${headers}
    ${RetResponse}=   Set To Dictionary       ${RetResponse.json()}
    RETURN        ${RetResponse}



create_and_call_session_GET
    [Arguments]    ${uri}
    ${auth_token}=    Run Keyword    Auth_token
    &{headers}=        Create Dictionary    Authorization=${auth_token}
    Log    ${uri}
    Sleep    100s
    ${RetResponse}=    GET On Session    ${session_id}    ${uri}    headers=${headers}
    ${RetResponse}=   Set To Dictionary       ${RetResponse.json()}
    RETURN        ${RetResponse}




trigger and fetch logs
    Sleep     30s
    Qwebelement.clicktext        Fetch system log
    Qwebelement.clicktext        Continue
    VerifyText                    Log upload has been requested
    VerifyText                    Success        300s
    Sleep      120s
    Move To Event History
    Run Keyword And Continue On Failure     VerifyText                     Fetch System log operation has been successful. Filename : ${Root}[mac]_systemlogs_
    Run Keyword And Continue On Failure    Trig For Ext


trig for ext
    FOR    ${i}    IN     @{meshNodes}
        Run Keyword And Continue On Failure      VerifyText                     Fetch System log operation has been successful. Filename : ${${i}}[mac]_systemlogs_
    END