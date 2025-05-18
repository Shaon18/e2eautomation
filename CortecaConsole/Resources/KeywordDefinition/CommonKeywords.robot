*** Settings ***
Library     SeleniumLibrary
Library     Process

Library    Process
Library    String
Variables    ../../Locators/KeycloakLocators.py
Variables    ../../InputFiles/EnvironmentInput.py

*** Keywords ***
MeshElements
    Log    \n\n\n\nMesh Elements releated Variables\n\n
    Set Global Variable    ${ont_ip}    ${Root}[ip]
    Set Global Variable    ${cliport}    ${Root}[telnet\_port]
    Set Global Variable    ${telnet_uname}    ${Root}[telnet\_username]
    Set Global Variable    ${telnet_pswd}    ${Root}[telnet\_password]
    Set Global Variable    ${telnet_vtysh}    ${Root}[telnet\_vtysh]


Enter Value
    [Documentation]    This function will wait for the locator provided and enter the value:
    ...    - Argument1: inputSelector-> locator of the input.
    ...    - Argument2: value-> Value need to be enter.
    ...    - Argument3: timeout-> default 5s.
    [Arguments]    ${inputSelector}    ${value}    ${timeout}=5s
    Wait Until Element Is Visible    ${inputSelector}    ${timeout}
    Input Text    ${inputSelector}    ${value}

Press Click button
    [Documentation]    This function will wait for the Button locator and click the locator once visible:
    ...    - Argument1: clickSelector-> locator of the button
    ...    - Argument2: timeout-> default 5s.
    [Arguments]    ${clickSelector}    ${timeout}=5s
    #Wait Until Element Is Visible    ${clickSelector}    ${timeout}
    Check Element    ${clickSelector}    ${timeout}
    Click Button    ${clickSelector}

Press Click Element
    [Documentation]    This function will wait for the Element locator and click the locator once visible:
    ...    - Argument1: clickElement-> locator of the element
    ...    - Argument2: timeout-> default 5s.
    [Arguments]    ${clickElement}    ${timeout}=15s
    #Wait Until Element Is Visible    ${clickElement}    ${timeout}
    Check Element    ${clickElement}    ${timeout}
    Click Element    ${clickElement}

Check Element
    [Documentation]    This function will scroll Element locator and check the locator once visible:
    ...                - Argument1: clickElement-> locator of the element
    ...                - Argument2: timeout-> default 5s.
    [Arguments]    ${Element}    ${timeout}=15s
    Wait Until Page Contains Element    ${Element}    ${timeout}
    Scroll Element Into View    ${Element}
    Wait Until Page Contains Element    ${Element}    ${timeout}
    Page Should Contain Element    ${Element}    ${timeout}
    Capture Page Screenshot



Get Text Data
    [Documentation]    This function will get the text of the Element locator:
    ...                - Argument1: clickElement-> locator of the element
    ...                - Argument2: timeout-> default 5s.
    [Arguments]    ${Element}    ${timeout}=10s
    Wait Until Element Is Visible    ${Element}    ${timeout}
    ${Text}=    Run keyword    SeleniumLibrary.Get Text    ${Element}
    Return From Keyword    ${Text}

Get Value
    [Documentation]    This function will get the value of the Element locator:
    ...                - Argument1: clickElement-> locator of the element
    ...                - Argument2: timeout-> default 5s.
    [Arguments]    ${Element}    ${timeout}=5s
    Wait Until Element Is Visible    ${Element}    ${timeout}
    ${Value}=    Run keyword    SeleniumLibrary.Get Value    ${Element}
    Return From Keyword    ${Value}

Open Portal
    [Documentation]    This function will open the url provided with the given browser
    ...    - Argument1: browserUrl-> URL of the site
    ...    - Argument2: browser-> Browser in which url need to be open. eg: Chrome.
    [Arguments]    ${browserUrl}    ${browser}
    ${result} =    Run Process    python    ${currentdirectoryfolder}\auto_installer_chrome.py
#    Open Browser    ${browserUrl}    ${browser}    options=add_argument("--auto-open-devtools-for-tabs")
    Open Browser    ${browserUrl}    ${browser}
    # Open Browser    ${browserUrl}    Chrome
    Maximize Browser Window

Close Portal
    [Documentation]    This function will close all the open browsers
    Close All Browsers

Select From Dropdown Item
    [Documentation]    This function used to select the dropdow item
    ...                - Arguments:
    ...                    dropDownClickSelector-> locator of the dropdown click
    ...                    dropDownItemSelect -> locator for the dropdown item select
    [Arguments]    ${dropDownClickSelector}    ${dropDownItemSelect}
    Mouse Over    ${dropDownClickSelector}
    Capture Page Screenshot
    Click Element    ${dropDownClickSelector}
    Capture Page Screenshot
    #Mouse Over    ${dropDownItemSelect}
    #Capture Page Screenshot
    #Mouse Down    ${dropDownItemSelect}
    #Capture Page Screenshot
    Click Element    ${dropDownItemSelect}
    Capture Page Screenshot
    ${status}    Run Keyword And Return Status    Press Click Element    ${dropDownItemSelect}
    Run Keyword If    ${status}    Click Element    ${dropDownClickSelector}


Upload A File
    [Documentation]    This function used to upload a file using choose button
    ...                - Arguments:
    ...                    chooseFileSelector-> choose file locator
    ...                    filePath -> source file path of uploading file
    ...                    child  -> index if choose file locator having multiple buttons
    [Arguments]    ${chooseFileSelector}    ${filePath}    ${child}=1
    ${uploadFile}    Replace String    ${chooseFileSelector}    INDEX    ${child}
    Check Element    ${uploadFile}
    Sleep    5s
    Log    **** Uploading the ${filePath} ****
    Choose File    ${uploadFile}    ${filePath}
    Capture Page Screenshot

Get the Toaster Message
    [Documentation]    This function used validate the toaster and return the toaster message
    ...                - Arguments:
    ...                    toasterTextSelector-> toaster card locator
    ...                    toasterCloseSelector -> toaster card close button locator
    ...                    timeout->Max time to wait for the toaster card
    [Arguments]    ${toasterTextSelector}    ${toasterCloseSelector}    ${timeout}
    Log    ${timeout}
    Wait Until Element Is Enabled    ${eleToaster}    timeout=${timeout}
    Wait Until Element Is Visible    ${eleToaster}    timeout=${timeout}
    #Wait Until Page Contains Element    ${eleToaster}    timeout=${timeout}
    ${toasterMsg}    Get Text    ${toasterTextSelector}
    Run Keyword And Ignore Error    Capture Element Screenshot    ${toasterTextSelector}
    #Run Keyword And Ignore Error    Press Click Element    ${toasterCloseSelector}
    Run Keyword And Continue On Failure    Execute Javascript    ${closeToaster}
    Wait Until Element Is Not Visible    ${eleToaster}    timeout=${timeout}
    Run Keyword And Ignore Error    Capture Element Screenshot    ${toasterTextSelector}
    Return From Keyword    ${toasterMsg}

Cron Tab Toggle
    [Documentation]    This function enable disable the cron tabs
    ...                - Arguments:
    ...                    checkedSelector-> Locator to check the status of cron tab 'checked' attribute
    ...                    toggleSelector -> locator to click the toggle
    ...                    expectedStatus  -> cron tab toggle status expected
    [Arguments]    ${checkedSelector}    ${toggleSelector}    ${expectedStatus}
    Check Element    ${checkedSelector}
    ${expectedStatus}    Convert To Lower Case    ${expectedStatus}
    #${currentStatus}    Get Element Attribute    ${checkedSelector}    checked
    ${checkedSelectorForJavascript}    Fetch From Right    ${checkedSelector}    css=
    ${cronTabStatus}    Replace String   ${campaignToggle}     SELECTOR    ${checkedSelectorForJavascript}
    ${currentStatus}    Execute Javascript    ${cronTabStatus}
    ${currentStatus}    Convert To Lower Case    ${currentStatus}
    Log    ${currentStatus}
    Run Keyword If    '${currentStatus}'!='${expectedStatus}'    Press Click Element    ${toggleSelector}

Fetch SVG Graph Values
    [Documentation]    This function used to fetch the graph values
    ...                - Arguments:
    ...                    highChartXpath-> Graph high chart Locator
    ...                    tooltipXpath -> Graph tool tip Locator
    ...                    max_count    -> Number of tool tips need to check
    ...                    flag  -> if flag true it will iterate until 'max_count' if false-> iterate through all tooltips available
    [Arguments]    ${highChartXpath}    ${tooltipXpath}    ${max_count}=10    ${flag}=False
    Check Element    ${highChartXpath}
    Mouse Over    ${highChartXpath}
    ${graphelement_svg}    Get Webelements    ${highChartXpath}
    ${graphelement_svg_len}    Get Length    ${graphelement_svg}
    # ${max_count} is the maximum search need to perform.    # if ${flag} is true the ${max_count} will set to value passed else it will iterate till ${graphelement_svg_len}
    ${max_count}    Run Keyword If    ${flag}    Set Variable If    ${graphelement_svg_len}>= ${max_count}    ${max_count}    ${graphelement_svg_len}
    ...    ELSE    Set Variable    ${graphelement_svg_len}
    ${graphelement_list}    Create List
    FOR    ${index}    IN RANGE    0    ${max_count}
        Log    ${graphelement_svg}[${index}]
        ${status_mouseover}    Run Keyword And Return Status    Mouse Over    ${graphelement_svg}[${index}]
        ${status}    Run Keyword If    ${status_mouseover}    Run Keyword And Return Status    Page Should Contain Element    ${tooltipXpath}
        ${graphvalue}    Run Keyword If    ${status}    Get Text    ${tooltipXpath}
        Run Keyword If    ${status}     Append To List    ${graphelement_list}    ${graphvalue}
    END
    Return From Keyword    ${graphelement_list}

Create Dictionary From CSV
    [Documentation]    This function used to create a dictonary from csv
    ...                - Arguments:
    ...                    csvData-> csv file
    ...                    whichIndexAsKey -> dictonary key select from which index
    ...                - Return:
    ...                        dataDict -> Dictonary of csv
    [Arguments]    ${csvData}    ${whichIndexAsKey}=0
    Log    ${csvData}[0]
    ${csvHeaders}    Split String    ${csvData}[0]    ,
    ${headerLen}    Get Length    ${csvHeaders}
    ${csvDataLength}    Get Length    ${csvData}
    ${dataDict}    Create Dictionary
    FOR    ${i}    IN RANGE    1    ${csvDataLength}
	    ${rowData}    Split String    ${csvData}[${i}]    ,
	    ${rowDataLen}    Get Length    ${rowData}
	    Continue For Loop If    '${rowDataLen}'<='1'
	    ${entry}    Evaluate    dict(zip(${csvHeaders},${rowData}))
	    Set To Dictionary    ${dataDict}    ${rowData}[${whichIndexAsKey}]=${entry}
    END
    Log	${dataDict}
    Return From Keyword    ${dataDict}

Get the wifi band details
    [Arguments]    ${bconType}
    Log    Get the wifi band details for ${bconType}
    ${DeviceBand}=    Check wifi band    ${bconType}
    @{WifiBands}=    Create List
    Set Test Variable    @{WifiBands}
    @{WifiBands}    Set Variable    ${WifiBandList}[${DeviceBand}]
    Log    ${WifiBands}
    Return From Keyword    ${WifiBands}

Check wifi band
    [Arguments]    ${bconType}
    Log    Get the wifi band details for ${bconType}
    ${DeviceBand}=    Run Keyword If    '${bconType}' in ${DeviceBandList}[Dual Band]    Set Variable    Dual Band
    ...    ELSE IF    '${bconType}' in ${DeviceBandList}[Tri Band]    Set Variable    Tri Band
    ...    ELSE IF    '${bconType}' in ${DeviceBandList}[Tri Band 6G]    Set Variable    Tri Band 6G
    ...    ELSE IF    '${bconType}' in ${DeviceBandList}[Quad Band]    Set Variable    Quad Band
    ...    ELSE    Set Variable    None
    Log    ${DeviceBand}
    Return From Keyword    ${DeviceBand}


Fetch SVG Graph Values from Advanced Metrics
    [Documentation]    This function used to fetch the graph values
    ...                - Arguments:
    ...                    highChartXpath-> Graph high chart Locator
    ...                    tooltipXpath -> Graph tool tip Locator
    ...                    max_count    -> Number of tool tips need to check
    ...                    flag  -> if flag true it will iterate until 'max_count' if false-> iterate through all tooltips available
    [Arguments]    ${highChartXpath}    ${tooltipXpath}    ${max_count}=10    ${flag}=False

    Check Element    ${highChartXpath}
    Mouse Over    ${highChartXpath}
    ${graphelement_svg}    Get Webelements    ${highChartXpath}
    ${graphelement_svg_len}    Get Length    ${graphelement_svg}
    # ${max_count} is the maximum search need to perform.    # if ${flag} is true the ${max_count} will set to value passed else it will iterate till ${graphelement_svg_len}
    ${max_count}    Run Keyword If    ${flag}    Set Variable If    ${graphelement_svg_len}>= ${max_count}    ${max_count}    ${graphelement_svg_len}
    ...    ELSE    Set Variable    ${graphelement_svg_len}
    ${graphelement_list}    Create List
    FOR    ${index}    IN RANGE    0    ${max_count}
        Log    ${graphelement_svg}[${index}]
        ${status_mouseover}    Run Keyword And Return Status    Mouse Over    ${graphelement_svg}[${index}]
        ${status}    Run Keyword If    ${status_mouseover}    Run Keyword And Return Status    Page Should Contain Element    ${tooltipXpath}
        ${graphvalue}    Run Keyword If    ${status}    Get Text    ${tooltipXpath}
        Run Keyword If    ${status}     Append To List    ${graphelement_list}    ${graphvalue}
    END
    Return From Keyword    ${graphelement_list}

Verify_Email_New
    [Arguments]    ${email_id}=${Account}[Email]    ${url}=${Account}[Key_URL]   ${browser}=${browserOption}    ${username}=${Account}[userName]    ${paswd}=${Account}[password]
    [Teardown]    Close All Browsers
    Log to console	Verify Email from Keycloak
        Open Portal   ${url}    ${browser}
    Enter Value    ${txtInputUsername}   ${username}
    Enter Value    ${txtInputPassword}   ${paswd}
    Press Click Button    ${btnLogin}
    Sleep	${sleepAvg}
    Comment    Selenium2Library.Go To	${Key_Cloak_URL}
    Select_User_Mail	${email_id}
    Sleep	${sleepMin}
    Click Element	${RemoveRequiredTag}
    Sleep	${sleepMin}
    #Click Element	${CloseRequiredTag}
    #sleep	${sleepMin}
    Click Element	${EmailVerified}
    Sleep	${sleepMin}
    Click Button	${SaveButton}
    sleep	${sleepMin}

Select_User_Mail
    [Arguments]    ${email}=${NewUser_Credentials1}['email']
    Sleep	${sleepAvg}
    Click Element	${SearchUser}
    FOR	${i}	IN RANGE	0	5
        ${PS}=	Run Keyword And Return Status	Input Text	${SearchUser}	${email}
        Run Keyword If	${PS}	Exit For Loop
    END
    Sleep	2s
    Click Element	${SearchButton}
    FOR	${a}	IN RANGE	0	5
        ${Email_id_status}=	Run Keyword And Return Status	Table Should Contain	${SearchTable}	${email}
        Exit For Loop If	'${Email_id_status}'=='True'
        Sleep	5s
    END
    Click Element	${Tabledata}
    Sleep	5s


Create CSV File
    [Arguments]    ${csvFileName}
    ${csvFile}  Set Variable    ${currentdirectoryfolder}/${csvFileName}.csv
    Create File    ${csvFile}
    Return From Keyword    ${csvFile}

Append to CSV
    [Arguments]    ${csvFile}    ${data}
    Append To File    ${csvFile}  ${data}

Get Start Time Portal
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


Get End Time Portal
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

Should Contain All Strings
    [Arguments]    ${output}    @{expected}
    FOR    ${item}    IN    @{expected}
        Should Contain    ${output}    ${item}
    END
