# keywords related to Kibana Validation
*** Settings ***
Resource     ../KeywordDefinition/CommonKeywords.robot
Variables    ../JavaScriptCodes/executeJavaScriptCodeCorteca.py
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/KibanaLocators.py
Library    DateTime

*** Keywords ***
Login To Kibana Page
    [Documentation]    Function to login to kibana page
    [Arguments]    ${browser}=${browserOption}
    Open Portal   ${kibanadetails}[url]    ${browser}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${Kibanasecondusrnamein}    timeout=60s
    Enter Value    ${Kibanasecondusrnamein}    ${kibanadetails}[firstuser]
    Enter Value    ${Kibanasecondpasswrdin}    ${kibanadetails}[firstpassword]
    Press Click Button    ${Kibanasecondsignin}
    Check Element  ${Kibanatenantgobal}    timeout=240s

Fetch the Kibana Logs
    [Documentation]    Fetch the kibana logs based on search filter
    ...                Arguments:
    ...                    searchString-> Filter to search
    ...                    timePicker24Hours-> time picker as 24 hours if its true
    ...               return: -> Match logs for searchString
    [Arguments]    ${searchString}    ${timePicker24Hours}=False
    [Teardown]    Close All Browsers
    Login To Kibana Page
    ${value}    Set Variable    None
    Run Keyword And Ignore Error    Press Click Element    ${KibanaWelcomePage}
#    Press Click Element    ${Kibanatenantgobal}
    Press Click Element    ${Kibanatenantprivate}

    Press Click Button    ${Kibanatenantconfirm}
    Sleep    ${sleepMin}
    Go To    ${kibanadetails['baseurl']}
    Press Click Button    ${Kibanaplatformsidebar}
    #Enter Value    ${Kibanaplatformselect}    ${kibanadetails}[KibannaPlatform]
    ${platformSelect}    Replace String    ${Kibanaplatformclick}    PLATFORM    ${kibanadetails}[KibannaPlatform]
    Press Click Element    ${platformSelect}
    Sleep    ${sleepMin}
    Press Click Button    ${Kibanadatepicker}
    Sleep    ${sleepMin}
    Run Keyword If    ${timePicker24Hours}    Press Click Element    ${KibanatimepickerLast24hours}    ELSE    Press Click Element    ${Kibanatimepicker}
    Enter Value    ${Kibanasearch}    ${searchstring}
    Press Click Button    ${Kibanarefreshbtn}
    Sleep    ${sleepMax}
    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${Kibanatableresult}    timeout=240s
    ${status}    Run Keyword And Return Status    Page Should Contain Element    ${Kibanatableresult}
    Return From Keyword If    '${status}'=='False'    ${value}
    ${value}    Run Keyword If    ${status}    Get Text    ${Kibanatableresult}
    Capture Page Screenshot
    Return From Keyword    ${value}

Get Kibana Log Time
    [Documentation]    keyword to perform kibana fileter match and get the timestamp of the log
    ...                 Argument:
    ...                    searchString -> filter for kibana search
    ...                 return -> KibanaLogEpoctime -> Log Time in epoch for first Matching log
    [Arguments]    ${searchString}
    ${logData}    Fetch The Kibana Logs    ${searchString}
    Should Not Be Equal As Strings    ${logData}    None    No match found in kibana for ${searchString}
    ${time}    Fetch From Right    ${logData}    @timestamp:
    ${KibanaLogtime}    Fetch From Left    ${time}    @log_name:
    ${KibanaLogEpoctime}    Convert Date    ${KibanaLogtime.strip()}    epoch    date_format=%b %d, %Y @ %H:%M:%S.%f
    Log    ${KibanaLogEpoctime}
    Return From Keyword    ${KibanaLogEpoctime}    ${logData}