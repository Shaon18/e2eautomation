*** Settings ***
Library    Selenium
Library    String
Library    Telnet
Library    Process
Library    Collections
Library    JSONLibrary
Resource     ../KeywordDefinition/CommonKeywords.robot
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/CortecaConsoleLocators.py
Variables    ../TestDatas.py
Variables    ../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py
Resource    LoginPageProcedures.robot
Variables            ../../Resources/TestDatas.py

*** Keywords ***
Check DataModelBrowserPage
    Open Corteca Console Home Page
    Move to DataModelBrowserPage
    Check defaultFields in DataModelBrowserPage
    Validate Autohelper option and data search    ${DataModelBrowserCheckCmd1}
    Check available WiFi points

Move to DataModelBrowserPage
    Log To Console    **** 2. Drag to Advanced settings page ****\n
    Log    \n Move to Advanced settings tab \n
    ${AdvancedSettingsTAB}=    Press Click Element    ${eleAdvancedSettingsTAB}
    Sleep    ${sleepMin}
    Log    \nNavigate to Data Model Browser \n
    ${LANTAB}=    Run Keyword And Continue On Failure    Press Click Element    ${eleDataModelBrowserPage}
    ${AdvanceSettingspgSt1}=    Get Text    ${eleDataModelBrowserPage}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Should Be Equal    ${AdvanceSettingspgSt1}    Data Model Browser
    Sleep    ${sleepMin}

Check defaultFields in DataModelBrowserPage
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Check Element        ${eleBrowserHdr}
    Run Keyword And Continue On Failure    Check Element        ${eleNetworkDevice}
    Run Keyword And Continue On Failure    Check Element        ${eleDataModelBrowser}
    Run Keyword And Continue On Failure    Check Element        ${elehelptxtinbox}
    Run Keyword And Continue On Failure    Check Element        ${elehelptxt}
    Run Keyword And Continue On Failure    Check Element        ${eleApplybtninDMbrowser}
    sleep    ${sleepMin}

Validate Autohelper option and data search
    [Arguments]    ${DMCommand}
    Log    \n \ Check for the auto complete helper is shown \n
    ${DMCommand1}=    set variable    ${DMCommand}
    Enter Value    ${eleInputDMcommand}    ${DMCommand1}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Check Element    ${eleAutocompletehelper}
    sleep    ${sleepMin}
    Log    Check for the result for the data search are shown
    Click Element    ${ApplybtninDMbrowser}
    sleep    ${sleepAvg}
    Run Keyword And Continue On Failure    Check Element    ${eleEditbutton}
    sleep    ${sleepMin}
    Capture Page Screenshot

Validate Autohelper option and data search with Readonly Access
    [Arguments]    ${DMCommand}
    Log    \n \ Check for the auto complete helper is shown \n
    ${DMCommand1}=    set variable    ${DMCommand}
    Enter Value    ${eleInputDMcommand}    ${DMCommand1}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Check Element    ${eleAutocompletehelper}
    sleep    ${sleepMin}
    Log    Check for the result for the data search are shown
    Click Element    ${ApplybtninDMbrowser}
    sleep    ${sleepAvg}
    Run Keyword And Continue On Failure    Page Should Not Contain Element    ${eleEditbutton}
    sleep    ${sleepMin}
    Capture Page Screenshot
    
Check available WiFi points
    Log    Check for the available Wi-Fi points in the dropdown in the Data browser page
    Run Keyword And Continue On Failure    Click Element    ${eleWiFiPointDropdown}
    sleep    ${sleepMin}
    Capture Page Screenshot
    FOR    ${extender}    IN    @{meshNodes}
        ${extFriendlyName}    Set Variable    ${${extender}}[udefi_frn_name]
        Log    ${extFriendlyName}
        ${listExtender}    Get Text    ${eleWiFiPointDropdownList}
        Run Keyword If    '${${extender}_bconType}'=='B2' and '${${extender}_bconType}'=='B1.1'    Should not Contain        ${listExtender}    ${extFriendlyName}
        Run Keyword If    '${${extender}_bconType}'!='B2' and '${${extender}_bconType}'!='B1.1'    Should Contain        ${listExtender}    ${extFriendlyName}
        sleep    ${sleepMin}
    END

Check Edit and Save option in Browser page
    Open Corteca Console Home Page
    Move to DataModelBrowserPage
    Check defaultFields in DataModelBrowserPage
    Validate Autohelper option and data search    ${DataModelBrowserCheckCmd2}
    Edit and save timezone value in browser page
    Check timezone value is intact after change

Edit and save timezone value in browser page
    Log    \nCheck for the edit option is working and will show the list of values can be edited in the particulata data model\n
    Press Click Element    ${eleEditbutton}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Check Element    ${eleDMinputLocalTimezone}
    Run Keyword And Continue On Failure    Check Element    ${eleDMinputNTPEnable}
    sleep    ${sleepMin}
    Log    \nCheck after save the values are reflected in the data model and will not throw any issues while saving\n
    Enter Value    ${eleDMinputLocalTimezone}    ${Timezonevaluechange}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Press Click Element    ${eleSetbutton}
    Verify the Toaster Message    Data object set succeeded    timeout=30s
    Capture Page Screenshot
    sleep    ${sleepMax}

Check timezone value is intact after change
    ${Timezonevaluechange}=    String.Split String    ${Timezonevaluechange}    -
    ${customerInfo}    Get Customer Card Info
    Run Keyword And Continue On Failure    Should contain    ${customerInfo}[Timezone]    ${Timezonevaluechange}[1]
    Log    \nNavigate to Event History Page \n
    Run Keyword And Continue On Failure    Press Click Element    ${networkhistory}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Run Keyword And Continue On Failure     Page Should Contain    Timezone has been changed
    sleep    ${sleepMin}
    ${AdvancedSettingsTAB}=    Press Click Element    ${eleAdvancedSettingsTAB}
    Sleep    ${sleepMin}
    Log    \nNavigate to Data Model Browser \n
    ${LANTAB}=    Run Keyword And Continue On Failure    Press Click Element    ${eleDataModelBrowserPage}
    Sleep    ${sleepMin}

SetDefaultTimezone
    Validate Autohelper option and data search    ${DataModelBrowserCheckCmd2}
    Press Click Element    ${eleEditbutton}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Run Keyword And Continue On Failure    Check Element    ${eleDMinputLocalTimezone}
    Run Keyword And Continue On Failure    Check Element    ${eleDMinputNTPEnable}
    sleep    ${sleepMin}
    Log    \nCheck after save the values are reflected in the data model and will not throw any issues while saving\n
    Enter Value    ${eleDMinputLocalTimezone}    ${DefTimezonevalue}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Press Click Element    ${eleSetbutton}
    Verify the Toaster Message    Data object set succeeded    timeout=20s
    Capture Page Screenshot
    sleep    ${sleepMax}
        
Get operation check in Root
    Check defaultFields in DataModelBrowserPage
    Log    \nCheck for the result for the data search are shown\n
    Validate Autohelper option and data search    ${DataModelBrowserCheckCmd1}
    Run Keyword And Continue On Failure    Check Element    ${eleEditbutton}
    Run Keyword And Continue On Failure    Check Element    ${eleDMvalidationfirmware1}
    Run Keyword And Continue On Failure    Check Element    ${eleDMvalidatiomfirmware2}
    Run Keyword And Continue On Failure    Check Element    ${eleDMvalidatiomfirmware1radiobtn}
    Run Keyword And Continue On Failure    Check Element    ${eleDMvalidatiomfirmware2radiobtn}
    sleep    ${sleepMin}
    Capture Page Screenshot
    Log    \nClick on radio button to see the details of the fetched Data Model\n
    ${radiocheck}=    Run Keyword    Execute Javascript    ${DataModelRadioButtonCheck}
    Log    ${radiocheck}
    Run Keyword    Should Be Equal    ${radiocheck}    true
    Run Keyword And Continue On Failure    Check Element    ${eleEditbutton}
    Run Keyword And Continue On Failure    Check Element    ${eleDMvalidationVersion}
    Run Keyword And Continue On Failure    Check Element    ${eleDMvalidationStatus}
    sleep    ${sleepMin}
    Capture Page Screenshot
    
Get operation check in Extenders
    Log    \nCheck available Wifi Points\n
    Check available WiFi points
    Log    \nGet operation check in Extender\n
    FOR    ${extender}    IN    @{meshNodes}
        ${extFriendlyName}    Set Variable    ${${extender}}[udefi_frn_name]
        Log    ${extFriendlyName}
        ${listExtender}    Get Text    ${eleWiFiPointDropdownList}
        Run Keyword If    '${${extender}_bconType}'!='B2' and '${${extender}_bconType}'!='B1.1'    Should Contain        ${listExtender}    ${extFriendlyName}
        ${Extender}    Replace String    ${elewifipointname}    INDEX    ${extFriendlyName}
        Run Keyword    Press Click Element    ${Extender}
        Capture Page Screenshot
        Check Valid Datamodel in Extender
        Check Invalid Datamodel in Extender    ${DataModelBrowserCheckCmd2}
        Run Keyword And Continue On Failure    Click Element    ${eleWiFiPointDropdown}
        sleep    ${sleepMin}
    END

Check Valid Datamodel in Extender
    Validate Autohelper option and data search    ${DataModelBrowserCheckCmd3}
    sleep    ${sleepMin}
    Validate Autohelper option and data search    ${DataModelBrowserCheckCmd4}
    sleep    ${sleepMin}

check Invalid Datamodel in Extender
    [Arguments]    ${DMCommand}
    ${DMCommand1}=    set variable    ${DMCommand}
    Enter Value    ${eleInputDMcommand}    ${DMCommand1}
    sleep    ${sleepMin}
    Log    Check for the result for the data search are shown
    Click Element    ${ApplybtninDMbrowser}
    sleep    ${sleepAvg}
    Capture Page Screenshot
    Verify the Toaster Message    Not supported by the WiFi point    timeout=60s
    sleep    ${sleepMin}
    Run Keyword And Continue On Failure    Page Should Not Contain Element    ${eleEditbutton}
    sleep    ${sleepMin}

Get operation check in ReadOnly Login
    Log    \nLogin with readonly role and check DM\n
    Login To Corteca Console    username=${tenant3readonlyCred}[uname]    paswd=${tenant3readonlyCred}[pswd]
    Open Corteca Console Home Page in readonly access
    Move to DataModelBrowserPage
    Check defaultFields in DataModelBrowserPage
    Validate Autohelper option and data search with Readonly Access    ${DataModelBrowserCheckCmd1}

Check entries are editable for DM
    Log    \nCheck specific entries are editable\n
    [Arguments]    ${DMCommand}    ${Selector}
    ${DMCommand1}=    set variable    ${DMCommand}
    Enter Value    ${eleInputDMcommand}    ${DMCommand1}
    sleep    ${sleepMin}
    Log    Check for the result for the data search are shown
    Click Element    ${ApplybtninDMbrowser}
    sleep    ${sleepAvg}
    Capture Page Screenshot
    Press Click Element    ${eleEditbutton}
    sleep    ${sleepMin}
    Capture Page Screenshot
    ${Value}=    Run Keyword    Execute Javascript    ${Selector}
    Log    ${Value}
    Run Keyword    Should not contain    ${Value}    'disabled'

