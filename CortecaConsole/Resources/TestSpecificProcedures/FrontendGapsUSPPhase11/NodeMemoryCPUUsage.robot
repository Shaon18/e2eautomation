*** Settings ***
Library    QWeb
Library    String
Resource    ../../KeywordDefinition/Qtwebkeywords.resource
Resource    CortecaConsole/Resources/TestSpecificProcedures/ExtenderOnboardingCGI.resource
Variables    CortecaConsole/Locators/CortecaConsoleLocators.py
Resource    CortecaConsole/Resources/KeywordDefinition/ApiRequest.resource


*** Keywords ***
CollectNodeMemory
    [Arguments]    ${mac}=${Root}[mac1]    ${ip}=${Root}[ip]    ${password2}=${Root}[telnet_vtysh]    ${status}=Good
    [Teardown]    QWeb.Close Browser
    SSHExecute    ${MemoryDM}    ${ip}    ${password2}
    SSHExecute    ${MemoryCheck}    ${ip}    ${password2}
    SSHExecute    ${FreeCheck}    ${ip}    ${password2}
    ${API_Response}=    GetResponse   ${API_URL_System_Info}    ${mac}
    Move To Home Dashboard
    Qwebelement.clicktext    Network
    Qwebelement.clicktext    ${mac}
    Sleep    ${sleepAvg}
    ScrollTo    WiFi point resources
    ${PersistentUsage}=    QWeb.Get text    ${PersistentMemoryUsage}
    #Run Keyword And Continue On Failure    Should Contain    ${PersistentUsage}    ${status}
    ${NonPersistentUsage}=    QWeb.Get text    ${NonPersistentMemoryUsage}
    Run Keyword And Continue On Failure    Should Contain    ${NonPersistentUsage}    ${status}
    QWeb.Log Screenshot    ${mac}_Memory.png
    
IncreaseMemoryAndCheck
    [Arguments]    ${mac}=${Root}[mac1]    ${ip}=${Root}[ip]    ${password2}=${Root}[telnet_vtysh]    ${status}=Poor
    SSHExecute    ${Increase_Memory}    ${ip}    ${password2}
    Run Keyword And Continue On Failure    CollectNodeMemory   ${mac}    ${ip}    ${password2}  ${status}

CollectNodeCPU
    [Arguments]    ${mac}=${Root}[mac1]    ${ip}=${Root}[ip]    ${password2}=${Root}[telnet_vtysh]    ${status}=Good
    [Teardown]    QWeb.Close Browser
    SSHExecute    ${Check_CPU}    ${ip}    ${password2}
    ${API_Response}=    GetResponse   ${API_URL_System_Info}    ${mac}
    Move To Home Dashboard
    Qwebelement.clicktext    Network
    Qwebelement.clicktext    ${mac}
    Sleep    ${sleepAvg}
    ScrollTo    WiFi point resources
    QWeb.Log Screenshot
    ${CPUUsageValue}=    QWeb.Get text    ${CPUUsage}
    Run Keyword And Continue On Failure    Should Contain    ${CPUUsageValue}    ${status}
    QWeb.Log Screenshot    ${mac}_CPU.png

IncreaseCPU
    [Arguments]    ${mac}=${Root}[mac1]    ${ip}=${Root}[ip]    ${password2}=${Root}[telnet_vtysh]    ${status}=Poor
    FOR    ${i}    IN RANGE    5
        Log    ${i}
        Run Keyword And Continue On Failure    SSHExecute    ${Increase_CPU}    ${ip}    ${password2}
        Sleep    5s
        Run Keyword And Continue On Failure    SSHExecute    ${Check_CPU}    ${ip}    ${password2}
    END
    Run Keyword And Continue On Failure    CollectNodeCPU    ${mac}    ${ip}    ${password2}  ${status}

ValidateCPUAlarm
    [Arguments]        ${mac}=${Root}[mac1]    ${ip}=${Root}[ip]    ${password2}=${Root}[telnet_vtysh]    ${Node}=Root
    Move To Home Dashboard
    Qwebelement.clicktext    Event history
    Qwebelement.clicktext    Alarms
    Qweb.ClickElement    ${AlarmMacList}
    Qwebelement.clicktext    ${mac}
    Qweb.ClickElement     ${AlarmList}
    Qwebelement.clicktext    Critical
    Sleep    ${sleepAvg}
    QWeb.Log Screenshot    
    ${mac}=    Convert To Lower Case    ${mac}
    ${mac}=    Replace String    ${mac}    -    :
    Qweb.IsText        ${mac}
    Qweb.IsText        CPU Utilization
    QWeb.Close Browser
    
ExecuteKeywordINExtender
    [Arguments]    ${Keyword}
    Log To Console    Get Extender IPs
    GetExtenderIP
    ${a}=    Set Variable    1
    ${i}=    Set Variable    0
    FOR    ${extender}    IN    @{meshNodes}
        Log To Console    Validate ${Keyword} in ${extender}
        Run Keyword    ${Keyword}    ${Ext${a}}[mac1]    ${Ext_ip}[${i}]    ${Ext${a}}[telnet_vtysh]
        ${i}=    Evaluate    ${i} + 1
        ${a}=    Evaluate    ${a} + 1
    END

KillCPUThreshold
    [Arguments]    ${mac}=${Root}[mac1]    ${ip}=${Root}[ip]    ${password2}=${Root}[telnet_vtysh]
    SSHExecute    ${Kill_Increase_CPU}    ${ip}    ${password2}
    
ValidateCPUAlarmAnalyticsDashboard
    [Arguments]        ${mac}=${Root}[mac1]    ${ip}=${Root}[ip]    ${password2}=${Root}[telnet_vtysh]    ${Node}=Root
    Set Library Search Order    Qweb    
    LoginTobrowserqweb
    Log To Console    moving to analytics page
    Qwebelement.clicktext    Analytics
    Qwebelement.clicktext    Events & alarms
    Sleep    ${sleepAvg}
    Qwebelement.clicktext    Alarms
    Click Element    ${AnalyticsMacField}
    Qweb.Type Text    ${AnalyticsMacField}    ${mac}
    Qwebelement.clicktext    Search
    Sleep    2s
    QWeb.Log Screenshot
    Qweb.ClickElement     ${AlarmList}
    Qwebelement.clicktext    Critical
    Qweb.ClickElement     ${AlarmTypeList}
    Click Element    ${AlarmTypeList_Unselect}
    Qwebelement.clicktext    CPU Utilization
    ${mac1}=    Convert To Lower Case    ${mac}
    ${mac1}=    Replace String    ${mac1}    -    :
    ${TableMAC}=    Qweb.Get Text  ${AnalyticsMacTable}
    Run Keyword And Continue On Failure    Should Be Equal    ${TableMAC}    ${mac1}
    QWeb.Log Screenshot
    Click Element    ${AnalyticsMacTable}
    Sleep    ${sleepMax}
    Qweb.ClickElement    ${AlarmMacList}
    Qwebelement.clicktext    ${mac}
    Qweb.ClickElement     ${AlarmList}
    Qwebelement.clicktext    Critical
    Sleep    ${sleepAvg}
    QWeb.Log Screenshot
    Qweb.IsText        ${mac1}
    Qweb.IsText        CPU Utilization
    QWeb.Close Browser
    
    
    

    
    
    
    
    


    


