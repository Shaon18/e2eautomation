*** Settings ***
Library    QWeb
Library    String
Library    Telnet
Library    Process
Library    Collections
Variables    ../../InputFiles/EnvironmentInput.py
Variables    ../../Locators/CortecaConsoleLocators.py
Variables    ../../Locators/WiFiOptimizationLocators.py
Variables    ../TestDatas.py
Variables    ../Resources/JavaScriptCodes/executeJavaScriptCodeCorteca.py
Resource    ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Variables    ../UITextDatas.py

*** Keywords ***
Login WifiOptimization Page in Home Console
    [Documentation]    Keyword to login to Wifi Optimization page
    Log To Console	Login WifiOptimization Page in Home Console
    LoginTobrowserqweb
    Qwebelement.clicktext    ${WifiOptimizationPage}
    VerifyText         ${WifiOptimizationPage}

Move To Group Model Page
    [Documentation]    Keyword to Move to Group Tab
    Login WifiOptimization Page in Home Console
    Sleep    2s
    ${status}    Run Keyword And Return Status    VerifyText    ${WifiOptimizationGroupTab}
    Run Keyword If    '${status}'=='False'    Qw.ExecuteJavaScript    ${expandSideBar}
    Sleep    2s
    Log To Console	Moving to GroupModel Tab
    QWeb.Click Element    ${eleGroupModel}
    VerifyText         ${WifiOptimizationGroupTab}
    Qwebelement.clicktext    ${WifiOptimizationModelTab}

Create Model Groups
    [Documentation]    Keyword to create Profile model and Model Group
    [Arguments]    ${modelGroupName}    ${modelProfile}    ${l2model}    ${existingGroupModelData}=${None}
    [Teardown]    Qw.closebrowser
    Log To Console    Search and delete if any existing group model available for ${l2model}
    Run Keyword If    ${existingGroupModelData}!=${None}    Model Group Search And Delete    ${existingGroupModelData}[Name]
    Log To Console    Creating a Profile Model
    Create A Profile Model    ${modelProfile}
    Log To Console    Creating a Group Model ${modelGroupName}
    Create Model Group     ${modelGroupName}    ${modelProfile}    ${l2model}
    
Create Model Group
    [Arguments]    ${modelGroupName}    ${modelProfile}    ${l2model}
    Log To Console    Creating a Group Model
    Move To Group Model Page
    Qwebelement.clicktext    ${WifiOptimizationGroupModelCreate}
    qwebelement.typetext    ${modelGroupName}    ${WifiOptimizationGroupModelCreateName}
    Qweb.ClickElement    ${selectModelProfileForGroupModelCreateClick}
    Qwebelement.clicktext    ${modelProfile}
    Qweb.ClickElement    ${selectSupplyAndModelForGroupModelCreate}
    Qwebelement.clicktext    ${l2model}
    Qwebelement.clicktext    ${SaveChangesButton}
    VerifyText    ${WifiOptimizationModelGroupNameCreateSuccess}
    Log To Console    Group Model Creation Success

Search Groups Model
    [Documentation]    Keyword to Search for a Model Group
    [Arguments]     ${l2model}    ${hearderLen}=3
    [Teardown]    Qw.closebrowser
    Move To Group Model Page
    Log to console	Get exiting data for model profile for ${l2model}
    ${status}    Set Variable    ${False}
    ${rowData}    Set Variable    ${EMPTY}
    WHILE    not ${status}
        ${textStatus}    Run Keyword And Return Status    VerifyText         ${l2model}
        ${rowData}    Run Keyword If    ${textStatus}    Get Group Model row data     ${l2model}
        Exit For Loop If    ${textStatus}
        ${paginationEnd}    GetAttribute    ${GroupModelPaginationEndCheck}    class
        Log To Console    ${paginationEnd}
        ${statusPagination}    Run Keyword And Return Status    Should Match Regexp    ${paginationEnd}    ${WifiOptimizationGroupPaginationEnd}
        Run Keyword If    '${statusPagination}'!='True'     QWeb.ClickElement    ${GroupModelPaginationEndCheck}
        ${status}    Set Variable If    ${textStatus} or ${statusPagination}    ${True}    ${False}
    END
    Return From Keyword    ${rowData}

Get Group Model row data
    [Documentation]    Creating the dictionary of model group details for given device model
    [Arguments]     ${l2model}
    Log To Console    Creating the dictionary of model group details for given device model
    ${heards}    Create List    Name    	Model profile    Supplier & model
    ${row}    Replace String    ${GroupModelTableRowText}    MODEL     ${l2model}
    ${j}    Set Variable    0
    ${rowDetails}    Create Dictionary
    FOR    ${i}    IN RANGE    1    4
        ${data}    Qweb.GetText    ${row}//td[${i}]
        ${header}  Qweb.GetText    ${GroupModelTableHeaderText}//th[${i}]
        Set To Dictionary    ${rowDetails}    ${header}    ${data}
    END
    Return From Keyword    ${rowDetails}

Model Group Search And Delete
    [Documentation]    keyword to search for a group model name and delete if match found
    [Arguments]    ${modelGroupName}
    [Teardown]    Qw.closebrowser
    Move To Group Model Page
    Log to console	Get exiting data for model group ${modelGroupName}
    Model Group Name Search    ${modelGroupName}
    Sleep    ${sleepMin}
    Log To Console    Deleting the group model
    Qw.ExecuteJavaScript    ${groupModelDelete}
    Sleep    ${sleepMin}
    Qwebelement.clicktext    ${DeleteButton}
    VerifyText    ${WifiOptimizationModelGroupNameDeleteSuccess}
    Sleep    ${sleepMin}
    Model Group Name Search    ${modelGroupName}    deleteCheck=${True}
    
Model Group Name Search
    [Documentation]    Keyword to search for the given group model name and check
    [Arguments]    ${modelGroupName}    ${deleteCheck}=${False}
    Log To Console    Searching for ${modelGroupName}
    qwebelement.typetext    ${modelGroupName}    ${WifiOptimizationModelGroupNameSearch}
    QWeb.Click Element    ${btnWifiOptimizationModelGroupSearch}
    Sleep    ${sleepMin}
    Save Screenshot
    ${status}    Run Keyword And Return Status    VerifyText         ${modelGroupName}
    Run Keyword If	${deleteCheck}    Should Not Be True    ${status}    
    ...    ELSE    Should Be True    ${status}
    Sleep    ${sleepMin}

Create A Profile Model
    [Documentation]    Keyword to create a profile model
    [Arguments]    ${profileName}
    [Teardown]    Qw.closebrowser
    Log To Console    Creating a profile Model ${profileName}
    Login WifiOptimization Page in Home Console
    Sleep    2s
    Qwebelement.clicktext    ${WifiOptimizationProfileTab}
    Sleep    ${sleepMin}
    Qwebelement.clicktext    ${WifiOptimizationModelTab}
    Sleep    ${sleepMin}
    Qwebelement.clicktext    ${WifiOptimizationProfileCreate}
    qwebelement.typetext    ${profileName}    ${WifiOptimizationProfileCreate}
    Qwebelement.clicktext    ${CreateButton}
    VerifyText    ${WifiOptimizationProfileCreateSuccess}
    Log To Console    Creating a profile Model Success for ${profileName}


Verify Model Name In Device Feature Status
    [Documentation]    Keyword to check the Model profile updation in radio management page for given device model
    [Arguments]    ${modelProfileName}    ${modelProfile}    ${deviceModelL2}    ${deviceFriendlyName}=${Root}[udefi_frn_name]
    [Teardown]    Qw.closebrowser
    Log To Console    Verifying radiomanagemnet Page updated for ${deviceModelL2}
    Move To Home Dashboard
    Qwebelement.clicktext    ${RadioManagementTab}
    Sleep    ${SleepMin}
    Qwebelement.clicktext     ${deviceFriendlyName}
    Sleep    ${SleepMin}
    VerifyText    ${modelProfileName}
    Qwebelement.clicktext    ${modelProfileName}
    VerifyText    ${modelProfileName}
    VerifyText    ${modelProfile}
    VerifyText    ${deviceModelL2}
    Save Screenshot

Group Model Edit
    Log To Console    Editing the Group model
    [Arguments]    ${GroupModelName}    ${ModelGroupModelProfileNewName}
    [Teardown]    Qw.closebrowser
    Log To Console    Creating a Profile Model
    Create A Profile Model    ${ModelGroupModelProfileNewName}
    Move To Group Model Page
    Log to console	Get exiting data for model profile
    Model Group Name Search    ${GroupModelName}
    Sleep    ${sleepMin}
    Log To Console    Editing the group model
    QWeb.Click Element    ${btnWifiOptimizationModelGroupNameEdit}
    Sleep    ${sleepMin}
    Qweb.ClickElement    ${selectModelProfileForGroupModelCreateClick}
    Qwebelement.clicktext    ${ModelGroupModelProfileNewName}
    Qwebelement.clicktext    ${SaveChangesButton}
    VerifyText    ${WifiOptimizationModelGroupEditSuccess}
    Log To Console    Group Model Edit Success

Group Model Teardown
    [Documentation]    keyword for Group Model teardown. Deleting the profile model and group model created. Also revert to old configs if any
    [Arguments]    ${modelProfileTestDetails}    ${configDefault}
    Log To Console    Deleting configured Group and Profile models
    Run Keyword And Continue On Failure    Model Group Search And Delete    ${modelProfileTestDetails}[ModelName]
    Run Keyword And Continue On Failure    Profile Model Search And Delete    ${modelProfileTestDetails}[ModelProfile]
    Run Keyword And Continue On Failure    Profile Model Search And Delete    ${modelProfileTestDetails}[ModelProfileEditName]
    Log To Console    Reverting to DefaultConfig
    Run Keyword If    ${configDefault}!=${None}    Create Model Group    ${configDefault}[Name]    ${configDefault}[Model profile]    ${configDefault}[Supplier & model]

Profile Model Search And Delete
    [Documentation]    keyword to search for a group model name and delete
    [Arguments]    ${profileModelName}
    [Teardown]    Qw.closebrowser
    Login WifiOptimization Page in Home Console
    Sleep    2s
    Qwebelement.clicktext    ${WifiOptimizationProfileTab}
    Sleep    ${sleepMin}
    Qwebelement.clicktext    ${WifiOptimizationModelTab}
    Sleep    ${sleepMin}
    Log to console	Get exiting data for model profile
    Profile Model Name Search    ${profileModelName}
    Sleep    ${sleepMin}
    Log To Console    Deleting the model profile
    ${selector}    Replace String    ${btnWifiOptimizationProfileModelDelete}    PROFILE    ${profileModelName}
    QWeb.Click Element    ${selector}
    Sleep    ${sleepMin}
    Qwebelement.clicktext    ${DeleteButton}
    VerifyText    ${WifiOptimizationProfileModelNameDeleteSuccess}
    Sleep    ${sleepMin}
    Log to console	Check model profile after delete
    Profile Model Name Search    ${profileModelName}    deleteCheck=${True}

Profile Model Name Search
    [Documentation]    Keyword to search the given profile model and check the existence based on deleteCheck flag
    [Arguments]    ${profileModelName}    ${deleteCheck}=${False}
    Log To Console    Searching for ${profileModelName}
    qwebelement.typetext    ${profileModelName}    ${WifiOptimizationProfileModelNameSearch}
    QWeb.Click Element    ${btnWifiOptimizationModelGroupSearch}
    Sleep    ${sleepMin}
    Save Screenshot
    ${status}    Run Keyword And Return Status    VerifyText         ${profileModelName}
    Run Keyword If	${deleteCheck}    Should Not Be True    ${status}
    ...    ELSE    Should Be True    ${status}
    Sleep    ${sleepMin}
