*** Settings ***
Library    QWeb
Library    String
Resource    ../../KeywordDefinition/Qtwebkeywords.resource
Variables    CortecaConsole/Locators/CortecaConsoleLocators.py
Resource    CortecaConsole/Resources/KeywordDefinition/ApiRequest.resource


*** Keywords ***
LoginConsoleCheckFiberHealth
    Move To Home Dashboard
    QWeb.Log Screenshot
    ${Health}=    Qweb.Get Text     ${HealthStatus}
    ${rx}=        Qweb.Get Text     ${RxSignal}
    ${tx}=    Qweb.Get Text     ${TxSignal}
    ${trans}=    Qweb.Get Text     ${TransceiverTemp}
    ${status}    Run Keyword And Return Status    Should Start With    ${Root}[model]    XS
    ${HealthStatus}=    Run Keyword If        "${status}" == "True"    XSONTValidateHealthValues    ${Health}    ${rx}    ${tx}    ${trans}
    ...                    ELSE    GPONONTValidateHealthValues    ${Health}    ${rx}    ${tx}    ${trans}
    Should Be Equal    ${Health}    ${HealthStatus}


XSONTValidateHealthValues
    [Arguments]    ${Health}    ${rx_value}    ${tx_value}    ${trans_value}
    [Return]    ${HealthStatus}
    ${rx}=    Evaluate    int(${rx_value}[:-3])  # Extract the numeric part of VALUE
    ${rxHealth}=    Run Keyword If    ${rx} > -8 or ${rx} < -27    Set Variable   POOR
    ...               ELSE IF    -11 <= ${rx} <= -8 or -27 <= ${rx} <= -25    Set Variable    FAIR
    ...               ELSE IF    -25 < ${rx} < -11    Set Variable    GOOD
    ...               ELSE    Log    Signal value does not match any range.
    ${tx}=    Evaluate    int(${tx_value}[:-3])  # Extract the numeric part of VALUE
    ${txHealth}=    Run Keyword If    ${tx} > 10 or ${tx} < 4    Set Variable    BAD
    ...               ELSE IF    2 < ${tx} < 4 or 9 < ${tx} < 10    Set Variable    FAIR
    ...               ELSE IF    2 < ${tx} < 9    Set Variable    GOOD
    ...               ELSE    Log    Signal value does not match any range.
    ${trans}=    Evaluate    int(${trans_value}[:-3])  # Extract the numeric part of VALUE
    ${transHealth}=   Run Keyword If    ${trans} > 90    Set Variable    POOR
    ...               ELSE IF    85 <= ${trans} <= 90    Set Variable    FAIR
    ...               ELSE IF    ${trans} < 85    Set Variable    GOOD
    ...               ELSE    Log    Temperature value does not match any range.
    ${HealthStatus}=   Set Variable If        "${rxHealth}"=="GOOD" and "${txHealth}"=="GOOD" and "${transHealth}"=="GOOD"    Good    ELSE    Poor
    ${API_Response}=    GetResponse   ${API_URL_FiberHealth}    ${Root}[mac]
    ${response}=    Set Variable    ${API_Response}[0][quality]
    Run Keyword And Continue On Failure    Should Be Equal    ${rxHealth}    ${response}[downstream_signal]
    Run Keyword And Continue On Failure    Should Be Equal    ${txHealth}    ${response}[upstream_signal]
    Run Keyword And Continue On Failure    Should Be Equal    ${transHealth}    ${response}[temperature]

GPONONTValidateHealthValues
        [Arguments]    ${Health}    ${rx_value}    ${tx_value}    ${trans_value}
    [Return]    ${HealthStatus}
    ${rx}=    Evaluate    int(${rx_value}[:-3])  # Extract the numeric part of VALUE
    ${rxHealth}=    Run Keyword If    ${rx} > -8 or ${rx} < -27    Set Variable   POOR
    ...               ELSE IF    -11 <= ${rx} <= -8 or -27 <= ${rx} <= -25    Set Variable    FAIR
    ...               ELSE IF    -25 < ${rx} < -11    Set Variable    GOOD
    ...               ELSE    Log    Signal value does not match any range.
    ${tx}=    Evaluate    int(${tx_value}[:-3])  # Extract the numeric part of VALUE
    ${txHealth}=    Run Keyword If    ${tx} > 5 or ${tx} < 0.5    Set Variable    BAD
    ...               ELSE IF    0.5 <= ${tx} <= 1 or 4.5 <= ${tx} <= 5    Set Variable    FAIR
    ...               ELSE IF    1 < ${tx} < 4.5    Set Variable    GOOD
    ...               ELSE    Log    Signal value does not match any range.
    ${trans}=    Evaluate    int(${trans_value}[:-3])  # Extract the numeric part of VALUE
    ${transHealth}=   Run Keyword If    ${trans} > 90    Set Variable    POOR
    ...               ELSE IF    85 <= ${trans} <= 90    Set Variable    FAIR
    ...               ELSE IF    ${trans} < 85    Set Variable    GOOD
    ...               ELSE    Log    Temperature value does not match any range.
    ${API_Response}=    GetResponse   ${API_URL_FiberHealth}    ${Root}[mac]
    ${response}=    Set Variable    ${API_Response}[0][quality]
    Run Keyword And Continue On Failure    Should Be Equal    ${rxHealth}    ${response}[downstream_signal]
    Run Keyword And Continue On Failure    Should Be Equal    ${txHealth}    ${response}[upstream_signal]
    Run Keyword And Continue On Failure    Should Be Equal    ${transHealth}    ${response}[temperature]
    ${HealthStatus}=   Set Variable If        "${rxHealth}"=="GOOD" and "${txHealth}"=="GOOD" and "${transHealth}"=="GOOD"    Good    ELSE    Poor


       
    
