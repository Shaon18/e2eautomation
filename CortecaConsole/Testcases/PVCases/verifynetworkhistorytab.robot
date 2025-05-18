*** Settings ***
Library         String
Library         QWeb
Library         Collections
Library         Retry
Library         RequestsLibrary
Library         DateTime
Library         BuiltIn
Variables        ../../Locators/CortecaConsoleLocators.py
Resource        ../../Resources/KeywordDefinition/Qtwebkeywords.resource




*** Test Cases ***
BBDT-176377| NWCC_AIOC_TroubleshootingDashboard_05 | Verify Network History in Overview page
    [Documentation]    Check if the Network History lists a snapshot of recent 10 History events table.
    ...                Upon clicking 'see more' it should re-route to the Network history page and list the full history table.
    [Tags]    Both    smoke   pvcase
    [Teardown]    Qw.closebrowser
    Move To Home Dashboard
    UseTable    Description
    ${row}       GetTableRow     //last 
    Run Keyword If    '${row}'<'10.0'    Fail
    Qwebelement.clicktext    View all events    
    Sleep    ${sleepmin}
    Log    Should move to networkhistory tab
    ${res}    GetUrl
    Should Contain    ${res}    ${cloudDetail}[URL]/home-troubleshooting/network-history
    VerifyText    Event history / L1 Events

