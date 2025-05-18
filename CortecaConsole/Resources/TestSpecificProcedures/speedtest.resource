*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Variables           ../../Locators/CortecaConsoleLocators.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource
Variables            ../../Resources/TestDatas.py




*** Keywords ***


Verify SPeed test card
    Click Text         Speed Test      Settings
    LogScreenshot
    VerifyText         New speed test       100s
    Qwebelement.clicktext        New speed test
    VerifyText         New speed test       100s
    LogScreenshot
    ${res1}     Get Text       ${downspeedleft}
    ${res2}     Get Text        ${uploadspeedleft}
    ${res3}     Get Text        ${ping}
    ${res4}    Get Text        ${jitter}
    FOR    ${i}    IN RANGE    1    4
        Run Keyword And Continue On Failure    Should Not Be Equal As Numbers    ${res${i}}        0
    END



Check speed test history table
    Click Text         Speed Test      Settings
    LogScreenshot
    VerifyText         New speed test       100s
    Qwebelement.clicktext        New speed test
    VerifyText         New speed test       100s
    Sleep     5s
    LogScreenshot
    ${res1}     Get Text       ${downspeedleft}
    ${res2}     Get Text        ${uploadspeedleft}
    ${res3}     Get Text        ${ping}
    ${res4}    Get Text        ${jitter}
    ${ret1}     Get Text        ${downloadspeedright}
    ${ret2}     Get Text        ${uploadspeedright}
    ${ret3}     Get Text        ${ping_right}
    ${ret4}     Get Text        ${jitter_right}
    ${ret5}     Get Text        ${server_name_right}
    ${ret6}     Get Text        ${server_mode_right}   
    
    FOR    ${i}    IN RANGE    1    5
        Run Keyword And Continue On Failure    Should Be Equal As Numbers       ${res${i}}        ${ret${i}}
    END
    Run Keyword And Continue On Failure    Should Be Equal As Strings            ${ret5}    ${defaultServer}
    Run Keyword And Continue On Failure    Should Be Equal As Strings           ${ret6}    ${defaultSpeedTestMode}
    