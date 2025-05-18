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





*** Test Cases ***

BBDT-176374|NWCC_AIOC_TroubleshootingDashboard_02|Verify Network Diagnostic in Overview page
    [Documentation]    NWCC_AIOC_TroubleshootingDashboard_02  Verify Network Diagnostic in Overview page
    ...                Move To Troubleshooting Dashboard
    ...                Check if any problem is showing after network diagnostic
    ...                If problem is there we r redirected to the problem finder page. else we click recommendtaion page and are redirected to Detected problems page
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move To Home Dashboard
    VerifyNoText  Root WiFi point is offline.   5s
    VerifyText            Repeat diagnostic    300s
    ${result}      Run Keyword And Return Status        VerifyNoText    Network is healthy
    Log    ${result}
    IF    ${result}
        ${textget}=    Get Text    ${clickproblems}
        Click Element     ${clickproblems}
        LogScreenshot
        VerifyText        ${textget}
        VerifyText        Discover possible network problems by answering some simple questions
        Qwebelement.clicktext    Overview
        LogScreenshot
    END
    IF    ${result}
        Fail
    END
    Click Text     Recommendations        Repeat diagnostic
    VerifyText        Detected problems
    LogScreenshot
    
