*** Settings ***
Library     String
Library     Collections
Library     QWeb
Library     Process
Library        DateTime
Variables           ../../Locators/CortecaConsoleLocators.py
Variables       ../../InputFiles/EnvironmentInput.py
Variables    ../TestDatas.py
Variables    ../JavaScriptCodes/executeJavaScriptCodeCorteca.py

*** Keywords ***
LoginTobrowserqweb
    [Documentation]    This function will open the url provided with the given browser
    ...    - Argument1: browserUrl-> URL of the site
    ...    - Argument2: browser-> Browser in which url need to be open. eg: Chrome.
    [Arguments]
    ...    ${browserUrl}=https://homeconsole1.stg.homewifi.nokia.com/tenant3
    ...    ${browser}=chrome
    ...    ${username}=tenant3user
    ...    ${paswd}=tenant3user
    ...    ${textToCheck}=Dashboards
    #${result}=    Run Process    python    ${currentdirectoryfolder}\auto_installer_chrome.py
    Log To Console    open the browser
    QWeb.Open Browser    ${browserUrl}    ${browser}
    # set config delay executing keywords by 1.5 seconds
    SetConfig    Delay    0.5s
    # Open Browser    ${browserUrl}    Chrome
    SetConfig    RetryInterval    2s
    Maximize Window
    # retry the same keywords again after 2s seconds
    qwebelement.typetext    ${username}    username
    qwebelement.typetext    ${paswd}    password
    qwebelement.clicktext    login



Move To Troubleshooting Dashboard
    LoginTobrowserqweb
    Qwebelement.clicktext         Troubleshooting
    ClickElement    ${subssearch}
    Qwebelement.typetext     ${subMac}    ${subssearch}
    Qwebelement.clicktext    Search
    ClickElement            ${clickfirstresult}
    VerifyText         Repeat diagnostic    300s



Move to Home Dashboard
    LoginTobrowserqweb
    Qwebelement.clicktext         Home troubleshooting
    QWeb.ClickElement    ${subssearch}
    Qwebelement.typetext     ${subMac}    ${subssearch}
    Qwebelement.clicktext    Search
    QWeb.ClickElement            ${clickfirstresult}
    Sleep  5s
    Run Keyword And Continue On Failure        VerifyText               Repeat diagnostic    300s
    VerifyText    ${timeZone}
    LogScreenshot
    ClickElement  ${eleCustomerCard}
    ${s}    Replace String    ${timezonecheck}    timezone    ${timeZone}
    VerifyElement  ${s}
    LogScreenshot
    ${status}    Run Keyword And Return Status    VerifyText    Radio management
    Run Keyword If    '${status}'=='False'    Qw.ExecuteJavaScript    ${expandSideBar}
    Qw.ExecuteJavaScript    ${expandSideBar}



Move to Remote Logging page
    LoginTobrowserqweb    ${RemoteLogin}[URL]   chrome   ${RemoteLogin}[uname]   ${RemoteLogin}[pswd]
    Log To Console    moving to setup page
    Click Text     Home troubleshooting
    SearchSetupConsole    ${Root}[mac1]
    Run Keyword And Ignore Error    Click Element    ${eleNewPortal}
    Click Text     Remote Logging

    
check and move to homedashboard
    Qwebelement.clicktext         Home troubleshooting
    QWeb.ClickElement    ${subssearch}
    Qwebelement.typetext     ${subMac}    ${subssearch}
    Qwebelement.clicktext    Search
    QWeb.ClickElement            ${clickfirstresult}
    Sleep  5s
    Run Keyword And Continue On Failure        VerifyText               Repeat diagnostic    300s
    VerifyText    ${timeZone}
    LogScreenshot
    ClickElement  ${eleCustomerCard}
    ${s}    Replace String    ${timezonecheck}    timezone    ${timeZone}
    VerifyElement  ${s}
    LogScreenshot
    ${status}    Run Keyword And Return Status    VerifyText    Radio management
    Run Keyword If    '${status}'=='False'    Qw.ExecuteJavaScript    ${expandSideBar}
    Qw.ExecuteJavaScript    ${expandSideBar}



qwebelement.typetext
    # further refer this page to user many aurgments for the test case https://qentinelqi.github.io/qweb/QWeb.html#Type%20Text
    [Documentation]    Typetext    to input text , via web element or string
    [Arguments]    ${input_text}    ${locator}    ${anchor}=1
    TypeText    ${locator}    ${input_text}

qwebelement.clicktext
    # https://qentinelqi.github.io/qweb/QWeb.html#Click%20Text
    [Documentation]    clicktext    to click text/button , via web element or string
    [Arguments]    ${string1}
    Click Text    ${string1}

Qw.ExecuteJavaScript
    [Arguments]    ${operation}
    ${action2}=    Set Variable    ${operation}
    # ${PS}=    Run Keyword And Return Status    ExecuteJavaScript    ${action2}
    ${PS}=    Set Variable    True
    IF    ${PS}
        ${returnValue}=    Run Keyword And Return Status
        ...    QWeb.Execute Java Script
        ...    ${action2}
    ELSE
        ${returnValue}=    Set Variable    ${None}
    END
    IF    '${PS}'=='False'    Log Screenshot
    IF    '${PS}'=='False'
        Fail
        ...    Path specified did not match any elements. Try adding the correct path. OR The Element was not present in the page.
    END
    RETURN    ${returnValue}

Qw.closebrowser
    QWeb.Close All Browsers

Save Screenshot
    QWeb.Log Screenshot

Move to event history
    Qwebelement.clicktext    Event history

Open SA Configuration
    Qwebelement.clicktext    Configuration
    
Open SA network device
    QWeb.ClickText        Network device        Support actions
SearchSetupConsole
    [Arguments]    ${mac}
    Click Element    ${HomeInput}
    Type Text       ${HomeInput}       ${mac}
    Click Element    ${SearchHomeMac}
    Click Text    ${mac}   anchor= Associated MAC
    Verify Text    Network map      timeout= 60s
    Verify Text    Network diagnostic running     timeout= 60s
    Verify No Text     Network diagnostic running     timeout= 360s
Qweb.Search Subscriber
    [Documentation]    This function will search the customer based on the below values:
    ...                 1: Argument1:  Verify-> string pattern to macth the search value
    ...                 default -> None
    ...                 2: Argument2:  type-> Name/Email/Customer ID/ MAC/Serial number
    ...                 Name-> Search with Name
    ...                 Email-> Search with mail id
    ...                 Customer ID -> Search with customer ID
    ...                 MAC-> Search with MAC
    ...                 Serial number-> Search with cutomer ID
    ...                 Default -> will be Auto detect

    [Arguments]   ${input}   ${verify}=None  ${type}=Auto detect
    LoginTobrowserqweb
    qwebelement.clicktext    Home
    qwebelement.typetext    ${input}    Enter customer details    ancher=${type}
    qwebelement.clicktext    Search
    IF    '${verify}' != 'None'
        ${searchvalue} =    Set Variable   ${verify}
    ELSE
         ${searchvalue} =    Set Variable   ${input}
    END
    Verify Text   ${searchvalue}
    Qw.closebrowser

Qweb.Event History Validation
    [Documentation]    This function to verify the event history for Root MAC
    ...                 Argumen1: patterns-> List of string pattern to search in Event histoy
    ...                 Argumen2:  input -> default will be root MAC
    ...                 Argumen3:  serach type-> Name/Email/Customer ID/ MAC/Serial number
    ...                 Name-> Search with Name
    ...                 Email-> Search with mail id
    ...                 Customer ID -> Search with customer ID
    ...                 MAC-> Search with MAC
    ...                 Serial number-> Search with cutomer ID
    ...                 Default -> will be Auto detect
    [Arguments]  @{patterns}  ${input}=${Root}[mac1]  ${type}=Auto detect
    LoginTobrowserqweb
    qwebelement.clicktext    Home troubleshooting
    qwebelement.typetext    ${input}    Enter customer details    ancher=${type}
    qwebelement.clicktext    Search
    qwebelement.clicktext    ${input}
    Sleep    30s
    Qwebelement.clicktext    View all events
    FOR    ${item}    IN   @{patterns}
        Refresh Page
        VerifyText   ${item}
    END
    Qw.closebrowser


Qweb.Get Start Time Portal
    [Arguments]    ${diffs}    ${diffsDay}
    ${date1}=    Get Current Date	exclude_millis=yes
    ${dateformat}=	Convert Date	${date1}	result_format=%b %d, %Y %I:%M %p
    ${datetocheckformat}=	Subtract Time From Date	${date1}	${diffs} minutes	result_format=%Y-%m-%d %I:%M %p	exclude_millis=yes
    ${date}=	Subtract Time From Date	${date1}	${diffs} minutes	exclude_millis=yes
    Log    ${date}
    ${date}=	Run keyword if	'${diffsDay}'!=0	Subtract Time From Date	${date}	${diffsDay} days
    Log    ${date}
    # New Portal date format
    ${datenew}=    Convert Date    ${date}    result_format=%b %d, %Y %I:%M %p
    ${L1date}=	Convert Date    ${date}    result_format=%b %d %Y %I:%M %p
    Log    ${L1date}
    ${datesplit}=	Split String    ${datenew}    ,
    ${Monthupper}=	Convert To Uppercase	${datesplit[0]}
    ${datelist}=	create list	${Monthupper}	${datesplit[1]}
    Log    ${datelist}
    ${startdatefmt}=	Evaluate	",".join(${datelist})
    ${ribbion}=    Add Time To Date	${date1}	${diffs} minutes	result_format=%d-%m-%Y %I	exclude_millis=yes
    ${24hfmt}=    Add Time To Date	${date1}	${diffs} minutes	result_format=%p	exclude_millis=yes
    ${24hfmt}=    Convert To Lowercase	${24hfmt}
    @{datesl}=    Split String    ${date}    separator=${SPACE}
    @{datetoCsl}=    Split String    ${datetocheckformat}    separator=${SPACE}
    #L1_Portal_format
    @{L1datesp}=	Split String	${L1date}	separator=${SPACE}
    Log Many	@{L1datesp}
    @{L1tm}=    Split String	${L1datesp[3]}    :
    Log Many    @{L1tm}
    Set Test Variable    ${ribbion}	${ribbion}
    Set Test Variable    @{datesl}
    Set Test Variable    @{datetoCsl}
    Set Test Variable    ${diffsDay}
    ${datetocheck}=    Set Variable If    ${diffsDay} == '1 day'    Yesterday    ${diffsDay} == 0	Today    ${datetoCsl}[0]
    Set Test Variable    ${datetocheck}
    Set Test Variable    ${startdatefmt}
    Set Test Variable    ${datest}    ${datesplit[0]}
    #Bandscore_tmfmt_L1
    ${datetmstrip}=    Strip String    ${datesplit[1]}    both    ${SPACE}
    Log    ${datetmstrip}
    ${datetmsplit}=    Split String	${datetmstrip}    ${SPACE}    1
    Log    ${datetmsplit}
    ${datetmlist}=    create list	${datesplit[0]}	${datetmsplit[-1]}
    Log    ${datetmlist}
    ${bandchnst_date}=    Set Variable    ${datesplit[0]}
    Log    ${bandchnst_date}
    ${bandchnst_time}=    Convert To Lowercase    ${datetmsplit[-1]}
    Log    ${bandchnst_time}
    Set Test Variable    ${bandchnst_date}
    Set Test Variable    ${bandchnst_time}
    Set Test Variable    ${24hfmt}


Qweb.Get End Time Portal
    [Arguments]    ${diffe}
    ${date1}=    Get Current Date    exclude_millis=yes
    ${dateformat}=    Convert Date    ${date1}	result_format=%Y-%b-%d %I:%M %p
    ${date}=    Add Time To Date    ${date1}	${diffe}	exclude_millis=yes
    #New Portal date format
    ${datenew}=    Convert Date    ${date}    result_format=%b %d, %Y %I:%M %p
    ${L1date}=    Convert Date    ${date}    result_format=%b %d %Y %I:%M %p
    Log    ${L1date}
    ${datesplit}=    Split String    ${datenew}    ,
    ${Monthupper}=    Convert To Uppercase    ${datesplit[0]}
    ${datelist}=    create list    ${Monthupper}    ${datesplit[1]}
    Log    ${datelist}
    ${enddatefmt}=    Evaluate    ",".join(${datelist})
    @{datedl}=    Split String    ${date}    separator=${SPACE}
    Set Test Variable    @{datedl}
    Set Test Variable    ${diffe}
    Set Test Variable    ${enddatefmt}
    ${Portaldatefmt}=    Evaluate    "${startdatefmt} "+ "-" +" ${enddatefmt}"
    Log    ${Portaldatefmt}
    #L1_Portal_format
    @{L1Endatesp}=    Split String    ${L1date}    separator=${SPACE}
    Log Many    @{L1Endatesp}
    @{L1Endtm}=    Split String    ${L1Endatesp[3]}    :
    Log Many    @{L1Endtm}
    Set Global Variable    ${Portaldatefmt}
    Set Test Variable    ${dateEnd}	${datesplit[0]}
    Return From Keyword    ${Portaldatefmt}