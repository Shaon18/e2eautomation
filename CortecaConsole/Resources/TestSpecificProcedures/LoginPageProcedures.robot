*** Settings ***
Resource     ../KeywordDefinition/CommonKeywords.robot
Variables    ../JavaScriptCodes/executeJavaScriptCodeCorteca.py
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/CortecaConsoleLocators.py
Library    Collections
Variables    ../TestDatas.py
Resource    ConfigureBoengSSH.resource
Resource    ../KeywordDefinition/WebGUIAccessControlEnable.resource

*** Keywords ***

Login To Corteca Console
    [Documentation]    This function will perform the following:
    ...                 1: Open the Corteca portal
    ...                 2: login the page with Credentials provided
    ...                 3: Verify the login successful and capture the screenshot under loginPage.png
    ...                 Arguments:
    ...                  url -> Site url to be open
    ...                  browserOption -> Which browser (Chrome)
    ...                  username -> username
    ...                  paswd -> Password
    ...                  textToCheck -> Text to check after Loading to page
    [Arguments]    ${url}=${cloudDetail}[URL]    ${browser}=${browserOption}    ${username}=${cloudDetail}[uname]    ${paswd}=${cloudDetail}[pswd]    ${textToCheck}=Corteca console
    Open Portal   ${url}    ${browser}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${txtInputUsername}
    Enter Value    ${txtInputUsername}   ${username}
    Enter Value    ${txtInputPassword}   ${paswd}
    Press Click Button    ${btnLogin}
    Wait Until Page Contains     ${textToCheck}    timeout=60s
    Page Should Contain    ${textToCheck}


Logout From Corteca Console
    [Documentation]    This function will close the browsers
    Close Portal

Open Corteca Console Home Page
    [Documentation]    This function will perform the following:
    ...                 1: Open the Home page from corteca apps dashboard page
    ...                 2: Verifies the home page loading completion and capture the screenshot under Home.png
    ...                 Arguments:
    ...                  searchType -> MAC/Email/Name/Serial/ID defined in SetupDetails.py File
    ...                                MAC-> Serach with MAC (value of subMac)
    ...                                Email-> Serach with mail id (value of subEmail)
    ...                                Name-> Serach with Serial number(value of subSerial)
    ...                                MAC-> Serach with cutomer ID(value of subId)
    [Arguments]    ${searchType}=MAC    ${macToEnter}=${EMPTY}
    Press Click Element    ${eleCortecaDashbordHome}
    Wait Until Page Contains Element    ${eleHomeSearch}
    #Capture Page Screenshot    ${saveScreenShotPath}/Home.png
    ${statusMac}    Run Keyword And Return Status    Should Be Equal As Strings    ${macToEnter}    ${EMPTY}
    Run Keyword If    ${statusMac}    Search Subscriber    ${searchType}    ELSE    Search Subscriber With Mac    ${macToEnter}
    Wait Until Page Contains Element    ${elecloseToaster}    timeout=120s
    #sleep 1 min to close recommendation
    Run Keyword And Ignore Error    Click Element    ${elecloseToaster}
    Sleep    ${sleepMin}
    #Run Keyword If    ${HomeTroubleshooting}    Press Click Element    ${eleCustomerCard}
    ${customerInfo}    Get Customer Card Info
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${timeZone}    ${customerInfo}[Timezone]
    ${status}    Run Keyword And Return Status    Press Click Element    ${eleSettingsTab}
    Run Keyword If    '${status}'=='False'    Press Click Element    ${eleNewPortal}
    Run Keyword If    '${status}'=='True'    Press Click Element    ${overv}
#    ${status}=    Set Variable    False
#    Wait Until Keyword Succeeds    10 times    6 second    Wait until RunDiag    ${status}

Open Corteca Console Home Page in readonly access
    [Documentation]    This function will perform the following:
    ...                 1: Open the Home page from corteca apps dashboard page
    ...                 2: Verifies the home page loading completion and capture the screenshot under Home.png
    ...                 Arguments:
    ...                  searchType -> MAC/Email/Name/Serial/ID defined in SetupDetails.py File
    ...                                MAC-> Serach with MAC (value of subMac)
    ...                                Email-> Serach with mail id (value of subEmail)
    ...                                Name-> Serach with Serial number(value of subSerial)
    ...                                MAC-> Serach with cutomer ID(value of subId)
    [Arguments]    ${searchType}=MAC    ${macToEnter}=${EMPTY}
    Press Click Element    ${eleCortecaDashbordHome}
    Wait Until Page Contains Element    ${eleHomeSearch}
    #Capture Page Screenshot    ${saveScreenShotPath}/Home.png
    ${statusMac}    Run Keyword And Return Status    Should Be Equal As Strings    ${macToEnter}    ${EMPTY}
    Run Keyword If    ${statusMac}    Search Subscriber    ${searchType}    ELSE    Search Subscriber With Mac    ${macToEnter}
    Sleep    ${sleepAvg}
    Wait Until Page Contains Element    ${eleclosereadonlyDia}    timeout=120s
    Run Keyword And Ignore Error    Click Element    ${eleclosereadonlyDia}
    Sleep    ${sleepMin}
    Wait Until Page Contains Element    ${elecloseToaster}    timeout=120s
    #sleep 1 min to close recommendation
    Run Keyword And Ignore Error    Click Element    ${elecloseToaster}
    Sleep    ${sleepMin}
    #Run Keyword If    ${HomeTroubleshooting}    Press Click Element    ${eleCustomerCard}
    ${customerInfo}    Get Customer Card Info
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${timeZone}    ${customerInfo}[Timezone]
    ${status}    Run Keyword And Return Status    Press Click Element    ${eleSettingsTab}
    Run Keyword If    '${status}'=='False'    Press Click Element    ${eleNewPortal}
    Run Keyword If    '${status}'=='True'    Press Click Element    ${overv}

Get Customer Card Info
    [Documentation]    Fetching the customer card info and return a dictonary
    Press Click Element    ${eleCustomerCard}
    Wait Until Element Is Visible    ${eleCustomerCard}
    ${customerInfo}    Get Length    ${customerInfoList}
    ${child}    Set Variable    2
    ${customerInfoDict}    Create Dictionary
    FOR    ${i}    IN RANGE    0    ${customerInfo}
        ${child1}    Set Variable    ${child}
        ${child1}    Convert To String    ${child1}
        ${childSelector}    Replace String    ${eleCustomerCardInfo}    INDEX    ${child1}
        ${customerInfoScript}    Replace String    ${customerInfoJavaScript}    CUSTOMERINFOLOCATOR    ${childSelector}
        ${childInfo}    Execute Javascript    ${customerInfoScript}
        Log    **** Updating value for ${customerInfoList}[${i}] with ${childInfo}
        Set To Dictionary    ${customerInfoDict}    ${customerInfoList}[${i}]    ${childInfo}
        ${child}    Evaluate    ${child}+2
    END
    Press Click Element    ${eleCustomerCard}
    Log    ${customerInfoDict}
    Return From Keyword    ${customerInfoDict}
    
Get Customer Card Info Old portal
    [Documentation]    Fetching the customer card info and return a dictonary
    ${customerInfo}    Get Length    ${customerInfoList}
    ${child}    Set Variable    2
    ${customerInfoDict}    Create Dictionary
    FOR    ${i}    IN RANGE    0    ${customerInfo}
        ${child1}    Set Variable    ${child}
        ${child1}    Convert To String    ${child1}
        ${childSelector}    Replace String    ${eleCustomerCardInfoOld}    INDEX    ${child1}
        ${customerInfoScript}    Replace String    ${customerInfoJavaScript}    CUSTOMERINFOLOCATOR    ${childSelector}
        ${childInfo}    Execute Javascript    ${customerInfoScript}
        Log    **** Updating value for ${customerInfoList}[${i}] with ${childInfo}
        Set To Dictionary    ${customerInfoDict}    ${customerInfoList}[${i}]    ${childInfo}
        ${child}    Evaluate    ${child}+2
    END
    Log    ${customerInfoDict}
    Return From Keyword    ${customerInfoDict}

Open Corteca Console Troubleshooting Page
    [Documentation]    This function will perform the following:
    ...                 1: Open the Troubleshooting page from corteca apps dashboard page
    ...                 2: Verifies the troubleshooting page loading completion and capture the screenshot under troubleshoot.png
    ...                 Arguments:
    ...                  searchType -> MAC/Email/Name/Serial/ID defined in SetupDetails.py File
    ...                                MAC-> Serach with MAC (value of subMac)
    ...                                Email-> Serach with mail id (value of subEmail)
    ...                                Name-> Serach with Serial number(value of subSerial)
    ...                                MAC-> Serach with cutomer ID(value of subId)
    [Arguments]    ${searchType}=MAC
    Press Click Element    ${eleCortecaDashbordTroubleshooting}
    Wait Until Page Contains Element    ${eleHomeSearch}
    Capture Page Screenshot    ${saveScreenShotPath}/Troubleshoot.png
    Search Subscriber    ${searchType}
    Wait Until Page Contains Element    ${closeToaster}    timeout=60s
    #sleep 1 min to close recommendation
    Run Keyword And Ignore Error    Click Element    ${closeToaster}
    Sleep    60s
    #${status}=    Set Variable    False
    #Wait Until Keyword Succeeds    10 times    6 second    Wait until RunDiag    ${status}

Get the Subscriber value
    [Documentation]    This function get the predifined subscriber search value based on the type given:
    ...                 1: Argument1:  type-> MAC/Email/Name/Serial/ID defined in SetupDetails.py File
    ...                 MAC-> Serach with MAC (value of subMac)
    ...                 Email-> Serach with mail id (value of subEmail)
    ...                 Name-> Serach with Serial number(value of subSerial)
    ...                 MAC-> Serach with cutomer ID(value of subId)
    [Arguments]    ${type}=MAC
    ${sub}=    Set Variable    ''
    ${sub}=    Set Variable If    '${type}'=='MAC'    ${subMac}    ${sub}
    ${sub}=    Set Variable If    '${type}'=='Email'    ${subEmail}    ${sub}
    ${sub}=    Set Variable If    '${type}'=='Name'    ${subName}    ${sub}
    ${sub}=    Set Variable If    '${type}'=='Serial'    ${subSerial}    ${sub}
    ${sub}=    Set Variable If    '${type}'=='ID'    ${subId}    ${sub}
    Return From Keyword    ${sub}

Search Subscriber
    [Documentation]    This function will search the customer based on the below values:
    ...                 1: Argument1:  type-> MAC/Email/Name/Serial/ID
    ...                 MAC-> Serach with MAC
    ...                 Email-> Serach with mail id
    ...                 Name-> Serach with Serial number
    ...                 MAC-> Serach with cutomer ID
    [Arguments]    ${type}=MAC
#    ${sub}=    Get The Subscriber Value    ${type}
#    Enter Value    ${eleHomeSearch}    ${sub}
#    Press Click Button    ${btnSubscriberSearch}
#    Wait Until Page Contains Element    ${subscriberSearchResultTable}
#    Press Click Element    ${subscriberSearchResultTable}
    ${sub}=    Get The Subscriber Value    ${type}
    Enter Value    ${eleHomeSearch}    ${sub}
#    Click Element    ${mac_sub}
    Press Click Button    ${btnSubscriberSearch}
    ${subscriberSelector}    Replace String    ${subscriberSearchResultTable}    SUBSCRIBER    ${sub}
    Wait Until Page Contains Element    ${subscriberSelector}
    Press Click Element    ${subscriberSelector}

Wait until RunDiag
    [Documentation]    This function will execute the javascript code in rundiaWaitCheck and check status as true
    [Arguments]    ${status}
    ${status}=    Execute Javascript    ${rundiaWaitCheck}
    Should Not Be True    ${status}

Move to page
    [Documentation]    This function will execute the javascript code in rundiaWaitCheck and check status as true
    [Arguments]    ${pageName}    ${testToCompare}
    Press Click Button    ${btnSubscriberSearch}
    Wait Until Page Contains Element    ${subscriberSearchResultTable}

Verify the Toaster Message
    [Documentation]    This function get the toaster text and compare with given text and checks both are eaual
    ...                Arguments: 
    ...                    textToValidate -> Text to check in the toaster card
    ...                    timeout -> Time to wait for the toaster appearance
    [Arguments]    ${textToValidate}    ${timeout}
    ${toasterMsg}    Get the Toaster Message    ${eleToaster}    ${elecloseToaster}   timeout=${timeout}
    Should Match Regexp    ${toasterMsg}    ${textToValidate}    Expected Toaster Message is ${textToValidate} But received ${toasterMsg}
    #FOR    ${i}    IN RANGE    0    ${toasterLoop}
    #    ${status}    Run Keyword And Return Status    Validate Toaster    ${eleToaster}    ${elecloseToaster}    ${toasterText}    timeout=${timeout}
    #    Exit For Loop If    ${status}
    #END

Perform Factory Reset In USP
    ${result}   SSHExecute    cfgcli -rall
    sleep  600s
    ConfigureBoeng

Perform Software Upgrade In USP
    [Arguments]    ${imagePath}     ${ip}=${Root}[ip]    ${paswd}=${Root}[telnet_vtysh]
    SoftwareUpgradeViaWebgui    ${imagePath}
    sleep  900s
    Log To Console   After Waiting 600s After software upgrade verifyting the USP mqtt connection
    Validate_Process    ${ip}    ${paswd}

Make WAN Down
    [Arguments]    ${enable}='true'
    Log Many    Making Wan status to:    ${enable}
    ${result}   SSHExecute    ${WanDownSetCommand} ${enable}
    Sleep    60s
    ${result1}   SSHExecute    ${WanDownGetCommand}
    Should Match Regexp    ${result1}    ${enable}

Search Subscriber With Mac    
    [Arguments]    ${mac}
    Enter Value    ${eleHomeSearch}    ${mac}
    Press Click Button    ${btnSubscriberSearch}
    ${subscriberSelector}    Replace String    ${subscriberSearchResultTable}    SUBSCRIBER    ${mac}
    Wait Until Page Contains Element    ${subscriberSelector}
    Press Click Element    ${subscriberSelector}

CollectUILog
    [Arguments]    ${action}
    ${logs} =    Execute Javascript    ${networkTabLog}
    Log    ${logs}
    ${har_file} =    Save HAR File    ${logs}    ${action}
    Log To Console    HAR file saved at: ${har_file}
#    Close Browser

Save HAR File
    [Arguments]    ${logs}    ${action}
    ${i}    Generate Random String    1    [NUMBERS]
    ${har_path} =    Set Variable    ${CurrentWorkingDirectoryFolder}/network_log_${action}_${i}.har
#    ${json_logs} =    Evaluate    json.dumps(${logs})    json
    ${json_logs} =    Create Dictionary    log={"version": "1.2", "creator": {"name": "Robot Framework", "version": "1.0"}, "entries": ${logs}}
    ${har_json} =    Convert To String    ${json_logs}
    Create File    ${har_path}    ${har_json}
    Return From Keyword    ${har_path}